//
//  CommodityInfoTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/10.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "CommodityInfoTableViewCell.h"

@implementation CommodityInfoTableViewCell

- (void)refreshUIWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = self.bounds;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.info = info;
    
    self.infoLB = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, self.hd_width - 50, 15)];
    self.infoLB.textColor = UIColorFromRGB(0x000000);
    self.infoLB.text = [info objectForKey:@"title"];
    self.infoLB.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.infoLB];
    
    self.tedianLB = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.infoLB.frame) + 5, self.hd_width - 50, 15)];
    self.tedianLB.textColor = UIColorFromRGB(0x999999);
    self.tedianLB.text = [info objectForKey:@"tags"];
    self.tedianLB.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.tedianLB];
    
    self.integerLB = [[UILabel alloc]initWithFrame:CGRectMake( 15, self.tedianLB.hd_y + 20, 200, 15)];
    self.integerLB.font = [UIFont systemFontOfSize:14];
    self.integerLB.textColor = kMainRedColor;
    [self.contentView addSubview:self.integerLB];
    NSString * integerStr = [NSString stringWithFormat:@"%d积分", [self getGoodPoint]];
    NSMutableAttributedString * integerStr_m = [[NSMutableAttributedString alloc]initWithString:integerStr];
    if (integerStr.length > 2) {
        [integerStr_m addAttribute:NSFontAttributeName value:kMainFont range:NSMakeRange(integerStr.length - 2, 2)];
    }
    self.integerLB.attributedText = integerStr_m;
    
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width - 200, self.integerLB.hd_y, 180, 15)];
    self.titleLB.text = [NSString stringWithFormat:@"已兑：%@", [info objectForKey:@"sale_num"]];
    self.titleLB.textColor = UIColorFromRGB(0x999999);
    self.titleLB.font = [UIFont systemFontOfSize:10];
    self.titleLB.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.titleLB];
    
}
- (int)getGoodPoint
{
    NSString * pointStr = [NSString stringWithFormat:@"%@", [self.info objectForKey:@"point"]];
    pointStr = [pointStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return pointStr.intValue;
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
