//
//  XishameishiOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/6/16.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "XishameishiOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"
@interface XishameishiOperation()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_XishameishiListProtocol> notifiedObject;


@end

@implementation XishameishiOperation

- (void)didRequestChannelListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_XishameishiListProtocol>)object
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
        [self.notifiedObject didXishameishiListSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didXishameishiListFailed:failInfo];
    }
}
@end
