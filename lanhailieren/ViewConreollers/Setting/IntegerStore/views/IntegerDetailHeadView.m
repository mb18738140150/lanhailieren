//
//  IntegerDetailHeadView.m
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "IntegerDetailHeadView.h"

@implementation IntegerDetailHeadView

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
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    gradient.frame =self.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)UIColorFromRGB(0xF72929).CGColor,(id)UIColorFromRGB(0xBF0008).CGColor,nil];
    [self.layer insertSublayer:gradient atIndex:0];
    self.layer.cornerRadius = 12;
    self.layer.masksToBounds = YES;
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.hd_width, 20)];
    self.titleLB.font = kMainFont_16;
    self.titleLB.text = @"当前积分";
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLB];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLB.frame) + 20, self.hd_width, 40)];
    self.contentLB.font = [UIFont systemFontOfSize:36];
    self.contentLB.text = @"300";
    self.contentLB.textAlignment = NSTextAlignmentCenter;
    self.contentLB.textColor = [UIColor whiteColor];
    [self addSubview:self.contentLB];
    
    self.tixianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tixianBtn.frame = CGRectMake(self.hd_width - 84, 53, 67, 30);
    self.tixianBtn.layer.cornerRadius = 5;
    self.tixianBtn.layer.masksToBounds = YES;
    self.tixianBtn.backgroundColor = UIColorFromRGB(0xBF0008);
    [self.tixianBtn setTitle:@"提现" forState:UIControlStateNormal];
    self.tixianBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.tixianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:self.tixianBtn];
    self.tixianBtn.hidden = YES;
    [self.tixianBtn addTarget:self action:@selector(tixianAction) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)resetWithInfo:(NSDictionary *)infoDic
{
    self.titleLB.text = [infoDic objectForKey:@"title"];
    self.contentLB.text = [infoDic objectForKey:@"content"];
}

- (void)showTixianBtn
{
    self.tixianBtn.hidden = NO;
}
- (void)tixianAction
{
    if (self.tixianBlock) {
        self.tixianBlock();
    }
}

@end
