//
//  FoodMakeCommemtHeaderTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/4/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "FoodMakeCommemtHeaderTableViewCell.h"

@implementation FoodMakeCommemtHeaderTableViewCell

- (void)refreshUI:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.backgroundColor = UIColorFromRGB(0xffffff);
    self.infoDic = infoDic;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.hd_width, self.hd_width * 0.55)];
    
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[infoDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[infoDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"] options:SDWebImageAvoidDecodeImage];
    
    [self.contentView addSubview:self.iconImageView];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.frame = CGRectMake(CGRectGetMidX(self.iconImageView.frame) - 15, CGRectGetMidY(self.iconImageView.frame) - 15, 30, 30);
    [self.playBtn setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.playBtn];
    [self.playBtn addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)playAction
{
    if (self.playBlock) {
        self.playBlock(self.infoDic);
    }
}

@end
