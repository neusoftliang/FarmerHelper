//
//  WeatherModel.m
//  温室助手
//
//  Created by neusoftliang on 16/1/23.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel

@end

@implementation Retdata

+ (NSDictionary *)objectClassInArray{
    return @{@"history" : [History class], @"forecast" : [Forecast class]};
}

@end


@implementation Today

+ (NSDictionary *)objectClassInArray{
    return @{@"index" : [Index class]};
}

@end


@implementation Index

@end


@implementation History

@end


@implementation Forecast

@end


