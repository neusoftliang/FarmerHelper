//
//  HeaderScrollView.h
//  温室助手
//
//  Created by neusoftliang on 16/1/26.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"
@interface HeaderScrollView : UIScrollView<UIScrollViewDelegate>
@property (strong,nonatomic) NSArray <Index*> *index;
@end
