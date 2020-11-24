//
//  MainHeadTableViewCell_Vip.m
//  lanhailieren
//
//  Created by aaa on 2020/4/14.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "MainHeadTableViewCell_Vip.h"


@interface MainHeadTableViewCell_Vip()

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIImageView * vipImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * tipLB;
@property (nonatomic, strong)UIButton * goBtn;

@end


@implementation MainHeadTableViewCell_Vip

- (void)refreshUIWithInfo:(NSDictionary *)info
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, self.hd_width - 20, 63)];
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.backView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(3, 3)];
    CAShapeLayer * layer = [[CAShapeLayer alloc]init];
    layer.frame = self.backView.bounds;
    layer.path = bezierPath.CGPath;
    [self.backView.layer setMask:layer];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 1);
    gradient.frame =self.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)UIColorFromRGB(0x60ABFE).CGColor,(id)UIColorFromRGB(0x269FFF).CGColor,(id)UIColorFromRGB(0x2782F7).CGColor,nil];
    [self.backView.layer insertSublayer:gradient atIndex:0];
    
    [self.contentView addSubview:self.backView];
    
    
    self.vipImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 27, 11)];
    [self.backView addSubview:self.vipImageView];
    
    self.vipImageView.image = [UIImage imageNamed:@"icon_vip_logo"];
    
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.vipImageView.frame) + 10, 13, 100, 15)];
    self.titleLB.textColor = [UIColor whiteColor];
    self.titleLB.font = kMainFont;
    self.titleLB.text = [[[UserManager sharedManager] getUserInfos] objectForKey:kGroup_name];
    [self.backView addSubview:self.titleLB];
    
    self.tipLB = [[UILabel alloc]initWithFrame:CGRectMake(self.vipImageView.hd_x , self.backView.hd_height - 25, 100, 15)];
    self.tipLB.textColor = [UIColor whiteColor];
    self.tipLB.font = kMainFont_12;
    self.tipLB.text = @"专享定制服务~";
    [self.backView addSubview:self.tipLB];
    
    self.goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.goBtn.frame = CGRectMake(self.backView.hd_width - 70, 20, 57, 20);
    self.goBtn.backgroundColor = [UIColor whiteColor];
    self.goBtn.layer.cornerRadius = self.goBtn.hd_height / 2;
    self.goBtn.layer.masksToBounds = YES;
    [self.goBtn setTitle:@"去看看" forState:UIControlStateNormal];
    [self.goBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
    self.goBtn.titleLabel.font = kMainFont_12;
    [self.backView addSubview:self.goBtn];
    [self.goBtn addTarget:self action:@selector(vipClock) forControlEvents:UIControlEventTouchUpInside];
}

- (void)vipClock
{
    if (self.vipBlock) {
        self.vipBlock(@{});
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
