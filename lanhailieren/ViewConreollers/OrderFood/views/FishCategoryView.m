//
//  FishCategoryView.m
//  lanhailieren
//
//  Created by aaa on 2020/3/12.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "FishCategoryView.h"

@implementation FishCategoryView

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
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width / 2 - 20, 0, 40,  40)];
    [self addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame), self.hd_width, 20)];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.font = kMainFont_12;
    if (kScreenWidth <= 375) {
        self.titleLB.font = [UIFont systemFontOfSize:10];
    }
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    [self addSubview:self.titleLB];
    
    self.storeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.storeBtn.frame = self.bounds;
    [self addSubview:self.storeBtn];
    [self.storeBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)refrehUIWithLocalInfo:(NSDictionary *)info
{
    self.info = info;
    self.iconImageView.image = [UIImage imageNamed:[info objectForKey:@"image"]];
    self.titleLB.text = [info objectForKey:@"title"];
}

- (void)refrehUIWithInfo:(NSDictionary *)info
{
    self.info = info;
    NSString * placeImageStr = [info objectForKey:@"iconImage"];
    if (placeImageStr == nil || placeImageStr.length == 0) {
        placeImageStr = @"placeholdImage";
    }
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl, [info objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:placeImageStr]];
    self.titleLB.text = [info objectForKey:@"title"];
    if (self.titleLB.text.length > 5) {
        self.titleLB.adjustsFontSizeToFitWidth = YES;
    }
}

- (void)click
{
    if (self.FishCategoryClickBlock) {
        self.FishCategoryClickBlock(self.info);
    }
}

@end
