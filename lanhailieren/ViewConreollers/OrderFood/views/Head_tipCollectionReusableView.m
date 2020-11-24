//
//  Head_tipCollectionReusableView.m
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "Head_tipCollectionReusableView.h"

@interface Head_tipCollectionReusableView()
@property (nonatomic, strong)UILabel * orderBtn;
@property (nonatomic, strong)UIView * seperateView;
@property (nonatomic, strong)UIButton* checkAllBtn;
@property (nonatomic, strong)  UIImageView * goImageView;
@property (nonatomic, strong)  UIButton * goBtn;
@end

@implementation Head_tipCollectionReusableView

- (void)refreshUIWith:(NSDictionary *)info
{
    [self removeAllSubviews];
    self.backgroundColor = [UIColor clearColor];
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.hd_width, self.hd_height)];
    footerView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, footerView.hd_width, 5)];
    seperateView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.seperateView = seperateView;
    if (IS_PAD) {
        [footerView addSubview:seperateView];
    }
    
    UILabel * orderBtn = [[UILabel alloc] init];
    orderBtn.frame = CGRectMake(15, 15, 100, 15);
    orderBtn.text = [info objectForKey:@"title"];
    orderBtn.textColor = UIColorFromRGB(0x000000);
    orderBtn.font = kMainFont;
    self.orderBtn = orderBtn;
//    [orderBtn setTitle:[info objectForKey:@"title"] forState:UIControlStateNormal];
//    [orderBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
//    orderBtn.titleLabel.font = kMainFont;
    [footerView addSubview:orderBtn];
    
    UIButton* checkAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkAllBtn.frame = CGRectMake(footerView.hd_width - 80, orderBtn.hd_y, 55, 15);
    checkAllBtn.titleLabel.font = kMainFont_12;
    checkAllBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [checkAllBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [checkAllBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
    self.checkAllBtn = checkAllBtn;
    [footerView addSubview:checkAllBtn];
    
    UIImageView * goImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(checkAllBtn.frame) + 2, checkAllBtn.hd_y + 1, 8, 12)];
    goImageView.image = [UIImage imageNamed:@"ic_arrow_blue"];
    self.goImageView = goImageView;
    [footerView addSubview:goImageView];
    
    UIButton * goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goBtn.frame = CGRectMake(self.hd_width - 80, 0, 80, self.hd_height);
    goBtn.backgroundColor = [UIColor clearColor];
    [footerView addSubview:goBtn];
    self.goBtn = goBtn;
    [goBtn addTarget:self action:@selector(goAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:footerView];
}

- (void)goAction
{
    if (self.goBlock) {
        self.goBlock(@{});
    }
}

- (void)hideGoBtn
{
    self.orderBtn.frame = CGRectMake(0, 0, 200, 30);
    self.seperateView.hidden = YES;
    self.goBtn.hidden = YES;
    self.goImageView.hidden = YES;
    self.checkAllBtn.hidden = YES;
}

- (void)refreshCenterContent:(NSDictionary *)info
{
    [self removeAllSubviews];
    self.backgroundColor = [UIColor clearColor];
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.hd_width, self.hd_height)];
    footerView.backgroundColor = UIColorFromRGB(0xffffff);
    
    NSString * str = [info objectForKey:@"title"];
    float width = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont_12} context:nil].size.width;
    
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(footerView.hd_centerX - (width + 40)/2, footerView.hd_centerY - 1, (width + 40), 1)];
    seperateView.backgroundColor = UIColorFromRGB(0x010101);
    self.seperateView = seperateView;
    [footerView addSubview:seperateView];
    
    
    UILabel * orderBtn = [[UILabel alloc] init];
    orderBtn.frame = CGRectMake(footerView.hd_centerX - (width + 10), 0, (width + 10), self.hd_height);
    orderBtn.hd_centerX = footerView.hd_centerX;
    orderBtn.backgroundColor = [UIColor whiteColor];
    orderBtn.text = [info objectForKey:@"title"];
    orderBtn.textColor = UIColorFromRGB(0x000000);
    orderBtn.font = kMainFont_12;
    orderBtn.textAlignment = NSTextAlignmentCenter;;
    self.orderBtn = orderBtn;
    [footerView addSubview:orderBtn];
    
    
    UIButton* checkAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkAllBtn.frame = CGRectMake(footerView.hd_width - 80, orderBtn.hd_centerY - 7, 55, 15);
    checkAllBtn.titleLabel.font = kMainFont_12;
    checkAllBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [checkAllBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [checkAllBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
    self.checkAllBtn = checkAllBtn;
    [footerView addSubview:checkAllBtn];
    
    UIImageView * goImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(checkAllBtn.frame) + 2, checkAllBtn.hd_y + 1, 8, 12)];
    goImageView.image = [UIImage imageNamed:@"ic_arrow_blue"];
    self.goImageView = goImageView;
    [footerView addSubview:goImageView];
    
    UIButton * goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goBtn.frame = CGRectMake(self.hd_width - 80, 0, 80, self.hd_height);
    goBtn.backgroundColor = [UIColor clearColor];
    [footerView addSubview:goBtn];
    self.goBtn = goBtn;
    [goBtn addTarget:self action:@selector(goAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.checkAllBtn.hidden = YES;
    self.goBtn.hidden = YES;
    self.goImageView.hidden = YES;
    
    [self addSubview:footerView];
}

- (void)showMore
{
    self.checkAllBtn.hidden = NO;
    self.goBtn.hidden = NO;
    self.goImageView.hidden = NO;
}

@end
