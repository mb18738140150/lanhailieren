//
//  ChannelListOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/4/29.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ChannelListOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"
@interface ChannelListOperation()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_ChannelListProtocol> notifiedObject;


@end

@implementation ChannelListOperation

- (void)didRequestChannelListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object
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
        [self.notifiedObject didRequestChannelListSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestChannelListFailed:failInfo];
    }
}

@end
