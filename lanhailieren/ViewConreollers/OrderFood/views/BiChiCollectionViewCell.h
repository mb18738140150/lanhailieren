//
//  BiChiCollectionViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/12.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BiChiCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView * backImageView;

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * contentLB;

- (void)refreshUIWithInfo:(NSDictionary *)infoDic;

@end

