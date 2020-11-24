//
//  CommodityBannerTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/10.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommodityBannerTableViewCell : UITableViewCell

@property (nonatomic,strong) NSArray *bannerImgUrlArray;
@property (nonatomic, copy)void (^backBtnClickBlock)();
- (void)resetSubviews;

@end
