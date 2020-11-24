//
//  JoinClubCollectionViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/6/16.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JoinClubCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIImageView * iconImageVIew;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * connectPersonNameLB;
@property (nonatomic, strong)UILabel * phoneLB;
@property (nonatomic, strong)UILabel * wechatLB;
@property (nonatomic, strong)UILabel * addressLB;
@property (nonatomic, strong)MAMapView * mapView;
@property (nonatomic, strong)UIButton * applyBtn;
@property (nonatomic, copy)void(^applyBlock)(NSDictionary * info);
@property (nonatomic, strong)NSDictionary * infoDic;
- (void)refreshUIWith:(NSDictionary *)infoDic;

@end

NS_ASSUME_NONNULL_END
