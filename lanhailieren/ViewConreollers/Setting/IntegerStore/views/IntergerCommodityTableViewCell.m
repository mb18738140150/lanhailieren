//
//  IntergerCommodityTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "IntergerCommodityTableViewCell.h"


@implementation IntergerCommodityTableViewCell

- (void)refreshUIWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = self.bounds;
    self.info = info;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 130, 130)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 20, self.iconImageView.hd_y, self.hd_width - 200, 30)];
    self.titleLB.text = [info objectForKey:@"title"];
    self.titleLB.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLB];
    
    self.countLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 20, self.iconImageView.hd_y + 80, self.hd_width - 200, 30)];
    self.countLB.textColor = UIColorFromRGB(0xcccccc);
    self.countLB.text = [NSString stringWithFormat:@"%@人已兑换", [info objectForKey:@"count"]];
    self.countLB.font = kMainFont;
    [self.contentView addSubview:self.countLB];
    
    self.integerLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 20, self.iconImageView.hd_y + 100, self.hd_width - 200, 30)];
    self.integerLB.font = [UIFont systemFontOfSize:18];
    self.integerLB.textColor = kMainRedColor;
    [self.contentView addSubview:self.integerLB];
    NSString * integerStr = [NSString stringWithFormat:@"%@积分", [info objectForKey:@"point"]];
    NSMutableAttributedString * integerStr_m = [[NSMutableAttributedString alloc]initWithString:integerStr];
    if (integerStr.length > 2) {
        [integerStr_m addAttribute:NSFontAttributeName value:kMainFont range:NSMakeRange(integerStr.length - 2, 2)];
    }
    self.integerLB.attributedText = integerStr_m;
    
    self.convertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.convertBtn.frame = CGRectMake(self.hd_width - 110, CGRectGetMaxY(self.iconImageView.frame) - 30, 90, 30);
    self.convertBtn.layer.cornerRadius = self.convertBtn.hd_height / 2;
    self.convertBtn.layer.masksToBounds = YES;
    self.convertBtn.backgroundColor = kMainRedColor;
    [self.convertBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [self.convertBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    self.convertBtn.titleLabel.font = kMainFont;
    [self.convertBtn addTarget:self action:@selector(convertAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.convertBtn];
    
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.hd_height - 1, self.hd_width, 1)];
    seperateView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.contentView addSubview:seperateView];
}

- (void)convertAction
{
    if (self.convertCommodityBlock) {
        self.convertCommodityBlock(self.info);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
