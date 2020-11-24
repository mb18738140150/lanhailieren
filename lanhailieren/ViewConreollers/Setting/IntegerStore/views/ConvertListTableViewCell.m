//
//  ConvertListTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ConvertListTableViewCell.h"
#import "OrderStateOperationView.h"
@implementation ConvertListTableViewCell


- (void)refreshUIWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = self.bounds;
    self.info = info;
    
    self.stateLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 200, 20)];
    self.stateLB.textColor = UIColorFromRGB(0x000000);
    self.stateLB.font = kMainFont_16;
    [self.contentView addSubview:self.stateLB];
    switch ([self getOrderState:info]) {
        case OrderState_delivery:
        {
            self.stateLB.textColor = UIColorFromRGB(0xBF0008);
            self.stateLB.text = [NSString stringWithFormat:@"已发货  单号：%@", [info objectForKey:@"express_no"]];
        }
        case OrderState_no_delivery:
        {
            self.stateLB.textColor = UIColorFromRGB(0x129109);
            self.stateLB.text = @"待发货";
        }
            break;
            
        default:
            break;
    }
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width - 200, 15, 180, 20)];
    self.timeLB.textColor = UIColorFromRGB(0x666666);
    self.timeLB.text = [info objectForKey:@"add_time"];
    self.timeLB.textAlignment = NSTextAlignmentRight;
    self.timeLB.font = kMainFont;
    [self.contentView addSubview:self.timeLB];
    
    UIView * midSeperateLine = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.stateLB.frame) + 14, self.hd_width - 40, 1)];
    midSeperateLine.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.contentView addSubview:midSeperateLine];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 65, 70, 70)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[info objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 15, self.iconImageView.hd_y, self.hd_width - 200, 30)];
    self.titleLB.text = [info objectForKey:@"title"];
    self.titleLB.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLB];
    
    
    self.integerLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 20, self.iconImageView.hd_y + 40, self.hd_width - 200, 30)];
    self.integerLB.font = [UIFont systemFontOfSize:18];
    self.integerLB.textColor = kMainRedColor;
    [self.contentView addSubview:self.integerLB];
    NSString * integerStr = [NSString stringWithFormat:@"%d积分", [self getGoodPoint]];
    NSMutableAttributedString * integerStr_m = [[NSMutableAttributedString alloc]initWithString:integerStr];
    if (integerStr.length > 2) {
        [integerStr_m addAttribute:NSFontAttributeName value:kMainFont range:NSMakeRange(integerStr.length - 2, 2)];
    }
    self.integerLB.attributedText = integerStr_m;
    
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.hd_height - 2, self.hd_width, 2)];
    seperateView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.contentView addSubview:seperateView];
}

- (int)getGoodPoint
{
    NSString * pointStr = [NSString stringWithFormat:@"%@", [self.info objectForKey:@"point"]];
    pointStr = [pointStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return pointStr.intValue;
}

- (OrderState)getOrderState:(NSDictionary *)info
{
    int p_a_yment_status = [[info objectForKey:@"p_a_yment_status"] intValue];
    int express_status = [[info objectForKey:@"express_status"] intValue];
    int status = [[info objectForKey:@"status"] intValue];
    
    if (status == 3) {
        return OrderState_complate;// 已完成
    }else if (status == 4){
        return OrderState_cancel;// 已取消
    }else if (status == 5)
    {
        return OrderState_void;// 作废
    }
    if (p_a_yment_status == 1) {
        return OrderState_nop_a_y;// 未付款
    }
    if (p_a_yment_status == 2) {
        if (express_status == 1) {
            return OrderState_no_delivery; // 已付款 未发货
        }
        return OrderState_delivery;// 已付款 已发货
    }
    
    return OrderState_nop_a_y;
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
