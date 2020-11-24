//
//  YuleshipinOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/6/16.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "YuleshipinOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"
@interface YuleshipinOperation()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_YuleshipinListProtocol> notifiedObject;


@end

@implementation YuleshipinOperation

- (void)didRequestChannelListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_YuleshipinListProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestGoodCategoryList:infoDic withProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    self.responseInfo = successInfo;
    self.channelList = [successInfo objectForKey:@"data"];
    self.totalCount = [[successInfo objectForKey:@"totalCount"] intValue];
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didYuleshipinListSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didYuleshipinListFailed:failInfo];
    }
}
@end
