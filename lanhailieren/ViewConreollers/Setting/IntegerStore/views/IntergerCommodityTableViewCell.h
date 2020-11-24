//
//  IntergerCommodityTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntergerCommodityTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * countLB;
@property (nonatomic, strong)UILabel * integerLB;
@property (nonatomic, strong)UIButton * convertBtn;

@property (nonatomic, strong)NSDictionary * info;
@property (nonatomic, copy)void (^convertCommodityBlock)(NSDictionary * info);
- (void)refreshUIWithInfo:(NSDictionary *)info;
@end

