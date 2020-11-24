//
//  ChooceStoreView.h
//  lanhailieren
//
//  Created by aaa on 2020/3/12.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooceStoreView : UIView

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UIButton * storeBtn;
@property (nonatomic, strong)UIButton * searchBtn;
@property (nonatomic, strong)UIButton * searchImageBtn;

@property (nonatomic, strong)UIButton * scanBtn;

@property (nonatomic, copy)void(^ChooseStoreActionBlock)(NSDictionary * info);
@property (nonatomic, copy)void(^searchFoodBlock)(NSDictionary * info);
@property (nonatomic, copy)void(^scanFoodBlock)(NSDictionary * info);
- (void)hideStoreView;
- (void)showScanView;
- (void)resetStoreName:(NSString *)title;
- (void)resetContent:(NSString *)title;
@end

