//
//  ChannelDetailOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/4/29.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChannelDetailOperation : NSObject

@property (nonatomic, strong)NSDictionary * channelDetail;

// 商品分类
- (void)didRequestChannelDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelDetailProtocol>)object;

@end

NS_ASSUME_NONNULL_END
