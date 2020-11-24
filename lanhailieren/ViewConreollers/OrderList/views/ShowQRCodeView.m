//
//  ShowQRCodeView.m
//  lanhailieren
//
//  Created by aaa on 2020/3/11.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ShowQRCodeView.h"
#import "QRCodeCreate.h"
@implementation ShowQRCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    UIView * backBlackView = [[UIView alloc]initWithFrame:self.bounds];
    backBlackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [self addSubview:backBlackView];
    
    self.backView = [[UIView alloc]init];
    if (IS_PAD) {
        self.backView.frame = CGRectMake(kScreenWidth / 2 - 240, kScreenHeight / 2 - 110, 480, 330);
    }else
    {
        self.backView.frame = CGRectMake(kScreenWidth / 2 - 160, kScreenHeight / 2 - 110, 320, 320);
    }
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
    [self addSubview:self.backView];
    
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(self.backView.hd_width - 30, 8, 22, 22);
    [self.closeBtn setImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.closeBtn];
    
    self.priceLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.closeBtn.frame) + 5, self.backView.hd_width, 20)];
    self.priceLB.textColor = UIColorFromRGB(0x000000);
    self.priceLB.font = kMainFont_16;
    self.priceLB.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:self.priceLB];
    
    self.tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.priceLB.frame) + 5, self.backView.hd_width, 20)];
    self.tipLB.font = kMainFont_16;
    self.tipLB.text = @"请扫码支_付";
    self.tipLB.textColor = UIColorFromRGB(0x000000);
    self.tipLB.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:self.tipLB];
    
    
    
    UIView * qrCodeBackView = [[UIView alloc]initWithFrame:CGRectMake(self.backView.hd_width / 2 - 75, CGRectGetMaxY(self.tipLB.frame) + 10, 150, 150)];
    qrCodeBackView.backgroundColor = [UIColor whiteColor];
    qrCodeBackView.layer.borderColor = UIColorFromRGB(0x02AAEF).CGColor;
    qrCodeBackView.layer.borderWidth = 1;
    self.qrCodeBackView = qrCodeBackView;
    [self.backView addSubview:qrCodeBackView];
    
    QRCodeCreate * qrCodeCreater = [[QRCodeCreate alloc]init];
    self.qrCodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 140, 140)];
    
    self.qrCodeImageView.image = [qrCodeCreater generateQRCodeWithString:@"支" Size:140];
    [qrCodeBackView addSubview:self.qrCodeImageView];
    
    self.p_a_yTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.p_a_yTypeBtn.frame = CGRectMake(qrCodeBackView.hd_x, CGRectGetMaxY(qrCodeBackView.frame) + 10, qrCodeBackView.hd_width, 20);
    [self.p_a_yTypeBtn setImage:[UIImage imageNamed:@"zhi_f_b"] forState:UIControlStateNormal];
    [self.p_a_yTypeBtn setTitle:@"支" forState:UIControlStateNormal];
    [self.p_a_yTypeBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    self.p_a_yTypeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.backView addSubview:self.p_a_yTypeBtn];
}

- (void)closeAction
{
    [self removeFromSuperview];
}

- (void)refreshQrCOdeWithInfo:(NSDictionary *)info
{
    NSString * priceStr = [NSString stringWithFormat:@"应付金额：%@元", [info objectForKey:@"price"]];
    NSMutableAttributedString * priceStr_m = [[NSMutableAttributedString alloc]initWithString:priceStr];
    [priceStr_m addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, priceStr.length - 6)];
    self.priceLB.attributedText = priceStr_m;
    
    if ([[info objectForKey:@"p_a_yType"] integerValue] == p_a_yModeType_zhi_f_b) {
        self.qrCodeBackView.layer.borderColor = UIColorFromRGB(0x02AAEF).CGColor;
        [self.p_a_yTypeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.p_a_yTypeBtn setTitle:@"支" forState:UIControlStateNormal];
    }else if ([[info objectForKey:@"p_a_yType"] integerValue] == p_a_yModeType_wechat)
    {
        self.qrCodeBackView.layer.borderColor = UIColorFromRGB(0x09BB07).CGColor;
        [self.p_a_yTypeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.p_a_yTypeBtn setTitle:@"微" forState:UIControlStateNormal];
    }
    
}

@end
