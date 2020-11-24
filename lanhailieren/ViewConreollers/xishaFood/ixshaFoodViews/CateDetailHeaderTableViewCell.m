//
//  CateDetailHeaderTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/4/21.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "CateDetailHeaderTableViewCell.h"

@implementation CateDetailHeaderTableViewCell

- (void)refreshUIWith:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = self.bounds;
    
    self.bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.hd_width, self.hd_width * 0.4) imageNamesGroup:self.bannerImgUrlArray];
    self.bannerScrollView.showPageControl = YES;
    self.bannerScrollView.delegate = self;
    self.bannerScrollView.autoScrollTimeInterval = 10;
    [self.contentView addSubview:self.bannerScrollView];
    
    NSString * contentStr = @"";
    CGFloat contentHeight = [contentStr boundingRectWithSize:CGSizeMake(self.hd_width - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont_12} context:nil].size.height;
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerScrollView.frame) - 5, self.hd_width, 55)];
    self.backView.backgroundColor = [UIColor whiteColor];
    UIBezierPath * bezierpath = [UIBezierPath bezierPathWithRoundedRect:self.backView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
    shapLayer.frame = self.backView.bounds;
    shapLayer.path = bezierpath.CGPath;
    [self.backView.layer setMask: shapLayer];
    [self.contentView addSubview:self.backView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.hd_width - 20, 20)];
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.titleLB.font = kMainFont;
    [self.backView addSubview:self.titleLB];
    self.titleLB.text = [info objectForKey:@"title"];
    
    self.menuLB = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.titleLB.frame) + 5, self.titleLB.hd_width, 15)];
    self.menuLB.textColor = UIColorFromRGB(0x000000);
    self.menuLB.font = kMainFont_12;
    [self.backView addSubview:self.menuLB];
    self.menuLB.text = [info objectForKey:@"menu"];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.menuLB.frame) + 10, self.titleLB.hd_width, contentHeight + 5)];
    self.contentLB.font = kMainFont_12;
    self.contentLB.textColor = UIColorFromRGB(0x666666);
//    [self.backView addSubview:self.contentLB];
    self.contentLB.numberOfLines = 0;
    self.contentLB.text = [info objectForKey:@"content"];
}

- (void)refreshVipCustomDetailUIWith:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = self.bounds;
    self.infoDic = info;
    
    self.bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.hd_width, self.hd_width * 0.4) imageNamesGroup:self.bannerImgUrlArray];
    self.bannerScrollView.showPageControl = YES;
    self.bannerScrollView.delegate = self;
    self.bannerScrollView.autoScrollTimeInterval = 10;
    [self.contentView addSubview:self.bannerScrollView];
    
    NSString * contentStr = @"";
    CGFloat contentHeight = [contentStr boundingRectWithSize:CGSizeMake(self.hd_width - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont_12} context:nil].size.height;
    NSString * titleStr = [info objectForKey:@"title"];
    CGFloat titlewidth = [titleStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont} context:nil].size.width;
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerScrollView.frame) - 5, self.hd_width, 40 )];
    self.backView.backgroundColor = [UIColor whiteColor];
    UIBezierPath * bezierpath = [UIBezierPath bezierPathWithRoundedRect:self.backView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
    shapLayer.frame = self.backView.bounds;
    shapLayer.path = bezierpath.CGPath;
    [self.backView.layer setMask: shapLayer];
    [self.contentView addSubview:self.backView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, titlewidth + 5, 20)];
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.titleLB.font = kMainFont;
    self.titleLB.text = [info objectForKey:@"title"];
    [self.backView addSubview:self.titleLB];
    
    self.vipImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLB.frame) + 5, self.titleLB.hd_centerY - 7.5, 30, 15)];
    [self.backView addSubview:self.vipImageView];
    
    switch ([[info objectForKey:kGroup_id] intValue]) {
            case 0:
        case 1:
            {
                self.vipImageView.image = [UIImage imageNamed:@"vip_registered"];
            }
            break;
        case 2:
        {
            self.vipImageView.image = [UIImage imageNamed:@"vip_ordinary"];
        }
            break;
        case 3:
        {
            self.vipImageView.image = [UIImage imageNamed:@"vip_senior"];
        }
            break;
            
        default:
            break;
    }
    
    self.tipLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.vipImageView.frame) + 5, self.titleLB.hd_y + 2, 60, 15)];
    self.tipLB.textColor = kMainRedColor;
    self.tipLB.font = kMainFont_12;
    self.tipLB.text = @"定制服务";
    [self.backView addSubview:self.tipLB];
    
    self.customMadeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.customMadeBtn.frame = CGRectMake(self.hd_width - 60, self.titleLB.hd_centerY - 12, 50, 24);
    [self.customMadeBtn setTitle:@"定制" forState:UIControlStateNormal];
    [self.customMadeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.customMadeBtn.titleLabel.font = kMainFont_12;
    self.customMadeBtn.backgroundColor = kMainRedColor;
    self.customMadeBtn.layer.cornerRadius = 5;
    self.customMadeBtn.layer.masksToBounds = YES;
    [self.backView addSubview:self.customMadeBtn];
    
    [self.customMadeBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.titleLB.frame) + 10, self.hd_width - 20, contentHeight + 5)];
    self.contentLB.font = kMainFont_12;
    self.contentLB.textColor = UIColorFromRGB(0x666666);
    self.contentLB.numberOfLines = 0;
    self.contentLB.text = [info objectForKey:@"content"];
    [self.backView addSubview:self.contentLB];
}
- (void)operationAction:(UIButton *)button
{
    if ([button isEqual:self.customMadeBtn])
    {
        if (self.vipCustomMadeBlock) {
            self.vipCustomMadeBlock(self.infoDic);
        }
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
