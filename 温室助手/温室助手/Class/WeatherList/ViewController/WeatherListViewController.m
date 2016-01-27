//
//  WeatherListViewController.m
//  温室助手
//
//  Created by neusoftliang on 16/1/26.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "WeatherListViewController.h"
#import "WeatherTableViewCell.h"
#import "WeatherIconManager.h"
#import "HeaderScrollView.h"
@interface WeatherListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView_weather;
@property (strong,nonatomic) HeaderScrollView *headerScroll;
@end

@implementation WeatherListViewController
static NSString *identifier = @"weatherCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerScroll = [[HeaderScrollView alloc]initWithFrame:CGRectMake(0, 0,1, 200)];
    //[view addSubview:self.headerScroll];
    //view.backgroundColor = [UIColor orangeColor];
    [_tableView_weather registerNib:[UINib nibWithNibName:@"WeatherTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    _tableView_weather.delegate = self;
    _tableView_weather.dataSource = self;
    _tableView_weather.tableHeaderView = self.headerScroll;
    self.headerScroll.index = self.weather.retData.today.index;
    self.automaticallyAdjustsScrollViewInsets = false;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.weather.retData.forecast.count;
    }else
    {
        return self.weather.retData.history.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     WeatherIconManager *iconManager = [WeatherIconManager sharedWeatherIcon];
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (indexPath.section==0) {
        Forecast *forcast = self.weather.retData.forecast[indexPath.row];
        cell.weatherDate.text = [NSString stringWithFormat:@"%@ %@",forcast.date,forcast.week];
        cell.weatherIcon.image = [iconManager getIconByWeatherType:forcast.type];
        cell.weatherType.text = forcast.type;
        cell.weatherTemp.text = [NSString stringWithFormat:@"%@|%@",forcast.hightemp,forcast.lowtemp];
        cell.weatherFengli.text = [NSString stringWithFormat:@"%@ %@",forcast.fengxiang,forcast.fengli];
    }
    else
    {
        History *history = self.weather.retData.history[indexPath.row];
        cell.weatherDate.text = [NSString stringWithFormat:@"%@ %@",history.date,history.week];
        cell.weatherIcon.image = [iconManager getIconByWeatherType:history.type];
        cell.weatherType.text = history.type;
        cell.weatherTemp.text = [NSString stringWithFormat:@"%@|%@",history.hightemp,history.lowtemp];
        cell.weatherFengli.text = [NSString stringWithFormat:@"%@ %@",history.fengxiang,history.fengli];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"未来4天天气预报";
    }else
        return @"过去7天天气预报";
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.weather = nil;
}
@end
