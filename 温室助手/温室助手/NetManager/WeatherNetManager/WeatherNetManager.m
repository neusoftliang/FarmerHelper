//
//  WeatherNetManager.m
//  温室助手
//
//  Created by neusoftliang on 16/1/23.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "WeatherNetManager.h"
@implementation WeatherNetManager
+(id)getWidtherByCityID:(NSInteger)city_id andCityName:(NSString *)cityName completionHandle:(void (^)(id, NSError *))completionHandle
{
    
    NSString *cityName_utf = [cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"%@cityname=%@&cityid=%ld",WeatherBaseURL,cityName_utf,(long)city_id];
    return [self GET:url parameters:nil completionHandle:^(id model, NSError *error) {
        completionHandle([WeatherModel parse:model],error);
    }];
}
@end
