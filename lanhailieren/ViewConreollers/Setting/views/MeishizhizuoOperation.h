//
//  MeishizhizuoOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/6/16.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeishizhizuoOperation : NSObject

@property (nonatomic, strong)NSMutableArray * channelList;

@property (nonatomic, assign)int totalCount;

@property (nonatomic, strong)NSDictionary * responseInfo;

// 商品分类
- (void)didRequestChannelListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_MeishizhizuoListProtocol>)object;


@end

NS_ASSUME_NONNULL_END
