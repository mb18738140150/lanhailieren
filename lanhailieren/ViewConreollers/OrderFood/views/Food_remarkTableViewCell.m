//
//  Food_remarkTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "Food_remarkTableViewCell.h"

@implementation Food_remarkTableViewCell

- (void)refreshWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, self.hd_width - 30, 15)];
    self.titleLB.text = [info objectForKey:@"title"];
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.titleLB.font = kMainFont_12;
    [self.contentView addSubview:self.titleLB];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLB.frame) + 5, self.hd_width - 30, 15)];
    self.contentLB.text = [info objectForKey:@"content"];
    self.contentLB.textColor = UIColorFromRGB(0x999999);
    self.contentLB.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.contentLB];
    
    self.priceLB = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.contentLB.frame) + 5, 150, 15)];
    self.priceLB.text = [NSString stringWithFormat:@"￥%@", [info objectForKey:@"price"]];
    self.priceLB.textColor = kMainRedColor;
    self.priceLB.font = kMainFont_12;
    [self.contentView addSubview:self.priceLB];

    self.countLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width - 200, CGRectGetMaxY(self.contentLB.frame) + 5, 180, 15)];
    self.countLB.text = [NSString stringWithFormat:@"已售：%@ 库存：%@",[info objectForKey:@"saleCount"], [info objectForKey:@"count"]];
    self.countLB.textColor = UIColorFromRGB(0x999999);
    self.countLB.font = [UIFont systemFontOfSize:10];
    self.countLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.countLB];
    
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
