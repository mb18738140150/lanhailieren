//
//  IntergerCommodityHeaderTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "IntergerCommodityHeaderTableViewCell.h"

@implementation IntergerCommodityHeaderTableViewCell

- (void)refreshUIWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = self.bounds;
    
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, self.hd_width - 40, self.hd_height - 64)];
    self.backImageView.image = [UIImage imageNamed:@"banner_integral"];
    self.backImageView.layer.cornerRadius = 5;
    self.backImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.backImageView];
    
    self.coinImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, self.hd_height - 45, 26, 26)];
    self.coinImageView.image = [UIImage imageNamed:@"ic_integral_num"];
    [self.contentView addSubview:self.coinImageView];
    
    self.integerCountLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.coinImageView.frame) + 10, self.coinImageView.hd_y, 100, 26)];
    self.integerCountLB.textColor = UIColorFromRGB(0x000000);
    self.integerCountLB.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"count"]];
    self.integerCountLB.font = kMainFont;
    [self.contentView addSubview:self.integerCountLB];
    
    self.listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.listBtn.frame = CGRectMake(self.hd_width - 220, self.hd_height - 47, 90, 30);
    self.listBtn.layer.cornerRadius = self.listBtn.hd_height / 2;
    self.listBtn.layer.masksToBounds = YES;
    self.listBtn.backgroundColor = UIColorFromRGB(0xffe9ea);
    [self.listBtn setTitle:@"兑换列表" forState:UIControlStateNormal];
    [self.listBtn setTitleColor:UIColorFromRGB(0xbf0008) forState:UIControlStateNormal];
    self.listBtn.titleLabel.font = kMainFont;
    [self.listBtn addTarget:self action:@selector(listAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.listBtn];
    
    self.integerDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.integerDetailBtn.frame = CGRectMake(self.hd_width - 110, self.hd_height - 47, 90, 30);
    self.integerDetailBtn.layer.cornerRadius = self.integerDetailBtn.hd_height / 2;
    self.integerDetailBtn.layer.masksToBounds = YES;
    self.integerDetailBtn.backgroundColor = UIColorFromRGB(0xffe9ea);
    [self.integerDetailBtn setTitle:@"积分明细" forState:UIControlStateNormal];
    [self.integerDetailBtn setTitleColor:UIColorFromRGB(0xbf0008) forState:UIControlStateNormal];
    self.integerDetailBtn.titleLabel.font = kMainFont;
    [self.integerDetailBtn addTarget:self action:@selector(detailAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.integerDetailBtn];
    
    
}

- (void)listAction
{
    if (self.integerBuyListBlock) {
        self.integerBuyListBlock();
    }
}

- (void)detailAction
{
    if (self.integerDetailListBlock) {
        self.integerDetailListBlock();
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
