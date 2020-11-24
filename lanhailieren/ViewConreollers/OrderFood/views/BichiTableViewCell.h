//
//  BichiTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BichiTableViewCell : UITableViewCell

@property (nonatomic, copy)void(^plateBlock)(NSDictionary * info);

- (void)refreshUIWithInfo:(NSDictionary *)info;

@end
