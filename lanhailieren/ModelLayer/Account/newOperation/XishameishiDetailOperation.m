//
//  XishameishiDetailOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/6/16.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "XishameishiDetailOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"
@interface XishameishiDetailOperation()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_XishameishiDetailProtocol> notifiedObject;


@end

@implementation XishameishiDetailOperation

// 商品分类
- (void)didRequestChannelDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_XishameishiDetailProtocol>)object{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestGoodCategoryList:infoDic withProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    self.channelDetail = [successInfo objectForKey:@"data"];
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestXishameishiDetailSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestXishameishiDetailFailed:failInfo];
    }
}
@end
