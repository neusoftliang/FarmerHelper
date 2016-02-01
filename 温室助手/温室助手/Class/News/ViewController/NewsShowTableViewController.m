//
//  NewsShowTableViewController.m
//  温室助手
//
//  Created by neusoftliang on 16/1/30.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "NewsShowTableViewController.h"
#import "NewsNetManager.h"
@interface NewsShowTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *newsMessage;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;

@end

@implementation NewsShowTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NewsNetManager getNewsShowByNewsID:(int)self.newsID completionHandle:^(id model, NSError *error) {
        NewsShowModel *newsShow = model;
        NSString * htmlString = [NSString stringWithFormat:@"<html><body><font size=\"5\" color=\"red\">%@</font></body></html>",newsShow.message];
        NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, attrStr.length)];
        self.newsMessage.attributedText = attrStr;
        self.label_time.text = [self getDateByTime:newsShow.time];
        self.label_title.text = newsShow.title;
        [self.newsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TNGOUBaseImageURL,newsShow.img]] placeholderImage:nil];
        [self.tableView reloadData];
    }];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 136;
    }else if(indexPath.row==1)
    {
        return 44;
    }
    else
    {
        return UITableViewAutomaticDimension;
    }
}


@end
