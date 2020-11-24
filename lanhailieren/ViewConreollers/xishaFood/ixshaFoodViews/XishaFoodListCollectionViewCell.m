//
//  XishaFoodListCollectionViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/4/20.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "XishaFoodListCollectionViewCell.h"

@implementation XishaFoodListCollectionViewCell


- (void)refreshUI:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.backgroundColor = UIColorFromRGB(0xffffff);
    self.infoDic = infoDic;
    
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.hd_width - 5, self.hd_height - 5)];
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.hd_width - 5, (self.hd_width - 15) * 0.73)];
    UIBezierPath * bezierpath = [UIBezierPath bezierPathWithRoundedRect:self.iconImageView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
    shapLayer.frame = self.iconImageView.bounds;
    shapLayer.path = bezierpath.CGPath;
    [self.iconImageView.layer setMask: shapLayer];
    
    self.backImageView.layer.cornerRadius = 5;
    self.backImageView.backgroundColor = [UIColor whiteColor];
    self.backImageView.layer.shadowColor = UIColorFromRGB(0xf1f1f1).CGColor;
    self.backImageView.layer.shadowOpacity = 1;
    self.backImageView.layer.shadowOffset = CGSizeMake(0, 3);
    self.backImageView.layer.shadowRadius = 3;
    
    [self.contentView addSubview:self.backImageView];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[infoDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"] options:SDWebImageAvoidDecodeImage];
    
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[infoDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"] ];
    
    [self.contentView addSubview:self.iconImageView];
    
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame) , self.hd_width , 30)];
    self.titleLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"title"]];
    self.titleLB.font = kMainFont_12;
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLB];
    
}

- (void)refreshClubUI:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.backgroundColor = UIColorFromRGB(0xffffff);
    self.infoDic = infoDic;
    
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, self.hd_width - 5, self.hd_height - 10)];
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, self.hd_width - 5, (self.hd_width - 15) * 0.4)];
    UIBezierPath * bezierpath = [UIBezierPath bezierPathWithRoundedRect:self.iconImageView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
    shapLayer.frame = self.iconImageView.bounds;
    shapLayer.path = bezierpath.CGPath;
    [self.iconImageView.layer setMask: shapLayer];
    
    self.backImageView.layer.cornerRadius = 5;
    self.backImageView.backgroundColor = [UIColor whiteColor];
    self.backImageView.layer.shadowColor = UIColorFromRGB(0xeeeeee).CGColor;
    self.backImageView.layer.shadowOpacity = 1;
    self.backImageView.layer.shadowOffset = CGSizeMake(0, 3);
    self.backImageView.layer.shadowRadius = 3;
    
    [self.contentView addSubview:self.backImageView];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[infoDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    [self.contentView addSubview:self.iconImageView];
    
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame) , self.hd_width , 30)];
    self.titleLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"title"]];
    self.titleLB.font = kMainFont_12;
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLB];
    
    NSString * contentStr = [infoDic objectForKey:@"content"];
    CGFloat contentHeight = [contentStr boundingRectWithSize:CGSizeMake(self.hd_width - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size.height;
    if (contentHeight > 30) {
        contentHeight = 30;
    }
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLB.frame), self.hd_width - 20, contentHeight)];
    self.contentLB.font = [UIFont systemFontOfSize:11];
    self.contentLB.textColor = UIColorFromRGB(0x666666);
    self.contentLB.numberOfLines = 2;
    self.contentLB.text = contentStr;
    [self.contentView addSubview:self.contentLB];
}

- (void)playAction
{
    if (self.playBlock) {
        self.playBlock(self.infoDic);
    }
}

@end
