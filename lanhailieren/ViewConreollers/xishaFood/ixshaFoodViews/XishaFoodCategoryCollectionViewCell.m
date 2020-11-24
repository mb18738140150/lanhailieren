//
//  XishaFoodCategoryCollectionViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/4/20.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "XishaFoodCategoryCollectionViewCell.h"

@implementation XishaFoodCategoryCollectionViewCell

// 115 71 0.62  34 0.3 26 0.76
- (void)refreshUIWithInfo:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.backImageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    self.backImageView.layer.cornerRadius = 5;
    self.backImageView.layer.masksToBounds = YES;
    self.backImageView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:self.backImageView];
    
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(15, self.hd_height / 2 - 20, self.hd_width * 0.5, 15)];
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.titleLB.font = kMainFont;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = [infoDic objectForKey:@"title"];
    [self.contentView addSubview:self.titleLB];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(15, self.hd_height / 2, self.hd_width * 0.5, 15)];
    self.contentLB.textAlignment = NSTextAlignmentCenter;
    self.contentLB.textColor = UIColorFromRGB(0x666666);
    self.contentLB.font = kMainFont_12;
    self.contentLB.text = [infoDic objectForKey:@"tags"];
    [self.contentView addSubview:self.contentLB];
    
    CGFloat imageWidth = (self.hd_width * 0.3);
    CGFloat imageHeight = (self.hd_width * 0.3 * 0.76);
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width  - 15 - imageWidth, self.hd_height / 2 - imageHeight / 2, imageWidth, imageHeight)];
    self.iconImageView.image = [UIImage imageNamed:[infoDic objectForKey:@"iconImage"]];
    [self.contentView addSubview:self.iconImageView];
    
}

@end
