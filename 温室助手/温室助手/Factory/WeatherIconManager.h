//
//  WeatherIconManager.h
//  温室助手
//
//  Created by neusoftliang on 16/1/25.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherModel.h"
@interface WeatherIconManager : NSObject
+(id)sharedWeatherIcon;
-(UIImage *)getIconByWeatherType:(NSString*)type;
@property (strong,nonatomic) NSArray *dayIcons;
@property (strong,nonatomic) NSArray *nightIcons;
@end
