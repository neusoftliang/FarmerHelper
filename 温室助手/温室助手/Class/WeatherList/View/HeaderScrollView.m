//
//  HeaderScrollView.m
//  温室助手
//
//  Created by neusoftliang on 16/1/26.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "HeaderScrollView.h"
@interface HeaderScrollView()
//@property (strong,nonatomic) UIView *view;
//@property (strong,nonatomic) UIImageView *bgImageVC;
//@property (strong,nonatomic) UIVisualEffectView *visualVC;
//@property (strong,nonatomic) UILabel *detail_label;
@end
@implementation HeaderScrollView
-(void)setIndex:(NSArray<Index *> *)index
{
    self.delegate = self;
    self.pagingEnabled = YES;
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    for (int i = 0; i<index.count; i++) {
        Index *index1 = index[i];
        UIView *view = [[UIView alloc]init];
        CGRect iFrame = CGRectZero;
        
        iFrame.origin = CGPointMake(i*window.bounds.size.width, 0);
        
        iFrame.size.height = self.frame.size.height;
        iFrame.size.width = window.bounds.size.width;
        view.frame = iFrame;
        //背景图片
        UIImageView *bgImageVC = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",index1.code]]];
        [view addSubview:bgImageVC];
        [bgImageVC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        //玻璃效果
        UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        [view addSubview:visualView];
        [visualView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(60);
            make.left.right.bottom.mas_equalTo(0);
        }];
        UILabel *detail_label = [[UILabel alloc]init];
        detail_label.text = index1.details;
        detail_label.numberOfLines = 0;
        detail_label.textAlignment = NSTextAlignmentCenter;
        detail_label.font = [UIFont systemFontOfSize:15];
        [visualView addSubview:detail_label];
        [detail_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        [self addSubview:view];
        
    }
    self.contentSize = CGSizeMake(index.count*window.bounds.size.width, self.bounds.size.height);
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
@end
