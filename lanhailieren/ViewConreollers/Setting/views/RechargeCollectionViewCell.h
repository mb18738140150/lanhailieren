//
//  RechargeCollectionViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/9.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UILabel * priceLB;
@property (nonatomic, strong)UIView * seperateLine;
@property (nonatomic, strong)UILabel * actualPriceLB;
@property (nonatomic, strong)UIImageView * selectImageView;
@property (nonatomic, strong)NSDictionary * infoDic;

- (void)refreshUIWith:(NSDictionary *)infoDic;
- (void)refreshSelectUI;

@end
