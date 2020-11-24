//
//  ChannelListOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/4/29.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChannelListOperation : NSObject

@property (nonatomic, strong)NSMutableArray * channelList;

@property (nonatomic, assign)int totalCount;

@property (nonatomic, strong)NSDictionary * responseInfo;

// 商品分类
- (void)didRequestChannelListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object;

@end

NS_ASSUME_NONNULL_END
