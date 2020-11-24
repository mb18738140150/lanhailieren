//
//  FoodMakeCommemtHeaderTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/4/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FoodMakeCommemtHeaderTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UIButton * playBtn;

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, copy)void (^playBlock)(NSDictionary * info);
- (void)refreshUI:(NSDictionary *)infoDic;

@end

NS_ASSUME_NONNULL_END
