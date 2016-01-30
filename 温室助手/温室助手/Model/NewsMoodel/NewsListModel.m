//
//  NewsListModel.m
//  温室助手
//
//  Created by neusoftliang on 16/1/27.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "NewsListModel.h"

@implementation NewsListModel


+ (NSDictionary *)objectClassInArray{
    return @{@"tngou" : [NewsList class]};
}
@end
@implementation NewsList
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"desc"])
    {
        propertyName = @"description";
    }
    return propertyName;
}

@end


