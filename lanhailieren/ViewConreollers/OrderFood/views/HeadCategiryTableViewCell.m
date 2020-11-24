//
//  HeadCategiryTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "HeadCategiryTableViewCell.h"

@implementation HeadCategiryTableViewCell

- (void)refreshUIWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Head_categoryCollectionReusableView * view = [[Head_categoryCollectionReusableView alloc]initWithFrame:self.contentView.bounds];
    [view refreshUIWith:info];
    [self.contentView addSubview:view];
    __weak typeof(self)weakSelf = self;
    view.FishCategory_headClickBlock = ^(NSDictionary *info) {
        if (weakSelf.FishCategory_headTableViewClickBlock) {
            weakSelf.FishCategory_headTableViewClickBlock(info);
        }
    };
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
