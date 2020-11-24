//
//  Food_remarkTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Food_remarkTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * contentLB;
@property (nonatomic, strong)UILabel * priceLB;
@property (nonatomic, strong)UILabel * countLB;

- (void)refreshWithInfo:(NSDictionary *)info;

@end
