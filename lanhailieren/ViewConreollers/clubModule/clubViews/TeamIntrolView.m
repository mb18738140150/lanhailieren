//
//  TeamIntrolView.m
//  lanhailieren
//
//  Created by aaa on 2020/4/22.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "TeamIntrolView.h"

@implementation TeamIntrolView

- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSDictionary *)infoDic
{
    self = [super initWithFrame:frame];
    if (self) {
        self.infoDic = infoDic;
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backView = [[UIView alloc]initWithFrame:self.bounds];
    self.backView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.backView.layer.cornerRadius = 3.3;
    self.backView.layer.masksToBounds = YES;
    [self addSubview:self.backView];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, self.hd_width - 40, (self.hd_width - 40) * 0.66)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[_infoDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    [self addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.iconImageView.frame) + 20, self.hd_width - 10, 15)];
    self.titleLB.text = [self.infoDic objectForKey:@"title"];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.titleLB.font = kMainFont_10;
    [self addSubview:self.titleLB];
    
}

@end
