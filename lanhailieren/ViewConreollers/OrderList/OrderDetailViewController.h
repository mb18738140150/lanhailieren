//
//  OrderDetailViewController.h
//  lanhailieren
//
//  Created by aaa on 2020/3/12.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailViewController : ViewController

@property (nonatomic, copy)void(^cancelOrderSuccessBlock)();
@property (nonatomic, strong)NSDictionary * infoDic;

@end

NS_ASSUME_NONNULL_END
