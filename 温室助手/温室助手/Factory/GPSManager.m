//
//  GPSManager.m
//  温室助手
//
//  Created by neusoftliang on 16/1/25.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "GPSManager.h"
#import <CoreLocation/CoreLocation.h>
@interface GPSManager()<CLLocationManagerDelegate>
@property (strong,nonatomic) CLLocationManager *manager;
@end

@implementation GPSManager
-(CLLocationManager *)manager
{
    if (_manager==nil) {
        _manager = [CLLocationManager new];
    }
    return _manager;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
}
@end
