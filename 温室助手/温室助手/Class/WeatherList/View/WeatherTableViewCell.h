//
//  WeatherTableViewCell.h
//  温室助手
//
//  Created by neusoftliang on 16/1/26.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *weatherType;
@property (weak, nonatomic) IBOutlet UILabel *weatherDate;
@property (weak, nonatomic) IBOutlet UILabel *weatherTemp;
@property (weak, nonatomic) IBOutlet UILabel *weatherFengli;

@end
