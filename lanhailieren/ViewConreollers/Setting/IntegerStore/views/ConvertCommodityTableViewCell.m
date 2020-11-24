//
//  ConvertCommodityTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ConvertCommodityTableViewCell.h"

@implementation ConvertCommodityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshUIWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = self.bounds;
    
    self.infoLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 200, 20)];
    self.infoLB.textColor = UIColorFromRGB(0x000000);
    self.infoLB.text = @"商品信息";
    self.infoLB.font = kMainFont;
    [self.contentView addSubview:self.infoLB];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, 90, 90)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kRootImageUrl, [info objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 15, self.iconImageView.hd_y, self.hd_width - 200, 30)];
    self.titleLB.text = [info objectForKey:@"title"];
    self.titleLB.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLB];
    
    
    self.buyCountLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 20, self.iconImageView.hd_y + 60, self.hd_width - 200, 30)];
    self.buyCountLB.font = [UIFont systemFontOfSize:18];
    self.buyCountLB.textColor = kMainRedColor;
    [self.contentView addSubview:self.buyCountLB];
    NSString * pointStr = [NSString stringWithFormat:@"%@", [info objectForKey:@"point"]];
    pointStr = [pointStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.buyCountLB.text = [NSString stringWithFormat:@"%@积分", pointStr];
    
    self.integerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.integerBtn.frame = CGRectMake(self.hd_width - 110, CGRectGetMaxY(self.iconImageView.frame) - 30, 90, 30);
    self.integerBtn.backgroundColor = UIColorFromRGB(0xffffff);
    [self.integerBtn setTitle:[info objectForKey:@"integer"] forState:UIControlStateNormal];
    [self.integerBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
    self.integerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    [self.contentView addSubview:self.integerBtn];
    
    
    __weak typeof(self)weakSelf = self;
    self.packageCountView = [[PackageCountView alloc]initWithFrame:CGRectMake(self.hd_width - 100 , self.buyCountLB.hd_y, 85, 23)];
    self.packageCountView.countBlock = ^(int count) {
        weakSelf.buyCount = count;
        if (weakSelf.countBlock) {
            weakSelf.countBlock(count);
        }
    };
    self.packageCountView.countLB.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"count"]];
    
    [self.contentView addSubview:self.packageCountView];
    
    
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.hd_height - 1, self.hd_width, 1)];
    seperateView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.contentView addSubview:seperateView];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
