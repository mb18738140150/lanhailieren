//
//  CommodityInfoTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/10.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommodityInfoTableViewCell : UITableViewCell


@property (nonatomic, strong)UILabel * infoLB;
@property (nonatomic, strong)UILabel * tedianLB;

@property (nonatomic, strong)UILabel * integerLB;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)NSDictionary * info;


- (void)refreshUIWithInfo:(NSDictionary *)info;

@end
