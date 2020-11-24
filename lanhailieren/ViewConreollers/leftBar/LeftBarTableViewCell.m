//
//  LeftBarTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/5.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "LeftBarTableViewCell.h"

@implementation LeftBarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshUserInfoWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(11, 20, 30, 30)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    [self.contentView addSubview:self.iconImageView];
    self.iconImageView.layer.cornerRadius = self.iconImageView.hd_height / 2;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(3, CGRectGetMaxY(self.iconImageView.frame) + 5, self.contentView.hd_width - 6, 15)];
    self.titleLB.text = [info objectForKey:@"title"];
    self.titleLB.font = [UIFont systemFontOfSize:10];
    self.titleLB.textColor = UIColorFromRGB(0x737373);
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLB];
    
}
- (void)refreshWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(17, 33, 17, 17)];
    self.iconImageView.image = [UIImage imageNamed:[info objectForKey:@"image"]];
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame) + 5, self.contentView.hd_width, 15)];
    self.titleLB.text = [info objectForKey:@"title"];
    self.titleLB.font = [UIFont systemFontOfSize:10];
    self.titleLB.textColor = UIColorFromRGB(0x737373);
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLB];
    
    self.countLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) - 5, self.iconImageView.hd_y - 5, 10, 10)];
    self.countLB.backgroundColor = UIColorFromRGB(0xbf0008);
    self.countLB.layer.cornerRadius = self.countLB.hd_width / 2;
    self.countLB.layer.masksToBounds = YES;
    self.countLB.font = [UIFont systemFontOfSize:5];
    self.countLB.textColor = UIColorFromRGB(0xffffff);
    self.countLB.textAlignment = NSTextAlignmentCenter;
    self.countLB.text = @"9";
    self.countLB.hidden = YES;
    [self.contentView addSubview:self.countLB];
}

- (void)refreshSelectWithInfo:(NSDictionary *)info
{
    self.iconImageView.image = [UIImage imageNamed:[info objectForKey:@"image_select"]];
}

- (void)resetShoppingCar
{
    self.countLB.hidden = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
