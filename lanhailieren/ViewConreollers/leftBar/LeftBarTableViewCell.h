//
//  LeftBarTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/5.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftBarTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * countLB;

- (void)refreshUserInfoWithInfo:(NSDictionary *)info;
- (void)refreshWithInfo:(NSDictionary *)info;
- (void)refreshSelectWithInfo:(NSDictionary *)info;

- (void)resetShoppingCar;

@end


