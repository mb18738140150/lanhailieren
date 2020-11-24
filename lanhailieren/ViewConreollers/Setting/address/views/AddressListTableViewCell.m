//
//  AddressListTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/6.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "AddressListTableViewCell.h"

@implementation AddressListTableViewCell


- (void)refreshUIWithInfo:(NSDictionary *)infoDic
{
    self.infoDic = infoDic;
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.mapImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 17, 15, 15)];
    self.mapImageView.image = [UIImage imageNamed:@"input_ditu"];
    [self.contentView addSubview:self.mapImageView];
    
    self.informationLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.mapImageView.frame) + 10, 10, 200, 15)];
    self.informationLB.font = kMainFont;
    self.informationLB.textColor = UIColorFromRGB(0x000000);
    self.informationLB.text = [NSString stringWithFormat:@"%@    %@", [infoDic objectForKey:@"accept_name"], [infoDic objectForKey:@"mobile"]];
    [self.contentView addSubview:self.informationLB];
    
    self.addressLB = [[UILabel alloc]initWithFrame:CGRectMake(self.informationLB.hd_x, CGRectGetMaxY(self.informationLB.frame), self.contentView.hd_width - 90, 15)];
    self.addressLB.font = kMainFont;
    self.addressLB.textColor = UIColorFromRGB(0x000000);
    
    self.addressLB.text = [NSString stringWithFormat:@"%@%@%@%@", [infoDic objectForKey:@"province"]?[infoDic objectForKey:@"province"]:@"",[infoDic objectForKey:@"city"]?[infoDic objectForKey:@"city"]:@"",[infoDic objectForKey:@"area"]?[infoDic objectForKey:@"area"]:@"",[infoDic objectForKey:@"address"]];
    [self.contentView addSubview:self.addressLB];
    
    UIView * seperateVLine = [[UIView alloc]initWithFrame:CGRectMake(self.contentView.hd_width - 55, 11, 1, 28)];
    seperateVLine.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.contentView addSubview:seperateVLine];
    self.sepeLine = seperateVLine;
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editBtn.frame = CGRectMake(self.contentView.hd_width - 54, 0, 54, self.contentView.hd_height);
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [self.contentView addSubview:self.editBtn];
    self.editBtn.titleLabel.font = kMainFont;
    [self.editBtn addTarget:self action:@selector(editAddressAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.hd_height - 1, self.contentView.hd_width, 1)];
    bottomLine.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.contentView addSubview:bottomLine];
    self.bottomLine = bottomLine;
    
    
    if (infoDic == nil) {
        UILabel * noAddressLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, self.hd_height - 2)];
        noAddressLB.text = @"请先选择地址";
        noAddressLB.font = kMainFont;
        noAddressLB.textColor = UIColorFromRGB(0x000000);
        noAddressLB.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:noAddressLB];
    }
    
    self.seperateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.contentView.hd_height - 2, self.contentView.hd_width, 2)];
    self.seperateImageView.image = [UIImage imageNamed:@"ic_place_border"];
    [self.contentView addSubview:self.seperateImageView];
    self.seperateImageView.hidden = YES;
    
    
}

- (void)editAddressAction
{
    if (self.EditAddressBlock) {
        self.EditAddressBlock(self.infoDic);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)hideEditBtn
{
    self.sepeLine.hidden = YES;
    self.editBtn.hidden = YES;
}

- (void)showSeperateImageView
{
    self.seperateImageView.hidden = NO;
    self.bottomLine.hidden = YES;
}

@end
