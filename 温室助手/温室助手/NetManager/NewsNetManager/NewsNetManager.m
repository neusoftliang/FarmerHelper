//
//  NewsNetManager.m
//  温室助手
//
//  Created by neusoftliang on 16/1/28.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "NewsNetManager.h"

@implementation NewsNetManager
+(id)getNewsSort:(id)completionHandle :(void (^)(id, NSError *))completionHandle
{
    NSString *sortURL = [NSString stringWithFormat:@"%@",NewsSortURL];
    return [self GET:sortURL parameters:nil completionHandle:^(id model, NSError *error) {
        completionHandle([NewsSortModel parse:model],error);
    }];
}
+(id)getNewsListBySortID:(int)sortID AndPageNum:(int)pagesNum completionHandle:(void (^)(id, NSError *))completionHandle
{
    NSString *listURL = [NSString stringWithFormat:@"%@id=%d&rows=%d",NewsListBaseURL,sortID,pagesNum];
    return [self GET:listURL parameters:nil completionHandle:^(id model, NSError *error) {
        completionHandle([NewsListModel parse:model],error);
    }];
}
+(id)getNewsShowByNewsID:(int)newsID completionHandle:(void (^)(id, NSError *))completionHandle
{
    NSString *newsURL = [NSString stringWithFormat:@"%@%d",NewsShowBaseURL,newsID];
    return [self GET:newsURL parameters:nil completionHandle:^(id model, NSError *error) {
        completionHandle([NewsShowModel parse:model],error);
    }];
}
@end
