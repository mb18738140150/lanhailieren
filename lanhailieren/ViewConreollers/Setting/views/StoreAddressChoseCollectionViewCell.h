//
//  StoreAddressChoseCollectionViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/4/15.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreAddressChoseCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UIView * backView ;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UIImageView * stateImageView;

- (void)refreshUIWith:(NSDictionary *)info;
- (void)resetState:(BOOL)select;

@end

NS_ASSUME_NONNULL_END
