//
//  SettingTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/5.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SettingTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * connectionInfoLB;

@property (nonatomic, strong)UIImageView * goImageView;

- (void)showGoImageView;
- (void)refreshUIWithInfo:(NSDictionary *)info;

- (void)resetConnectionInfo:(NSDictionary *)info;
- (void)resetLevelInfo:(NSDictionary *)info;

- (void)hideAllSubViews;

@end


