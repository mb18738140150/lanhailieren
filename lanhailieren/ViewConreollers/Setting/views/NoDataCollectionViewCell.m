//
//  NoDataCollectionViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/6/8.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "NoDataCollectionViewCell.h"

@implementation NoDataCollectionViewCell

- (void)refreshUI
{
    [self.contentView removeAllSubviews];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.hd_height / 2 - self.hd_width / 2, self.hd_width , self.hd_width )];
    self.iconImageView.image = [UIImage imageNamed:@"nodata"];
    [self.contentView addSubview:self.iconImageView];
}

@end
