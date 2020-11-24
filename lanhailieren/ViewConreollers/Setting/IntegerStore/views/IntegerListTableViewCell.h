//
//  IntegerListTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegerListTableViewCell : UITableViewCell

//@property (nonatomic, strong)UILabel * stateLB;

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * timeLB;

@property (nonatomic, strong)UILabel * integerLB;
@property (nonatomic, strong)UIImageView * addressImageView;

- (void)refreshUIWithInfo:(NSDictionary *)info;

- (void)refreshStoreUIWithInfo:(NSDictionary *)info;

@end

