//
//  ChooceStoreView.m
//  lanhailieren
//
//  Created by aaa on 2020/3/12.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ChooceStoreView.h"

@implementation ChooceStoreView

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
    self.backgroundColor = [UIColor whiteColor];
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 15, 15)];
    self.iconImageView.image = [UIImage imageNamed:@"orderFood_store"];
    [self addSubview:self.iconImageView];
    
    self.storeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.storeBtn.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 10, 100, 15);
    [self.storeBtn setImage:[UIImage imageNamed:@"ic_arrow_bottom"] forState:UIControlStateNormal];
    [self.storeBtn setTitle:@"选择门店" forState:UIControlStateNormal];
    [self.storeBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    self.storeBtn.titleLabel.font = kMainFont_12;
    [self.storeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -self.storeBtn.titleLabel.hd_width - 5, 0, self.storeBtn.titleLabel.hd_width - 5)];
    [self.storeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, self.storeBtn.imageView.hd_width, 0, self.storeBtn.imageView.hd_width)];
    [self.storeBtn addTarget:self action:@selector(chooseStoreAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.storeBtn];
    
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (IS_PAD) {
        self.searchBtn.frame = CGRectMake(self.hd_width / 2 - 150, 5, 300, 25);
    }else
    {
        self.iconImageView.hidden = YES;
        self.storeBtn.frame = CGRectMake(10, 10, 100, 15);
        self.searchBtn.frame = CGRectMake(CGRectGetMaxX(self.storeBtn.frame) + 10, 5, kScreenWidth - 100 - 30, 25);
    }
    self.searchBtn.layer.cornerRadius = self.searchBtn.hd_height / 2;
    self.searchBtn.layer.masksToBounds = YES;
    self.searchBtn.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self addSubview:self.searchBtn];
    
    self.searchImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchImageBtn.frame = CGRectMake(0, 0, 100, self.searchBtn.hd_height);
    self.searchImageBtn.hd_centerX = self.searchBtn.hd_width / 2;
    [self.searchImageBtn setImage:[UIImage imageNamed:@"ic_search"] forState:UIControlStateNormal];
    [self.searchImageBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchImageBtn setTitleColor:UIColorFromRGB(0x747474) forState:UIControlStateNormal];
    self.searchImageBtn.titleLabel.font = kMainFont_12;
    [self.searchImageBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [self.searchBtn addSubview:self.searchImageBtn];
    
    [self.searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.searchImageBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.scanBtn.frame = CGRectMake(self.hd_width - 35, self.hd_height / 2 - 12, 24, 24);
    [self.scanBtn setImage:[UIImage imageNamed:@"saomiaoshibie380"] forState:UIControlStateNormal];
    [self.scanBtn addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.scanBtn];
    self.scanBtn.hidden = YES;
}

- (void)hideStoreView
{
    self.iconImageView.hidden = YES;
    self.storeBtn.hidden = YES;
    self.searchBtn.frame = CGRectMake(10, 5, self.hd_width - 20, 25);
    self.searchImageBtn.hd_centerX = self.searchBtn.hd_width / 2;
}

- (void)showScanView
{
    self.iconImageView.hidden = YES;
    self.storeBtn.hidden = YES;
    self.searchBtn.frame = CGRectMake(10, 5, self.hd_width - 20 - 35, 25);
    self.searchImageBtn.hd_centerX = self.searchBtn.hd_width / 2;
    self.scanBtn.hidden = NO;
}

- (void)resetContent:(NSString *)title
{
    [self.searchImageBtn setTitle:title forState:UIControlStateNormal];
    self.searchImageBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)chooseStoreAction
{
    if (self.ChooseStoreActionBlock) {
        self.ChooseStoreActionBlock(@{});
    }
}
- (void)searchAction
{
    if (self.searchFoodBlock) {
        self.searchFoodBlock(@{});
    }
}
- (void)resetStoreName:(NSString *)title
{
    [self.storeBtn setTitle:title forState:UIControlStateNormal];
}
- (void)scanAction
{
    if (self.scanFoodBlock) {
        self.scanFoodBlock(@{});
    }
}

@end
