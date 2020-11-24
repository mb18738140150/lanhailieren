//
//  VipCustomOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/5/6.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VipCustomOperation : NSObject

@property (nonatomic, strong)NSDictionary * channelDetail;

// 商品分类
- (void)didRequestVIPCustomWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_VIPCustomProtocol>)object;
@end

NS_ASSUME_NONNULL_END
