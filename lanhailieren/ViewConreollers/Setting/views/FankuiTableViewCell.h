//
//  FankuiTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/9.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplyView.h"
@interface FankuiTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView * iconImageView;

@property (nonatomic, strong)UILabel * tipLB;
@property (nonatomic, strong)UIView * seperateLine;

@property (nonatomic, strong)UILabel * contentLB;
@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, strong)ReplyView * replayView;

@property (nonatomic,strong) UIImageView            *imageView1;
@property (nonatomic,strong) UIImageView            *imageView2;
@property (nonatomic,strong) UIImageView            *imageView3;

- (void)refreshUIWith:(NSDictionary *)infoDic;

@end
