//
//  MainHeaderTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/6.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainHeaderTableViewCell : UITableViewCell

@property (nonatomic, copy)void (^stateBlock)(NSDictionary * infoDic);

- (void)refreshUIWithInfo:(NSDictionary *)info;

@end
