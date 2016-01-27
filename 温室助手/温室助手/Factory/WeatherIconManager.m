//
//  WeatherIconManager.m
//  温室助手
//
//  Created by neusoftliang on 16/1/25.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "WeatherIconManager.h"

@implementation WeatherIconManager
-(instancetype)init
{
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"weatherIcon" ofType:@"plist"];
        NSDictionary* icons = [[NSDictionary alloc]initWithContentsOfFile:path];
        self.dayIcons = icons[@"day"];
        self.nightIcons = icons[@"night"];
    }
    return self;
}
+(id)sharedWeatherIcon
{
    static WeatherIconManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WeatherIconManager alloc]init];
    });
    return manager;
}
-(UIImage *)getIconByWeatherType:(NSString *)type
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH"];
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSArray *icons = nil;
    int time = [str intValue];
    if (time>=18||time<=06)
    {
        icons = self.nightIcons;
    }
    else{
        icons = self.dayIcons;
    }
    for (NSDictionary *dic in icons)
    {
        NSString *type_dic = dic[@"type"];
        if ([type_dic isEqualToString:type])
        {
            return [UIImage imageWithData:dic[@"icon"]];
        }
    }
    return [UIImage imageNamed:@"undefined"];
}
@end
