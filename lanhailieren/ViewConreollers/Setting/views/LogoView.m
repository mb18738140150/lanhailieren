//
//  LogoView.m
//  lanhailieren
//
//  Created by aaa on 2020/3/6.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "LogoView.h"

@interface LogoView()

@end

@implementation LogoView

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
    self.logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 79, 0, 158, 65)];
//    self.logoImageView.layer.cornerRadius = self.logoImageView.hd_height / 2;
//    self.logoImageView.layer.masksToBounds = YES;
    self.logoImageView.image = [UIImage imageNamed:@"logo"];
    [self addSubview:self.logoImageView];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 47, CGRectGetMaxY(self.logoImageView.frame) + 12 + 9, 94, 2)];
    self.lineView.backgroundColor = kMainRedColor;
//    [self addSubview:self.lineView];
    
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 37, CGRectGetMaxY(self.logoImageView.frame) + 12, 74, 20)];
    self.titleLB.textColor = kMainRedColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.backgroundColor = UIColorFromRGB(0xffffff);
    self.titleLB.text = @"揽海猎人";
//    [self addSubview:self.titleLB];
}


@end
