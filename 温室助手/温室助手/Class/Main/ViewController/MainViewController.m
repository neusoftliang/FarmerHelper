//
//  MainViewController.m
//  温室助手
//
//  Created by neusoftliang on 16/1/23.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "MainViewController.h"
#import "WeatherNetManager.h"
#import "CityNetManager.h"
#import "WeatherIconManager.h"
#import "WeatherListViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface MainViewController ()<CLLocationManagerDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
#pragma mark news Property
@property (weak, nonatomic) IBOutlet UILabel *newsContent;
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (strong,nonatomic) CLLocationManager *manager;
@property (strong,nonatomic) CLGeocoder *geocoder;
#pragma mark --- 天气模块
@property (weak, nonatomic) IBOutlet UILabel *weatherDate_label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_weather;
@property (weak, nonatomic) IBOutlet UILabel *label_hltemp;
@property (weak, nonatomic) IBOutlet UILabel *label_fengxiang;
@property (weak, nonatomic) IBOutlet UILabel *label_weatherState;
@property (strong,nonatomic) NSUserDefaults *defaults;
@property (strong,nonatomic) UIAlertView *alertView;
@property (strong,nonatomic) WeatherModel *weatherModel;
@end

@implementation MainViewController

-(NSUserDefaults *)defaults
{
    if (_defaults==nil) {
        _defaults=[NSUserDefaults standardUserDefaults];
    }
    return _defaults;
}

-(CLGeocoder *)geocoder
{
    if (_geocoder==nil) {
        _geocoder=[[CLGeocoder alloc]init];
    }
    return _geocoder;
}
-(CLLocationManager *)manager
{
    if (_manager==nil) {
        _manager = [CLLocationManager new];
        _manager.delegate = self;
    }
    return _manager;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self updateWeatherData];
}

-(void)updateWeatherData
{
    [self getWeatherByCityName:[self.defaults valueForKey:@"cityname"] andCityID:[[self.defaults valueForKey:@"cityid"] integerValue]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLocation];
}
#pragma mark --- 定位
-(void)getLocation
{
    if ([[UIDevice currentDevice].systemVersion doubleValue]>=8.0)
    {
        [self.manager requestWhenInUseAuthorization];
    }else{
        [self.manager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
            //用户允许在使用期间定位(前台)
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            //设定定位精确度
            self.manager.desiredAccuracy = kCLLocationAccuracyBest;
            //开始定位操作
            [self.manager startUpdatingLocation];
            break;
            //用户不允许定位(第二种方案)
        case kCLAuthorizationStatusDenied:
            [self chooseCity];
            break;
        default:
            break;
    }
    
}
/**
 *  选择城市
 */
-(void)chooseCity
{
    self.alertView.hidden = NO;
    [self.alertView show];
    self.alertView.delegate = self;
}
#pragma mark --- UIAlertDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *textField = [alertView textFieldAtIndex:0];
    if (textField.text.length!=0) {
       [self getCityByCityName:textField.text];
    }
    alertView.delegate = nil;
    [alertView removeFromSuperview];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    //停止定位
    
    [self.manager stopUpdatingLocation];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        MYLog(@"error%@",error);
        NSLog(@"latitude:%f; longitude:%f", location.coordinate.latitude, location.coordinate.longitude);
        if (!error) {
            [self showMBHUD:@"定位成功！！！"];
            for (CLPlacemark *placemark in placemarks) {
                NSString *city =placemark.addressDictionary[@"SubLocality"];
                if (city.length==0)
                {
                    city=placemark.addressDictionary[@"City"];
                }
                [self getCityByCityName:[city substringToIndex:city.length-1]];
            }
            
        }else
        {
            [self showMBHUD:@"定位失败，请重新定位！！！"];
        }
    }];

}

/**
 *
 *  根据反地理编码获得到当前城市，进而获取到城市Model
 */
-(id) getCityByCityName:(NSString *)cityName
{
      __block CityModel *city = nil;
     [CityNetManager getCityByCityName:cityName completionHandle:^(id model, NSError *error) {
          city = model;
         if (!city.errNum) {
            
             dispatch_async(dispatch_get_global_queue(0, 0), ^{
                 [self getWeatherByCityName:city.retData.cityName andCityID:[city.retData.cityCode integerValue]];
             });
         }
    }];
    return city;
}
-(void) getWeatherByCityName:(NSString*)name andCityID:(NSUInteger)cityid
{
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:name forKey:@"cityname"];
    [defaults setObject:[NSNumber numberWithInteger:cityid] forKey:@"cityid"];
    WeatherIconManager *iconManager = [WeatherIconManager sharedWeatherIcon];
    [WeatherNetManager getWidtherByCityID:cityid andCityName:name completionHandle:^(id model, NSError *error) {
        WeatherModel *weather = model;
        self.weatherModel = weather;
        if (!weather.errNum) {
            Today *today = weather.retData.today;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.weatherDate_label.text = today.date;
                self.label_hltemp.text = [NSString stringWithFormat:@"%@  %@/%@",today.curTemp,today.hightemp,today.lowtemp];
                self.label_fengxiang.text = [NSString stringWithFormat:@"%@/%@",today.fengxiang,today.fengli];
                self.imageView_weather.image = [iconManager getIconByWeatherType:today.type];
                self.label_weatherState.text = today.type;
            });
            [defaults setObject:today.curTemp forKey:@"todytemp"];
        }
    }];
}
#pragma mark --- 新闻详情跳转
- (IBAction)newsBtnClick:(id)sender {
    
}
#pragma mark --- 天气详情跳转
- (IBAction)weatherBtnClick:(id)sender {
    [self performSegueWithIdentifier:@"weather" sender:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"weather"]) {
        WeatherListViewController *weatherVC = segue.destinationViewController;
        weatherVC.weather = self.weatherModel;
    }
}
#pragma mark --- 预警设置跳转
- (IBAction)settingWarningBtnClick:(id)sender {
}
#pragma mark --- 农业技术学习跳转
- (IBAction)learnTech:(id)sender {
}
#pragma mark --- 采集光线强度跳转
- (IBAction)getLightValueClick:(id)sender {
}
#pragma mark --- 查看笔记
- (IBAction)noteWatchClick:(id)sender {
}
#pragma mark --- 记录
- (IBAction)writeNoteClick:(id)sender {
}
#pragma mark --- 定位
- (IBAction)searchCity:(id)sender {
    [self getLocation];
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            //定位功能可用，开始定位
            [self.manager startUpdatingLocation];
        }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        [self chooseCity];
    }
}

/**
 *  消息提示框
 *
 *  @param content 要提示的内容
 */
-(void)showMBHUD:(NSString *)content
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = content;
    //隐藏时从父视图中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = YES;
    [hud hide:YES afterDelay:1];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.weatherModel = nil;
}
- (UIAlertView *)alertView {
	if(_alertView == nil) {
        _alertView = [[UIAlertView alloc]initWithTitle:@"城市选择" message:@"请手动输入当前城市" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        _alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
	}
	return _alertView;
}

@end
