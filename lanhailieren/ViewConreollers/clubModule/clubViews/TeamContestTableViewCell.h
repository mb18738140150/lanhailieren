//
//  TeamContestTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/4/22.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamIntrolView.h"

@interface TeamContestTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * timeLB;

@property (nonatomic, strong)TeamIntrolView * team1;
@property (nonatomic, strong)UILabel * scoreLB1;
@property (nonatomic, strong)UILabel * seperateLB;
@property (nonatomic, strong)TeamIntrolView * team2;
@property (nonatomic, strong)UILabel * scoreLB2;

- (void)refreshUIWith:(NSDictionary *)info;

@end

