//
//  FoodMakeCommentDetailViewController.h
//  lanhailieren
//
//  Created by aaa on 2020/4/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FoodMakeCommentDetailViewController : ViewController

@property (nonatomic, strong)NSString * channel_name;
@property (nonatomic, strong)NSDictionary * infoDic;

@property (nonatomic, copy)void (^refreshBlock)(BOOL refresh);

@end

NS_ASSUME_NONNULL_END
