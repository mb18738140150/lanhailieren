//
//  RechargeFooterCollectionReusableView.m
//  lanhailieren
//
//  Created by aaa on 2020/3/9.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "RechargeFooterCollectionReusableView.h"
#import "QRCodeCreate.h"

@implementation RechargeFooterCollectionReusableView

- (void)refreshUIWithInfo:(NSDictionary *)infoDic
{
    self.backgroundColor = [UIColor whiteColor];
    [self removeAllSubviews];
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, self.hd_width, self.hd_height - 40)];
    
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = UIColorFromRGB(0xe8e8e8).CGColor;
    //填充的颜色
    border.fillColor = [UIColor whiteColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:backView.bounds cornerRadius:1];
    
    //设置路径
    border.path = path.CGPath;
    
    border.frame = backView.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@2, @2];
    
    backView.layer.cornerRadius = 5.f;
    backView.layer.masksToBounds = YES;
    
    [backView.layer addSublayer:border];
    [self addSubview:backView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, self.hd_width, 20)];
    self.titleLB.font = [UIFont systemFontOfSize:16];
    NSString * priceStr = [NSString stringWithFormat:@"应付金额：%@元", [infoDic objectForKey:@"price"]];
    NSMutableAttributedString *priceStr_m = [[NSMutableAttributedString alloc]initWithString:priceStr];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:kMainRedColor};
    [priceStr_m addAttributes:attribute range:NSMakeRange(5, priceStr.length - 6)];
    self.titleLB.attributedText = priceStr_m;
    
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLB];
    
    float seperateWidth = 60;
    if (IS_PAD) {
        seperateWidth = 107;
    }
    
    UIView * weixinBackView = [[UIView alloc]initWithFrame:CGRectMake((self.hd_width - 200 - seperateWidth) / 2, CGRectGetMaxY(self.titleLB.frame) + 22, 100, 100)];
    weixinBackView.backgroundColor = [UIColor whiteColor];
    weixinBackView.layer.borderColor = UIColorFromRGB(0x09BB07).CGColor;
    weixinBackView.layer.borderWidth = 1;
    [self addSubview:weixinBackView];
    
    self.weixinECodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 84, 84)];
    QRCodeCreate * qrCodeCreater = [[QRCodeCreate alloc]init];
    self.weixinECodeImageView.image = [qrCodeCreater generateQRCodeWithString:@"weixin" Size:84];
    [weixinBackView addSubview:self.weixinECodeImageView];
    
    self.weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.weixinBtn.frame = CGRectMake(weixinBackView.hd_x, CGRectGetMaxY(weixinBackView.frame) + 10, weixinBackView.hd_width, 20);
    [self.weixinBtn setImage:[UIImage imageNamed:@"wxp_a_y"] forState:UIControlStateNormal];
    [self.weixinBtn setTitle:@"微支" forState:UIControlStateNormal];
    [self.weixinBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    self.weixinBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.weixinBtn];
    
    
    UIView * zhi_f_bBackView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(weixinBackView.frame) + seperateWidth, CGRectGetMaxY(self.titleLB.frame) + 22, 100, 100)];
    zhi_f_bBackView.backgroundColor = [UIColor whiteColor];
    zhi_f_bBackView.layer.borderColor = UIColorFromRGB(0x02AAEF).CGColor;
    zhi_f_bBackView.layer.borderWidth = 1;
    [self addSubview:zhi_f_bBackView];
    
    self.zhi_f_bECodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 84, 84)];
    
    self.zhi_f_bECodeImageView.image = [qrCodeCreater generateQRCodeWithString:@"支" Size:84];
    [zhi_f_bBackView addSubview:self.zhi_f_bECodeImageView];
    
    self.zhi_f_bBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zhi_f_bBtn.frame = CGRectMake(zhi_f_bBackView.hd_x, CGRectGetMaxY(zhi_f_bBackView.frame) + 10, zhi_f_bBackView.hd_width, 20);
    [self.zhi_f_bBtn setImage:[UIImage imageNamed:@"zhi_f_b"] forState:UIControlStateNormal];
    [self.zhi_f_bBtn setTitle:@"支" forState:UIControlStateNormal];
    [self.zhi_f_bBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    self.zhi_f_bBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.zhi_f_bBtn];
    
}

@end
