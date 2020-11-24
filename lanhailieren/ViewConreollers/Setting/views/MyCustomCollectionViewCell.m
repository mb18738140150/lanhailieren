//
//  MyCustomCollectionViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/4/15.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "MyCustomCollectionViewCell.h"

@implementation MyCustomCollectionViewCell

- (void)refreshUI:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.backgroundColor = UIColorFromRGB(0xffffff);
    self.infoDic = infoDic;
    if ([[infoDic  class] isEqual:[NSNull class]]) {
        return;
    }
    if (IS_PAD) {
        self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, self.hd_width - 15, self.hd_height - 5)];
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, self.hd_width - 15, (self.hd_width - 15) * 0.48)];
        UIBezierPath * bezierpath = [UIBezierPath bezierPathWithRoundedRect:self.iconImageView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
        shapLayer.frame = self.iconImageView.bounds;
        shapLayer.path = bezierpath.CGPath;
        [self.iconImageView.layer setMask: shapLayer];
    }else
    {
        self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, self.hd_width - 20, self.hd_height - 5)];
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, self.hd_width - 20, (self.hd_width - 20) * 0.41)];
        self.iconImageView.layer.cornerRadius = 5;
        self.iconImageView.layer.masksToBounds = YES;
    }
    
    //    self.backImageView.image = [UIImage imageNamed:@"bg_mall_project1"];
    self.backImageView.layer.cornerRadius = 5;
//    self.backImageView.layer.masksToBounds = YES;
    self.backImageView.backgroundColor = [UIColor whiteColor];
    self.backImageView.layer.shadowColor = UIColorFromRGB(0xf1f1f1).CGColor;
    self.backImageView.layer.shadowOpacity = 1;
    self.backImageView.layer.shadowOffset = CGSizeMake(0, 3);
    self.backImageView.layer.shadowRadius = 3;
    
    [self.contentView addSubview:self.backImageView];
    self.iconImageView.backgroundColor = [UIColor whiteColor];
    self.iconImageView.contentMode = UIViewContentModeScaleToFill;
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[infoDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[infoDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"] options:SDWebImageAvoidDecodeImage];
    
    [self.contentView addSubview:self.iconImageView];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.frame = CGRectMake(CGRectGetMidX(self.iconImageView.frame) - 15, CGRectGetMidY(self.iconImageView.frame) - 15, 30, 30);
    [self.playBtn setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.playBtn];
    [self.playBtn addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    
    // bofang
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.iconImageView.frame) + 6, self.hd_width - 30, 15)];
    self.titleLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"title"]];
    self.titleLB.font = kMainFont_12;
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    [self.contentView addSubview:self.titleLB];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.hd_width - 150, CGRectGetMaxY(self.iconImageView.frame) + 6, 130, 15)];
    self.timeLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"add_time"]];
    self.timeLB.textAlignment = NSTextAlignmentRight;
    self.timeLB.font = kMainFont_12;
    self.timeLB.textColor = UIColorFromRGB(0x999999);
    [self.contentView addSubview:self.timeLB];
    
    self.stateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.titleLB.frame) + 10, 10, 10)];
    self.stateImageView.image = [UIImage imageNamed:@"icon_distribution"];
//    [self.contentView addSubview:self.stateImageView];
    
    self.stateLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.stateImageView.frame) + 8, CGRectGetMaxY(self.titleLB.frame) + 6, self.hd_width - 50, 15)];
    self.stateLB.font = kMainFont_10;
    self.stateLB.textColor = UIColorFromRGB(0xE31c1c);
    self.stateLB.text = @"等待分配门店中";
    if ([[infoDic objectForKey:@"state"] intValue] == 2) {
        self.stateLB.textColor = UIColorFromRGB(0x1CA422);
        self.stateLB.text = @"门店已完成联系";
        self.stateImageView.image = [UIImage imageNamed:@"icon_complete"];
    }
    
//    [self.contentView addSubview:self.stateLB];
}

- (NSString *)getTimeStr:(NSString *)time
{
    NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
    formatter1.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * date = [formatter1 dateFromString:time];
    NSDateFormatter * formatter2 = [[NSDateFormatter alloc]init];
    formatter2.dateFormat = @"yyyy-MM-dd HH:mm";
    
    return [formatter2 stringFromDate:date];
}

- (void)playAction
{
    if (self.playBlock) {
        self.playBlock(self.infoDic);
    }
}

@end
