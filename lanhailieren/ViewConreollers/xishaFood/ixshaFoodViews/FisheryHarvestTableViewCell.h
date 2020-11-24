//
//  FisheryHarvestTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/4/21.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FisheryHarvestTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * countLB;

@property (nonatomic, strong)NSDictionary * info;
- (void)refreshUIWithInfo:(NSDictionary *)info;
- (void)loadImage:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
