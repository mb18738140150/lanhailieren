//
//  OrderStrateView.m
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "OrderStrateView.h"

@implementation OrderStrateView

- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSDictionary *)info
{
    self = [super initWithFrame:frame];
    if (self) {
        self.info = info;
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 0, 25, 20)];
    self.imageView.image = [UIImage imageNamed:[self.info objectForKey:@"image"]];
    [self addSubview:self.imageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, self.hd_height - 15, self.hd_width, 15)];
    self.titleLB.font = [UIFont systemFontOfSize:13];
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = [self.info objectForKey:@"title"];
    [self addSubview:self.titleLB];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = self.bounds;
    self.btn.backgroundColor = [UIColor clearColor];
    [self.btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn];
    
}

- (void)clickAction
{
    if (self.ClickBlock) {
        self.ClickBlock(self.info);
    }
}

@end
