//
//  RechargeCollectionViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/9.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "RechargeCollectionViewCell.h"

@implementation RechargeCollectionViewCell

- (void)refreshUIWith:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.infoDic = infoDic;
    self.backgroundColor = [UIColor whiteColor];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.hd_width, self.hd_height)];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.borderWidth = 1;
    self.backView.layer.borderColor = UIColorFromRGB(0xe8e8e8).CGColor;
    [self.contentView addSubview:self.backView];
    
    self.priceLB = [[UILabel alloc]initWithFrame:CGRectMake(2, 18, self.hd_width - 4, 20)];
    NSString * priceStr = [NSString stringWithFormat:@"%@元", [infoDic objectForKey:@"price"]];
    self.priceLB.textColor = kMainRedColor;
    self.priceLB.textAlignment = NSTextAlignmentCenter;
    self.priceLB.font = [UIFont systemFontOfSize:20];
    
    NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xa9aaaa),NSFontAttributeName:[UIFont systemFontOfSize:13]};
    NSMutableAttributedString *priceStr_m = [[NSMutableAttributedString alloc]initWithString:priceStr];
    [priceStr_m addAttributes:attribute range:NSMakeRange(priceStr.length - 1, 1)];
    self.priceLB.attributedText = priceStr_m;
    [self.contentView addSubview:self.priceLB];
    
    self.seperateLine = [[UIView alloc]initWithFrame:CGRectMake(self.hd_width * 0.15, self.contentView.hd_centerY, self.hd_width * 0.7, 1)];
    self.seperateLine.backgroundColor = UIColorFromRGB(0xe8e8e8);
    [self.contentView addSubview:self.seperateLine];
    
    self.actualPriceLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.seperateLine.frame) + 8, self.hd_width - 4, 15)];
    self.actualPriceLB.text = [NSString stringWithFormat:@"售价：%@", [infoDic objectForKey:@"actualPrice"]];
    self.actualPriceLB.textAlignment = NSTextAlignmentCenter;
    self.actualPriceLB.textColor = UIColorFromRGB(0xa9aaaa);
    self.actualPriceLB.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.actualPriceLB];
    
    self.selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width - 17, self.contentView.hd_height - 17, 17, 17)];
    self.selectImageView.image = [UIImage imageNamed:@"icon_selected_topup"];
    [self.contentView addSubview:self.selectImageView];
    self.selectImageView.hidden = YES;
    
    
}
- (void)refreshSelectUI
{
    self.backView.layer.borderColor = kMainRedColor.CGColor;
    
    NSString * priceStr = [NSString stringWithFormat:@"%@元", [self.infoDic objectForKey:@"price"]];
    self.priceLB.textColor = kMainRedColor;
    
    NSDictionary * attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    NSMutableAttributedString *priceStr_m = [[NSMutableAttributedString alloc]initWithString:priceStr];
    [priceStr_m addAttributes:attribute range:NSMakeRange(priceStr.length - 1, 1)];
    self.priceLB.attributedText = priceStr_m;
    
    self.seperateLine.backgroundColor = kMainRedColor;
    self.actualPriceLB.textColor = kMainRedColor;
    
    self.selectImageView.hidden = NO;
    
}


@end
