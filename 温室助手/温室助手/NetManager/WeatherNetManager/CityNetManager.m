//
//  CityNetManager.m
//  温室助手
//
//  Created by neusoftliang on 16/1/25.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "CityNetManager.h"

@implementation CityNetManager

+(id)getCityByCityName:(NSString *)cityName completionHandle:(void (^)(id, NSError *))completionHandle
{
    NSString *url = [NSString stringWithFormat:@"%@%@",CityBaseURL,[cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    return [self GET:url parameters:nil completionHandle:^(id model, NSError *error) {
        completionHandle([CityModel parse:model],error);
    }];
}
@end
