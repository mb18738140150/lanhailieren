//
//  CateDetailHeaderTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/4/21.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
@interface CateDetailHeaderTableViewCell : UITableViewCell<SDCycleScrollViewDelegate>

@property (nonatomic,strong) SDCycleScrollView          *bannerScrollView;
@property (nonatomic,strong) NSArray *bannerImgUrlArray;

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * contentLB;
@property (nonatomic, strong)UILabel * menuLB;

// 定制
@property (nonatomic, strong)UIImageView * vipImageView;
@property (nonatomic, strong)UILabel * tipLB;
@property (nonatomic, strong)UIButton * customMadeBtn;
@property (nonatomic, copy)void (^vipCustomMadeBlock)(NSDictionary * info);

@property (nonatomic, strong)NSDictionary * infoDic;
- (void)refreshUIWith:(NSDictionary *)info;

- (void)refreshVipCustomDetailUIWith:(NSDictionary *)info;

@end

