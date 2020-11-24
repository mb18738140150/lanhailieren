//
//  MainHeaderTableViewCell_new.m
//  lanhailieren
//
//  Created by aaa on 2020/4/14.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "MainHeaderTableViewCell_new.h"

@interface MainHeaderTableViewCell_new()

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * tipLB;

@property (nonatomic, strong)UIImageView * vipView1;
@property (nonatomic, strong)UIImageView * vipView2;

@end

@implementation MainHeaderTableViewCell_new


- (void)refreshUIWithInfo:(NSDictionary *)info
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 18, 36, 36)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[info objectForKey:kUserHeaderImageUrl]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    self.iconImageView.layer.cornerRadius = self.iconImageView.hd_height / 2;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 13, CGRectGetMinY(self.iconImageView.frame) + 3, 100, 15)];
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.titleLB.font = kMainFont;
    self.titleLB.text = [info objectForKey:kUserNickName];
    NSString * titleStr = [info objectForKey:kUserNickName];
    CGFloat titleLBwidth = [titleStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont} context:nil].size.width;
    self.titleLB.hd_width = titleLBwidth + 10;
    [self.contentView addSubview:self.titleLB];
    
    self.tipLB = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.titleLB.frame) + 5, 200, 13)];
    self.tipLB.font = kMainFont_12;
    self.tipLB.textColor = UIColorFromRGB(0x999999);
    self.tipLB.text = @"好用记得分享哦~";
    [self.contentView addSubview:self.tipLB];
    
    self.vipView1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLB.frame) + 5, self.titleLB.hd_y - 1, 30, 15)];
    self.vipView1.image = [UIImage imageNamed:@"vip_senior"];
    [self.contentView addSubview:self.vipView1];
    
    self.vipView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.vipView1.frame) + 5, self.titleLB.hd_y + 1, 25, 12)];
    self.vipView2.image = [UIImage imageNamed:@"vip_ordinary"];
//    [self.contentView addSubview:self.vipView2];
    
    switch ([[info objectForKey:kGroup_id] intValue]) {
            case 0:
        case 1:
            {
                self.tipLB.text = @"好用记得分享哦~";
                self.vipView1.image = [UIImage imageNamed:@"vip_registered"];
            }
            break;
        case 2:
        {
            self.tipLB.text = @"好用记得分享哦~";
            self.vipView1.image = [UIImage imageNamed:@"vip_ordinary"];
        }
            break;
        case 3:
        {
            self.tipLB.text = @"好用记得分享哦~";
            self.vipView1.image = [UIImage imageNamed:@"vip_senior"];
        }
            break;
            
        default:
            break;
    }
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        
    }else
    {
        self.vipView1.hidden = YES;
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
