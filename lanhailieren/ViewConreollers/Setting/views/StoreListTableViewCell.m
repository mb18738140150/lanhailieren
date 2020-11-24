//
//  StoreListTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/4/15.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "StoreListTableViewCell.h"

@implementation StoreListTableViewCell


- (void)refreshUIWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.frame = self.bounds;
    self.info = info;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[info objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    self.iconImageView.layer.cornerRadius = 3.3;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    CGFloat space = (self.iconImageView.hd_height - 45) / 4;
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 15, self.iconImageView.hd_y + space, self.hd_width - 200, 15)];
    self.titleLB.text = [info objectForKey:@"title"];
    self.titleLB.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.titleLB];
    
    self.countLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 15, CGRectGetMaxY(self.titleLB.frame) + space, self.hd_width - 200, 15)];
    self.countLB.textColor = UIColorFromRGB(0x333333);
    self.countLB.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"mobile"]];
    self.countLB.font = kMainFont_10;
    [self.contentView addSubview:self.countLB];
    
    self.integerLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 15, CGRectGetMaxY(self.countLB.frame) + space, self.hd_width - 200, 15)];
    self.integerLB.font = kMainFont_10;
    self.integerLB.textColor = UIColorFromRGB(0xcccccc);
    [self.contentView addSubview:self.integerLB];
    NSString * integerStr = [NSString stringWithFormat:@"%@", [info objectForKey:@"address"]];
    self.integerLB.text = integerStr;
    
    self.convertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.convertBtn.frame = CGRectMake(self.hd_width - 85, CGRectGetMaxY(self.titleLB.frame) , 70, 25);
    self.convertBtn.backgroundColor = [UIColor whiteColor];
    self.convertBtn.layer.cornerRadius = self.convertBtn.hd_height / 2;
    self.convertBtn.layer.masksToBounds = YES;
    self.convertBtn.layer.borderWidth = 1;
    self.convertBtn.layer.borderColor = UIColorFromRGB(0xe4e1e1).CGColor;
    [self.convertBtn setTitle:@"查看VR" forState:UIControlStateNormal];
    [self.convertBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    self.convertBtn.titleLabel.font = kMainFont_10;
    [self.convertBtn addTarget:self action:@selector(CheckVRAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.convertBtn];
    
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.hd_height - 1, self.hd_width, 1)];
    seperateView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.contentView addSubview:seperateView];
}

- (void)CheckVRAction
{
    if (self.checkVRBlock) {
        self.checkVRBlock(self.info);
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
