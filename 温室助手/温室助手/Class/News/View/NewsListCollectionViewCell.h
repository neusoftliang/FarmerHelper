//
//  NewsListCollectionViewCell.h
//  温室助手
//
//  Created by neusoftliang on 16/1/29.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsNetManager.h"
@protocol NewsListDelegate <NSObject>
- (void)tableView: (UITableView*)tableVW selectedInde: (NSIndexPath *)indexPath AndSendValue:(id)send;
@end

@interface NewsListCollectionViewCell : UICollectionViewCell

@property (assign,nonatomic) NSInteger list_id;
@property (weak,nonatomic)id<NewsListDelegate> newsDelegate;
@end
