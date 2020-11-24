//
//  SettingTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/5.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshUIWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 17, 15, 15)];
    self.iconImageView.image = [UIImage imageNamed:[info objectForKey:@"image"]];
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, 0, 200, self.contentView.hd_height)];
    self.titleLB.text = [info objectForKey:@"title"];
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.titleLB.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleLB];
    
    self.goImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width - 25, self.hd_height / 2 - 5, 10, 10)];
    self.goImageView.image = [UIImage imageNamed:@"main_go"];
    [self.contentView addSubview:self.goImageView];
    self.goImageView.hidden = YES;
    
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.hd_height - 1, self.hd_width, 1)];
    seperateView.backgroundColor = UIColorFromRGB(0xf5f5f5);
//    [self.contentView addSubview:seperateView];
    
}

- (void)showGoImageView
{
    self.goImageView.hidden = NO;
    
}

- (void)resetConnectionInfo:(NSDictionary *)info
{
    self.connectionInfoLB = [[UILabel alloc]initWithFrame:CGRectMake(self.goImageView.hd_x - 150, self.hd_height / 2 - 10, 140, 20)];
    
    self.connectionInfoLB.textAlignment = NSTextAlignmentRight;
    self.connectionInfoLB.text = @"";
    self.connectionInfoLB.font = kMainFont_12;
    self.connectionInfoLB.textColor = UIColorFromRGB(0x191919);
    [self.contentView addSubview:self.connectionInfoLB];
}

- (void)resetLevelInfo:(NSDictionary *)info
{
    self.connectionInfoLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.goImageView.frame) - 150, self.hd_height / 2 - 10, 140, 20)];
    self.connectionInfoLB.textAlignment = NSTextAlignmentRight;
    self.connectionInfoLB.text = [[[UserManager sharedManager] getUserInfos] objectForKey:kGroup_name];
    self.connectionInfoLB.font = kMainFont_12;
    self.connectionInfoLB.textColor = kMainRedColor;
    [self.contentView addSubview:self.connectionInfoLB];
    
}

- (void)hideAllSubViews
{
    self.connectionInfoLB.hidden = YES;
    self.iconImageView.hidden = YES;
    self.titleLB.hidden = YES;
    self.goImageView.hidden = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
