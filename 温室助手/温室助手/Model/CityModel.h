//
//  CityModel.h
//  温室助手
//
//  Created by neusoftliang on 16/1/25.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityRetdata;
@interface CityModel : NSObject

@property (nonatomic, strong) CityRetdata *retData;

@property (nonatomic, assign) NSInteger errNum;

@property (nonatomic, copy) NSString *retMsg;

@end
@interface CityRetdata : NSObject

@property (nonatomic, copy) NSString *cityCode;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *telAreaCode;

@property (nonatomic, copy) NSString *zipCode;

@property (nonatomic, copy) NSString *provinceName;

@end

