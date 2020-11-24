//
//  StoreListTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/4/15.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreListTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * countLB;
@property (nonatomic, strong)UILabel * integerLB;
@property (nonatomic, strong)UIButton * convertBtn;

@property (nonatomic, strong)NSDictionary * info;
@property (nonatomic, copy)void (^checkVRBlock)(NSDictionary * info);
- (void)refreshUIWithInfo:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
