//
//  MainHeadTableViewCell_Vip.h
//  lanhailieren
//
//  Created by aaa on 2020/4/14.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainHeadTableViewCell_Vip : UITableViewCell

@property (nonatomic, copy)void(^vipBlock)(NSDictionary * info);
- (void)refreshUIWithInfo:(NSDictionary *)info;

@end

