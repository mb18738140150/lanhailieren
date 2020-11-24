//
//  MyCustomCollectionViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/4/15.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCustomCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView * backImageView;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UIButton * playBtn;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * timeLB;

@property (nonatomic, strong)UIImageView * stateImageView;
@property (nonatomic, strong)UILabel * stateLB;

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, copy)void (^playBlock)(NSDictionary * info);
- (void)refreshUI:(NSDictionary *)infoDic;

@end

NS_ASSUME_NONNULL_END
