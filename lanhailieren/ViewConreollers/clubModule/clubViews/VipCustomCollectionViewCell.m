//
//  VipCustomCollectionViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/4/22.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "VipCustomCollectionViewCell.h"

@implementation VipCustomCollectionViewCell

- (void)refreshUI:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.backgroundColor = UIColorFromRGB(0xffffff);
    self.infoDic = infoDic;
    
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, self.hd_width - 20, self.hd_height - 10)];
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, self.hd_width - 20, (self.hd_width - 15) * 0.48)];
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
    self.titleLB.font = kMainFont;
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    [self.contentView addSubview:self.titleLB];
    
    self.customMadeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.customMadeBtn.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) - 50, CGRectGetMaxY(self.iconImageView.frame) + 5, 50, 20);
    [self.customMadeBtn setTitle:@"上门定制" forState:UIControlStateNormal];
    [self.customMadeBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
    self.customMadeBtn.titleLabel.font = kMainFont_12;
    [self.contentView addSubview:self.customMadeBtn];
    
    self.vipImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.customMadeBtn.hd_x - 30, self.customMadeBtn.hd_centerY - 7.5, 30, 15)];
    [self.contentView addSubview:self.vipImageView];
    
    switch ([[infoDic objectForKey:kGroup_id] intValue]) {
            case 0:
        case 1:
            {
                self.vipImageView.image = [UIImage imageNamed:@"vip_registered"];
            }
            break;
        case 2:
        {
            self.vipImageView.image = [UIImage imageNamed:@"vip_ordinary"];
        }
            break;
        case 3:
        {
            self.vipImageView.image = [UIImage imageNamed:@"vip_senior"];
        }
            break;
            
        default:
            break;
    }
    
    [self.customMadeBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


- (void)playAction
{
    if (self.playBlock) {
        self.playBlock(self.infoDic);
    }
}

- (void)operationAction:(UIButton *)button
{
    if ([button isEqual:self.customMadeBtn])
    {
        if (self.customMadeBlock) {
            self.customMadeBlock(self.infoDic);
        }
    }
}


@end
