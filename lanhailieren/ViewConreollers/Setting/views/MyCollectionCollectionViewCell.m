//
//  MyCollectionCollectionViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/4/15.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "MyCollectionCollectionViewCell.h"

@implementation MyCollectionCollectionViewCell

- (void)refreshUI:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.backgroundColor = UIColorFromRGB(0xffffff);
    self.infoDic = infoDic;
    
    if (IS_PAD) {
        self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, self.hd_width - 15, self.hd_height - 10)];
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, self.hd_width - 15, (self.hd_width - 15) * 0.48)];
//        UIBezierPath * bezierpath = [UIBezierPath bezierPathWithRoundedRect:self.iconImageView.frame byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
//        CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
//        shapLayer.frame = self.iconImageView.bounds;
//        shapLayer.path = bezierpath.CGPath;
//        [self.iconImageView.layer setMask: shapLayer];
        self.iconImageView.layer.cornerRadius = 5;
        self.iconImageView.layer.masksToBounds = YES;
    }else
    {
        self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, self.hd_width - 20, self.hd_height - 10)];
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, self.hd_width - 20, (self.hd_width - 20) * 0.41)];
        self.iconImageView.layer.cornerRadius = 5;
        self.iconImageView.layer.masksToBounds = YES;
    }
    
    self.backImageView.layer.cornerRadius = 5;

    self.backImageView.backgroundColor = [UIColor whiteColor];
    self.backImageView.layer.shadowColor = UIColorFromRGB(0xf1f1f1).CGColor;
    self.backImageView.layer.shadowOpacity = 1;
    self.backImageView.layer.shadowOffset = CGSizeMake(0, 3);
    self.backImageView.layer.shadowRadius = 3;
    
    [self.contentView addSubview:self.backImageView];
    
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[infoDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[infoDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"] options:SDWebImageAvoidDecodeImage];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
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
    
    self.customMadeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.customMadeBtn.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) - 80, CGRectGetMaxY(self.iconImageView.frame) + 3, 80, 20);
    [self.customMadeBtn setImage:[UIImage imageNamed:@"icon_custom_s"] forState:UIControlStateNormal];
    [self.customMadeBtn setTitle:@"上门定制" forState:UIControlStateNormal];
    [self.customMadeBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
    self.customMadeBtn.titleLabel.font = kMainFont_10;
    [self.customMadeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [self.contentView addSubview:self.customMadeBtn];
    self.customMadeBtn.hidden = YES;
    
    CGFloat btnSpace = (self.hd_width - 70 * 4) / 5;
    self.goodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.goodBtn.frame = CGRectMake(btnSpace, CGRectGetMaxY(self.titleLB.frame) + 3, 70, 25);
    [self.goodBtn setImage:[UIImage imageNamed:@"icon_givlike"] forState:UIControlStateNormal];
    [self.goodBtn setTitle:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"zan"]] forState:UIControlStateNormal];
    [self.goodBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    self.goodBtn.titleLabel.font = kMainFont;
    [self.goodBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [self.contentView addSubview:self.goodBtn];
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.frame = CGRectMake(CGRectGetMaxX(self.goodBtn.frame) + btnSpace, self.goodBtn.hd_y, 70, 25);
    [self.commentBtn setImage:[UIImage imageNamed:@"icon_comments"] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"comment_num"]] forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    self.commentBtn.titleLabel.font = kMainFont;
    [self.commentBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [self.contentView addSubview:self.commentBtn];
    
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.frame = CGRectMake(CGRectGetMaxX(self.commentBtn.frame) +btnSpace, self.goodBtn.hd_y, 70, 25);
    [self.collectBtn setImage:[UIImage imageNamed:@"icon_collection"] forState:UIControlStateNormal];
    [self.collectBtn setTitle:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"collect_num"]] forState:UIControlStateNormal];
    [self.collectBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    self.collectBtn.titleLabel.font = kMainFont;
    [self.collectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [self.contentView addSubview:self.collectBtn];
    
    // icon_already_collected
    if([[infoDic objectForKey:@"is_collect"] intValue])
    {
        [self.collectBtn setImage:[UIImage imageNamed:@"icon_already_collected"] forState:UIControlStateNormal];
    }
    if([[infoDic objectForKey:@"is_zan"] intValue])
    {
        [self.goodBtn setImage:[UIImage imageNamed:@"icon_givlike_active"] forState:UIControlStateNormal];
    }
    
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.frame = CGRectMake(CGRectGetMaxX(self.collectBtn.frame) +btnSpace, self.goodBtn.hd_y, 70, 25);
    [self.shareBtn setImage:[UIImage imageNamed:@"icon_forwarding"] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"share"]] forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    self.shareBtn.titleLabel.font = kMainFont;
    [self.shareBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [self.contentView addSubview:self.shareBtn];
    
    if (!IS_PAD) {
        self.titleLB.frame = CGRectMake(self.iconImageView.hd_x + 10, 10, self.iconImageView.hd_width - 20, 15);
        self.titleLB.textColor = [UIColor whiteColor];
        self.goodBtn.frame = CGRectMake(btnSpace, CGRectGetMaxY(self.iconImageView.frame) + 6, 70, 25);
        self.commentBtn.frame = CGRectMake(CGRectGetMaxX(self.goodBtn.frame) + btnSpace, self.goodBtn.hd_y, 70, 25);
        self.collectBtn.frame = CGRectMake(CGRectGetMaxX(self.commentBtn.frame) +btnSpace, self.goodBtn.hd_y, 70, 25);
        self.shareBtn.frame = CGRectMake(CGRectGetMaxX(self.collectBtn.frame) +btnSpace, self.goodBtn.hd_y, 70, 25);
    }
    
    [self.goodBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.commentBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.collectBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.customMadeBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        self.shareBtn.hidden = NO;
    }else
    {
        self.shareBtn.hidden = YES;
    }
    
}

- (void)resetFoodMakeUI
{
    CGFloat btnSpace = (self.hd_width - 70 * 4 - 35) / 3;
    self.titleLB.frame = CGRectMake(20, CGRectGetMaxY(self.iconImageView.frame) + 6, self.iconImageView.hd_width - 20, 15);
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.goodBtn.frame = CGRectMake(25, CGRectGetMaxY(self.titleLB.frame), 70, 25);
    self.goodBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.commentBtn.frame = CGRectMake(CGRectGetMaxX(self.goodBtn.frame) + btnSpace, self.goodBtn.hd_y, 70, 25);
    self.collectBtn.frame = CGRectMake(CGRectGetMaxX(self.commentBtn.frame) +btnSpace, self.goodBtn.hd_y, 70, 25);
    self.shareBtn.frame = CGRectMake(CGRectGetMaxX(self.collectBtn.frame) +btnSpace, self.goodBtn.hd_y, 70, 25);
    self.customMadeBtn.hidden = NO;
    
    
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        self.customMadeBtn.hidden = NO;
    }else
    {
        self.customMadeBtn.hidden = YES;
    }
    
}

- (void)resetFoodMakeUI_Club
{
    if (IS_PAD) {
        self.backImageView.frame = CGRectMake(0, 5, self.hd_width - 0, self.hd_height - 10);
        self.iconImageView.frame = CGRectMake(0, 5, self.hd_width - 0, (self.hd_width - 15) * 0.48);
    }else
    {
        self.backImageView.frame = CGRectMake(0, 5, self.hd_width - 0, self.hd_height - 10);
        self.iconImageView.frame = CGRectMake(0, 5, self.hd_width - 0, (self.hd_width - 20) * 0.41);
    }
}

- (void)playAction
{
    if (self.playBlock) {
        self.playBlock(self.infoDic);
    }
}

- (void)operationAction:(UIButton *)button
{
    if ([button isEqual:self.goodBtn]) {
        if (self.goodBlock) {
            self.goodBlock(self.infoDic);
        }
    }else if ([button isEqual:self.commentBtn])
    {
        if (self.commentBlock) {
            self.commentBlock(self.infoDic);
        }
    }else if ([button isEqual:self.collectBtn])
    {
        if (self.collectBlock) {
            self.collectBlock(self.infoDic);
        }
    }
    else if ([button isEqual:self.shareBtn])
    {
        if (self.shareBlock) {
            self.shareBlock(self.infoDic);
        }
    }else if ([button isEqual:self.customMadeBtn])
    {
        if (self.customMadeBlock) {
            self.customMadeBlock(self.infoDic);
        }
    }
}


@end
