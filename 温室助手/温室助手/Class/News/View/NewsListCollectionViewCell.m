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
@property (nonatomic,strong) NSMutableArray *listMuArray;
@property (assign,nonatomic) int page;
@end
@implementation NewsListCollectionViewCell

-(NSMutableArray *)listMuArray
{
    if (_listMuArray==nil) {
        _listMuArray = [NSMutableArray array];
    }
    return _listMuArray;
}

-(void)setList_id:(NSInteger)list_id
{
    self.page = 10;
    [self.listMuArray removeAllObjects];
    self.newsListTable.dataSource = self;
    self.newsListTable.delegate = self;
    [self.newsListTable registerNib:[UINib nibWithNibName:@"NewsListTableViewCell" bundle:nil] forCellReuseIdentifier:@"listcell"];
    [self getNewsFromServer:list_id];
    self.newsListTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreByID:(int)list_id];
    }];
}
/**
 *  从服务器加载更多数据
 *
 *  @param listID 分类ID
 */
-(void)loadMoreByID:(int)listID
{
    
    self.page = self.page+10;
    MYLog(@"page%d",self.page);
    [self.newsListTable.mj_footer beginRefreshing];
    [self getNewsFromServer:listID];
    
}
/**
 *  从服务器获取到数据
 *
 *  @param listID 分类ID
 */
-(void)getNewsFromServer:(NSInteger)listID
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        MYLog(@"page%d",self.page);
        [NewsNetManager getNewsListBySortID:(int)listID AndPageNum:self.page completionHandle:^(id model, NSError *error) {
            self.list = model;
//            [self.listMuArray addObjectsFromArray:self.list.tngou];
            [self.newsListTable reloadData];
            [self.newsListTable.mj_footer endRefreshing];
        }];
    });
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.page;
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
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time/1000];
    NSString *str = [formatter stringFromDate:date];
    return str;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.newsDelegate&&[self.newsDelegate respondsToSelector:@selector(tableView:selectedInde: AndSendValue:)]){
        [self.newsDelegate tableView:tableView selectedInde:indexPath AndSendValue:self.list.tngou[indexPath.row]];
    }
}
@end
