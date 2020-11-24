//
//  CollectOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/4/30.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectOperation : NSObject

@property (nonatomic, strong)NSDictionary * channelDetail;

// 商品分类
- (void)didRequestCollectWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CollectProtocol>)object;

@end

NS_ASSUME_NONNULL_END
