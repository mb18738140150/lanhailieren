//
//  IntegerListTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "IntegerListTableViewCell.h"

@implementation IntegerListTableViewCell

- (void)refreshUIWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = self.bounds;
    
    
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(24, 25, 27, 27)];
    self.iconImageView.image = [UIImage imageNamed:@"ic_integral"];
    self.iconImageView.layer.cornerRadius = self.iconImageView.hd_height / 2;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 15, self.iconImageView.hd_y - 1, 200, 15)];
    self.titleLB.text = [info objectForKey:@"title"];
    self.titleLB.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleLB];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 15, self.iconImageView.hd_y - 1 + 25, 200, 15)];
    self.timeLB.textColor = UIColorFromRGB(0x666666);
    self.timeLB.text = [info objectForKey:@"time"];
    self.timeLB.font = kMainFont;
    [self.contentView addSubview:self.timeLB];
    
    self.integerLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width - 200, 24, 180, 20)];
    self.integerLB.font = [UIFont systemFontOfSize:16];
    self.integerLB.textColor = kMainRedColor;
    [self.contentView addSubview:self.integerLB];
    self.integerLB.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"integer"]];
    self.integerLB.textAlignment = NSTextAlignmentRight;
    
    
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(65, self.contentView.hd_height - 1, self.hd_width - 85, 1)];
    seperateView.backgroundColor = UIColorFromRGB(0xe2e2e2);
    [self.contentView addSubview:seperateView];
}

- (void)refreshStoreUIWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = self.bounds;
    
    
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(24, 25, 27, 27)];
    self.iconImageView.image = [UIImage imageNamed:@"ic_integral"];
    self.iconImageView.layer.cornerRadius = self.iconImageView.hd_height / 2;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 15, self.iconImageView.hd_y - 1, 200, 15)];
    self.titleLB.text = [info objectForKey:@"title"];
    self.titleLB.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleLB];
    
    self.addressImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, self.iconImageView.hd_y - 1 + 25, 15, 15)];
    self.addressImageView.image = [UIImage imageNamed:@"ic_stores_address"];
    [self.contentView addSubview:self.addressImageView];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.addressImageView.frame) + 5, self.iconImageView.hd_y - 1 + 25, 200, 15)];
    self.timeLB.textColor = UIColorFromRGB(0x999999);
    self.timeLB.text = [info objectForKey:@"time"];
    self.timeLB.font = kMainFont;
    [self.contentView addSubview:self.timeLB];
    
    
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(65, self.contentView.hd_height - 1, self.hd_width - 85, 1)];
    seperateView.backgroundColor = UIColorFromRGB(0xe2e2e2);
    [self.contentView addSubview:seperateView];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
