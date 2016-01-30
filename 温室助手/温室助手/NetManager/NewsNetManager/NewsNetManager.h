//
//  NewsNetManager.h
//  温室助手
//
//  Created by neusoftliang on 16/1/28.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "BaseNetManager.h"
#import "NewsListModel.h"
#import "NewsShowModel.h"
#import "NewsSortModel.h"
@interface NewsNetManager : BaseNetManager
/**
 *  取得新闻分类
 *
 */
+(id)getNewsSort: kCompletionHandle;
/**
 *  通过分类ID 返回每个分类的列表
 *
 *  @param sortID   分类id
 *  @param pagesNum 每次请求返回多少条新闻
 */
+(id)getNewsListBySortID:(int)sortID AndPageNum:(int)pagesNum kCompletionHandle;
/**
 *  取得每个具体的新闻
 *
 *  @param newsID 新闻ID
 *
 */
+(id)getNewsShowByNewsID:(int)newsID kCompletionHandle;
@end
