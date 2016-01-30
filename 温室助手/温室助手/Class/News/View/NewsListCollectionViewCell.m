//
//  NewsListCollectionViewCell.m
//  温室助手
//
//  Created by neusoftliang on 16/1/29.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "NewsListCollectionViewCell.h"
#import "NewsListTableViewCell.h"
#import <MJRefresh.h>
@interface NewsListCollectionViewCell()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *newsListTable;
@property (nonatomic,strong) NewsListModel *list;
@property (assign,nonatomic) int page;
@end
@implementation NewsListCollectionViewCell

-(void)setList_id:(NSInteger)list_id
{
    self.page = 0;
    self.newsListTable.dataSource = self;
    self.newsListTable.delegate = self;
    [self.newsListTable registerNib:[UINib nibWithNibName:@"NewsListTableViewCell" bundle:nil] forCellReuseIdentifier:@"listcell"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       [NewsNetManager getNewsListBySortID:(int)list_id AndPageNum:self.page+10 completionHandle:^(id model, NSError *error) {
           self.list = model;
           [self.newsListTable reloadData];
       }];
    });
    self.newsListTable.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.tngou.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listcell" forIndexPath:indexPath];
    NewsList *list = self.list.tngou[indexPath.row];
    cell.label_title.text = list.title;
    cell.imageView_list.image = nil;
    [cell.imageView_list sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TNGOUBaseImageURL,list.img]] placeholderImage:[UIImage imageNamed:@"news"] options:SDWebImageRefreshCached];
    cell.label_time.text = [self getDateByTime:list.time];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74;
}
/**
 *  时间戳转成时间
 */
-(NSString *)getDateByTime:(NSInteger)time
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSData *date = [NSDate dateWithTimeIntervalSince1970:time/1000];
    NSString *str = [formatter stringFromDate:date];
    return str;
}
@end
