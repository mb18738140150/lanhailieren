//
//  BiChiCollectionViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/12.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "BiChiCollectionViewCell.h"

@implementation BiChiCollectionViewCell

- (void)refreshUIWithInfo:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.backImageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    self.backImageView.layer.cornerRadius = 5;
    self.backImageView.image = [UIImage imageNamed:[infoDic objectForKey:@"image"]];
    self.backImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.backImageView];
    
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.hd_width, 15)];
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.titleLB.font = kMainFont_16;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = [infoDic objectForKey:@"title"];
    [self.contentView addSubview:self.titleLB];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLB.frame) + 10, self.hd_width, 10)];
    self.contentLB.textAlignment = NSTextAlignmentCenter;
    self.contentLB.textColor = UIColorFromRGB(0x666666);
    self.contentLB.font = kMainFont_12;
    self.contentLB.text = [infoDic objectForKey:@"tags"];
    [self.contentView addSubview:self.contentLB];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width * 0.2, CGRectGetMaxY(self.contentLB.frame) + 35, self.hd_width * 0.6, self.hd_width * 0.6)];
    self.iconImageView.image = [UIImage imageNamed:[infoDic objectForKey:@"iconImage"]];
    [self.contentView addSubview:self.iconImageView];
    
    if (!IS_PAD) {
        self.iconImageView.frame = CGRectMake(self.hd_width / 2 - kScreenWidth * 0.1, CGRectGetMaxY(self.contentLB.frame) + 10  , kScreenWidth * 0.2, kScreenWidth * 0.2);
    }
}


@end
