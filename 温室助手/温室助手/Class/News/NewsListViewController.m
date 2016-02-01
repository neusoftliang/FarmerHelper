//
//  NewsListViewController.m
//  温室助手
//
//  Created by neusoftliang on 16/1/28.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsNetManager.h"
#import "CLHeaderView.h"
#import "NewsListCollectionViewCell.h"
#import "NewsShowTableViewController.h"
@interface NewsListViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CLHeaderViewDelegate,NewsListDelegate>
@property(strong,nonatomic) CLHeaderView *headerView;
@property (strong,nonatomic) UICollectionView *collectionView;
@property (strong,nonatomic) NSMutableArray *muArray;
@property (strong,nonatomic) NewsSortModel *sort;
@property (assign,nonatomic) NSInteger list_id;

@end

@implementation NewsListViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"newsShow"]) {
        NewsShowTableViewController *showTable = segue.destinationViewController;
        NewsList *list = sender;
        showTable.newsID = list.id;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHeaderView];
}
-(void)configHeaderView
{
    //不写会出现滑动后偏移
    /**
     *  需要的话自定制cell即可
     */
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatUI];
    CLHeaderView * headerView = [CLHeaderView creatHeaderView];
    [self.view addSubview:headerView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NewsNetManager getNewsSort:nil :^(id model, NSError *error){
            NewsSortModel *sortModel = model;
            self.sort = sortModel;
            for (Tngou *title in sortModel.tngou) {
                [self.muArray addObject:title.name];
            }
            Tngou *tngou = sortModel.tngou[0];
            self.list_id = tngou.id;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.headerView.headerArray = self.muArray;
                [self.collectionView reloadData];
            });
        }];
    });
    self.headerView = headerView;
    self.headerView.delegates = self;
}
/**
 *  滑动结束后执行的方法
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x/self.view.frame.size.width;
    [self.headerView setSelectedIndexAnimated:page];
    
}

/**
 *  scrollView代理   必须要用
 */
- (void)headerView:(CLHeaderView *)header selectedIndexChanged:(NSUInteger)index{
    [self.collectionView scrollRectToVisible:CGRectMake(index * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
    Tngou *list = self.sort.tngou[index];
    self.list_id = list.id;
    [self.collectionView reloadData];
}

- (void)creatUI{
    CGFloat cellHeight = self.view.frame.size.height-(self.headerView.frame.origin.y+self.headerView.frame.size.height);
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //item行间距
    flowLayout.minimumLineSpacing = 0;//默认10
    flowLayout.minimumInteritemSpacing = 0;//默认10
    //设置统一大小的item
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width,cellHeight);//默认50
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//默认竖直滚动
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//边距屏幕宽
    CGRect collFrame = self.view.frame;
    collFrame.origin.y= 105;
    collFrame.size.height = cellHeight;
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:collFrame collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    collectionView.pagingEnabled = YES;
    
    self.collectionView = collectionView;
    //注册
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewsListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"newscell"];
}

/**
 *  返回数必须要和你的title数相等
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.headerView.headerArray.count;
    
}
//创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newscell" forIndexPath:indexPath];
    cell.newsDelegate = self;
    cell.list_id = self.list_id;
    return cell;
}

- (NSMutableArray *)muArray {
	if(_muArray == nil)
    {
		_muArray = [NSMutableArray array];
	}
	return _muArray;
}
-(void)tableView:(UITableView *)tableVW selectedInde:(NSIndexPath *)indexPath AndSendValue:(id)send
{
    [self performSegueWithIdentifier:@"newsShow" sender:send];
}
@end
