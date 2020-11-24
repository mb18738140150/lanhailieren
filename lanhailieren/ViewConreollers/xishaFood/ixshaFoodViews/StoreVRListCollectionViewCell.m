//
//  StoreVRListCollectionViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/4/20.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "StoreVRListCollectionViewCell.h"



@implementation StoreVRListCollectionViewCell

- (void)refreshUI:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.backgroundColor = UIColorFromRGB(0xffffff);
    self.infoDic = infoDic;
    
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, self.hd_width - 15, self.hd_height - 5)];
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, self.hd_width - 15, (self.hd_width - 15) * 0.64)];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.backImageView.layer.cornerRadius = 5;
    self.backImageView.backgroundColor = [UIColor whiteColor];
    self.backImageView.layer.shadowColor = UIColorFromRGB(0xf1f1f1).CGColor;
    self.backImageView.layer.shadowOpacity = 1;
    self.backImageView.layer.shadowOffset = CGSizeMake(0, 3);
    self.backImageView.layer.shadowRadius = 3;
    
    [self.contentView addSubview:self.backImageView];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[infoDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    
    [self.contentView addSubview:self.iconImageView];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.frame = CGRectMake(CGRectGetMidX(self.iconImageView.frame) - 15, CGRectGetMidY(self.iconImageView.frame) - 15, 30, 30);
    [self.playBtn setImage:[UIImage imageNamed:@"icon_vr"] forState:UIControlStateNormal];
    [self.playBtn addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.playBtn];
    
    // bofang
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.iconImageView.frame) + 6, self.hd_width - 20, 15)];
    self.titleLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"title"]];
    self.titleLB.font = kMainFont_12;
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLB];
    
    self.addressLB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addressLB.frame = CGRectMake(10, CGRectGetMaxY(self.titleLB.frame) + 0, self.hd_width - 20, 25);
    [self.addressLB setImage:[UIImage imageNamed:@"icon_address"] forState:UIControlStateNormal];
    [self.addressLB setTitle:[infoDic objectForKey:@"content"] forState:UIControlStateNormal];
    self.addressLB.titleLabel.numberOfLines = 0;
    [self.addressLB setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    self.addressLB.titleLabel.font = kMainFont_10;
    
    [self.contentView addSubview:self.addressLB];
}

- (void)refreshClubContestUI
{
    self.playBtn.hidden = YES;
    [self.addressLB setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}

- (void)playAction
{
    if (self.playBlock) {
        self.playBlock(self.infoDic);
    }
}


@end
