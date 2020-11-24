//
//  VipCustomCollectionViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/4/22.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VipCustomCollectionViewCell : UICollectionViewCell


@property (nonatomic, strong)UIImageView * backImageView;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UIButton * playBtn;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UIImageView * vipImageView;

@property (nonatomic, strong)UIButton * customMadeBtn;

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, copy)void (^playBlock)(NSDictionary * info);

@property (nonatomic, copy)void (^customMadeBlock)(NSDictionary * info);
- (void)refreshUI:(NSDictionary *)infoDic;

- (void)resetFoodMakeUI;


@end

NS_ASSUME_NONNULL_END
