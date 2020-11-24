//
//  NoDataTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/6/8.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "NoDataTableViewCell.h"

@implementation NoDataTableViewCell

- (void)refreshUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.hd_height / 2 - self.hd_width / 2, self.hd_width , self.hd_width )];
    self.iconImageView.image = [UIImage imageNamed:@"nodata"];
    [self.contentView addSubview:self.iconImageView];
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
