//
//  NewsListTableViewCell.h
//  温室助手
//
//  Created by neusoftliang on 16/1/29.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView_list;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_time;

@end
