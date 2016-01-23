//
//  UIScrollView+Refresh.m
//  BaseProject
//
//  Created by tarena on 15/12/16.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)
-(void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock)refreshBlock
{
    self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshBlock];
}
-(void)endHeaderRefresh
{
    [self.header endRefreshing];
}
-(void)addFooterRefresh:(MJRefreshComponentRefreshingBlock)refreshBlock
{
    self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:refreshBlock];
}

@end
