//
//  JingpinCollectionViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "JingpinCollectionViewCell.h"

@implementation JingpinCollectionViewCell

- (void)refreshUIWithInfo:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = self.bounds;
    
    UIView * backView = [[UIView alloc]initWithFrame:self.contentView.bounds];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 3;
    backView.layer.masksToBounds = YES;
    [self.contentView addSubview:backView];
    
    self.backImageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    self.backImageView.layer.cornerRadius = 5;
    self.backImageView.image = [UIImage imageNamed:@"bg_mall_project1"];
    self.backImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.backImageView];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.hd_width - 10, self.hd_width * 0.7)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[infoDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.iconImageView.frame) + 10, self.hd_width - 20 , 15)];
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.titleLB.font = kMainFont_12;
    self.titleLB.text = [infoDic objectForKey:@"title"];
    [self.contentView addSubview:self.titleLB];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLB.frame) + 5, self.hd_width - 20, 15)];
    self.contentLB.textColor = UIColorFromRGB(0x999999);
    self.contentLB.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.contentLB];
    self.contentLB.text = [infoDic objectForKey:@"tags"];
    
    self.priceLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.contentLB.frame) + 5, self.hd_width - 20, 15)];
    self.priceLB.textColor = kMainRedColor;
    self.priceLB.font = kMainFont_12;
    self.priceLB.text = [NSString stringWithFormat:@"￥%@", [infoDic objectForKey:@"price"]];
    [self.contentView addSubview:self.priceLB];
    
    if (!IS_PAD) {

        self.titleLB.frame = CGRectMake(10, CGRectGetMaxY(self.iconImageView.frame) + 12, self.hd_width - 20, 15);
        self.contentLB.frame = CGRectMake(10, CGRectGetMaxY(self.titleLB.frame) + 5, self.hd_width - 20, 15);
        self.priceLB.frame = CGRectMake(10, CGRectGetMaxY(self.contentLB.frame) + 5, self.hd_width - 20, 15);
        self.priceLB.textAlignment = NSTextAlignmentLeft;
        
    }
}

@end
