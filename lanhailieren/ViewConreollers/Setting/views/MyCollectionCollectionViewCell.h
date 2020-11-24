//
//  MyCollectionCollectionViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/4/15.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCollectionCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView * backImageView;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UIButton * playBtn;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIButton * goodBtn;
@property (nonatomic, strong)UIButton * commentBtn;
@property (nonatomic, strong)UIButton * collectBtn;
@property (nonatomic, strong)UIButton * shareBtn;

@property (nonatomic, strong)UIButton * customMadeBtn;

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, copy)void (^playBlock)(NSDictionary * info);
@property (nonatomic, copy)void (^goodBlock)(NSDictionary * info);
@property (nonatomic, copy)void (^commentBlock)(NSDictionary * info);
@property (nonatomic, copy)void (^collectBlock)(NSDictionary * info);
@property (nonatomic, copy)void (^shareBlock)(NSDictionary * info);
@property (nonatomic, copy)void (^customMadeBlock)(NSDictionary * info);
- (void)refreshUI:(NSDictionary *)infoDic;

- (void)resetFoodMakeUI;
- (void)resetFoodMakeUI_Club;
@end

NS_ASSUME_NONNULL_END
