//
//  Head_categoryCollectionReusableView.h
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FishCategoryView.h"
#import "SDCycleScrollView.h"

@interface Head_categoryCollectionReusableView : UICollectionReusableView<SDCycleScrollViewDelegate>

@property (nonatomic,strong) SDCycleScrollView          *bannerScrollView;
@property (nonatomic,strong) NSArray *bannerImgUrlArray;
@property (nonatomic, strong)UIImageView * topImageView;
@property (nonatomic,copy)void(^FishCategory_headClickBlock)(NSDictionary * info);
@property (nonatomic, strong)UIView * seperateView;

@property (nonatomic, assign)int maxItem;

- (void)refreshUIWith:(NSDictionary *)info;

- (void)hideSeperateView;

@end

