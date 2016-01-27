//
//  WeatherNetManager.h
//  温室助手
//
//  Created by neusoftliang on 16/1/23.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "BaseNetManager.h"
#import "WeatherModel.h"
@interface WeatherNetManager : BaseNetManager
+(id)getWidtherByCityID:(NSInteger)city_id andCityName:(NSString *)cityName kCompletionHandle;
@end
