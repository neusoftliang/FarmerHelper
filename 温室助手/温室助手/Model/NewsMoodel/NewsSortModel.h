//
//  NewsSortModel.h
//  温室助手
//
//  Created by neusoftliang on 16/1/27.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Tngou;
@interface NewsSortModel : NSObject

@property (nonatomic, assign) BOOL status;

@property (nonatomic, strong) NSArray<Tngou *> *tngou;

@end
@interface Tngou : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *keywords;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger newsclass;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger newclass;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger seq;

@end

