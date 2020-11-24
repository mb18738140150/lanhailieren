//
//  ConvertListTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConvertListTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * stateLB;
@property (nonatomic, strong)UILabel * timeLB;

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * integerLB;
@property (nonatomic, strong)NSDictionary * info;

- (void)refreshUIWithInfo:(NSDictionary *)info;

@end

