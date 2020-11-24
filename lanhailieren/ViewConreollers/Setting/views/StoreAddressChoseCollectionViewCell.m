//
//  StoreAddressChoseCollectionViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/4/15.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "StoreAddressChoseCollectionViewCell.h"

@implementation StoreAddressChoseCollectionViewCell

- (void)refreshUIWith:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.backgroundColor = [UIColor clearColor];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, self.hd_width - 20, self.hd_height - 20)];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 3.3;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.borderWidth = 1;
    self.backView.layer.borderColor = UIColorFromRGB(0xe4e5ea).CGColor;
    [self.contentView addSubview:self.backView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.backView.hd_width - 25, self.backView.hd_height - 10)];
    self.titleLB.font = kMainFont_10;
    self.titleLB.textColor = UIColorFromRGB(0x999999);
    self.titleLB.text = [info objectForKey:@"title"];
    [self.backView addSubview:self.titleLB];
    
    self.stateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.backView.hd_width - 20, self.backView.hd_height / 2 - 5, 10, 10)];
    self.stateImageView.image = [UIImage imageNamed:@"main_go_down"];
    [self.backView addSubview:self.stateImageView];
    
}
- (void)resetState:(BOOL)select
{
    if (select) {
        self.stateImageView.image = [UIImage imageNamed:@"main_go_up"];
    }else
    {
        self.stateImageView.image = [UIImage imageNamed:@"main_go_down"];
    }
    
}

@end
