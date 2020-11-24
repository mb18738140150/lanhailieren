//
//  NoDataTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/6/8.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoDataTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *iconImageView;

- (void)refreshUI;

@end

NS_ASSUME_NONNULL_END
