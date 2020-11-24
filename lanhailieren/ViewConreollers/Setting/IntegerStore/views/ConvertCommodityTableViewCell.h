//
//  ConvertCommodityTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PackageCountView.h"

@interface ConvertCommodityTableViewCell : UITableViewCell

@property (nonatomic, strong)PackageCountView * packageCountView;
@property (nonatomic, assign)int buyCount;
@property (nonatomic, copy)void(^countBlock)(int count);

@property (nonatomic, strong)UILabel * infoLB;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * buyCountLB;
@property (nonatomic, strong)UIButton * integerBtn;


- (void)refreshUIWithInfo:(NSDictionary *)info;
@end
