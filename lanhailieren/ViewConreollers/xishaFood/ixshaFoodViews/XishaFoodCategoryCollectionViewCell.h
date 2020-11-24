//
//  XishaFoodCategoryCollectionViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/4/20.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XishaFoodCategoryCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView * backImageView;

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * contentLB;

- (void)refreshUIWithInfo:(NSDictionary *)infoDic;

@end

NS_ASSUME_NONNULL_END
