//
//  SearchHeaderView.h
//  lanhailieren
//
//  Created by aaa on 2020/3/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchHeaderView : UIView

@property (nonatomic, copy)void(^cancelSearchBlock)(NSDictionary *info);
@property (nonatomic, copy)void(^searchBlock)(NSString *key);

@end

NS_ASSUME_NONNULL_END
