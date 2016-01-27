//
//  WeatherModel.h
//  温室助手
//
//  Created by neusoftliang on 16/1/23.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "BaseModel.h"


@class Retdata,Today,Index,History,Forecast;
@interface WeatherModel : BaseModel

@property (nonatomic, copy) NSString *errMsg;

@property (nonatomic, assign) NSInteger errNum;

@property (nonatomic, strong) Retdata *retData;

@end
@interface Retdata : NSObject

@property (nonatomic, strong) NSArray<History *> *history;

@property (nonatomic, strong) NSArray<Forecast *> *forecast;

@property (nonatomic, strong) Today *today;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *cityid;

@end

@interface Today : NSObject

@property (nonatomic, copy) NSString *fengli;

@property (nonatomic, strong) NSArray<Index *> *index;

@property (nonatomic, copy) NSString *aqi;

@property (nonatomic, copy) NSString *week;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *hightemp;

@property (nonatomic, copy) NSString *lowtemp;

@property (nonatomic, copy) NSString *fengxiang;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *curTemp;

@end

@interface Index : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *details;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *otherName;

@property (nonatomic, copy) NSString *index;

@end

@interface History : NSObject

@property (nonatomic, copy) NSString *fengli;

@property (nonatomic, copy) NSString *aqi;

@property (nonatomic, copy) NSString *week;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *hightemp;

@property (nonatomic, copy) NSString *lowtemp;

@property (nonatomic, copy) NSString *fengxiang;

@property (nonatomic, copy) NSString *type;

@end

@interface Forecast : NSObject

@property (nonatomic, copy) NSString *fengli;

@property (nonatomic, copy) NSString *hightemp;

@property (nonatomic, copy) NSString *week;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *lowtemp;

@property (nonatomic, copy) NSString *fengxiang;

@property (nonatomic, copy) NSString *type;

@end

