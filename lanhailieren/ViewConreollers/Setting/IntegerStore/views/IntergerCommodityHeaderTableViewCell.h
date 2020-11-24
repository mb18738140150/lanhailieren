//
//  IntergerCommodityHeaderTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntergerCommodityHeaderTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView * backImageView;
@property (nonatomic, strong)UIImageView * coinImageView;
@property (nonatomic, strong)UILabel * integerCountLB;
@property (nonatomic, strong)UIButton * listBtn;
@property (nonatomic, strong)UIButton * integerDetailBtn;

@property (nonatomic, copy)void (^integerBuyListBlock)();
@property (nonatomic, copy)void (^integerDetailListBlock)();
- (void)refreshUIWithInfo:(NSDictionary *)info;


@end

