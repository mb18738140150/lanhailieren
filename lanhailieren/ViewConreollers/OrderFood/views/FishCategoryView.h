//
//  FishCategoryView.h
//  lanhailieren
//
//  Created by aaa on 2020/3/12.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FishCategoryView : UIView

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UIButton * storeBtn;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)NSDictionary * info;
@property (nonatomic,copy)void(^FishCategoryClickBlock)(NSDictionary * info);

- (void)refrehUIWithInfo:(NSDictionary *)info;
- (void)refrehUIWithLocalInfo:(NSDictionary *)info;

@end
