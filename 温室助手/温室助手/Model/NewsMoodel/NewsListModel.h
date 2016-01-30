//
//  NewsListModel.h
//  温室助手
//
//  Created by neusoftliang on 16/1/27.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsList;
@interface NewsListModel : NSObject

@property (nonatomic, assign) BOOL status;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray<NewsList *> *tngou;

@end
@interface NewsList : NSObject

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger fcount;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) long long time;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *keywords;

@property (nonatomic, assign) NSInteger newclass;

@property (nonatomic, assign) NSInteger newsclass;

@property (nonatomic, assign) NSInteger user;

@property (nonatomic, assign) NSInteger rcount;

@end

