//
//  CityNetManager.h
//  温室助手
//
//  Created by neusoftliang on 16/1/25.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "BaseNetManager.h"
#import "CityModel.h"
@interface CityNetManager : BaseNetManager
+(id)getCityByCityName:(NSString *)cityName kCompletionHandle;
@end
