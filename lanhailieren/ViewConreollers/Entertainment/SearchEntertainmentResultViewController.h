//
//  SearchEntertainmentResultViewController.h
//  lanhailieren
//
//  Created by aaa on 2020/5/6.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchEntertainmentResultViewController : ViewController
@property (nonatomic, assign)NSString * key;// 关键字
@property (nonatomic, assign)NSString * channelName;// 频道

- (void)getCurrentpage_indexInfo;

@end

NS_ASSUME_NONNULL_END
