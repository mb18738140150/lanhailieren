//
//  FoodIntroduce_imageTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/14.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodIntroduce_imageTableViewCell : UITableViewCell

@property (nonatomic, strong)UIButton * backBtn;
@property (nonatomic, strong)UIScrollView * scrollView;

@property (nonatomic, copy)void(^backFoodIntroduceBlock)(BOOL back);

- (void)refreshUIWithInfo:(NSDictionary *)info;

- (void)addBottomView;

@end
