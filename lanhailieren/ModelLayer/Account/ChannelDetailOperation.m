//
//  ChannelDetailOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/4/29.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ChannelDetailOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"
@interface ChannelDetailOperation()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_ChannelDetailProtocol> notifiedObject;


@end

@implementation ChannelDetailOperation

- (void)didRequestChannelDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelDetailProtocol>)object{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestGoodCategoryList:infoDic withProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    self.channelDetail = [successInfo objectForKey:@"data"];
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestChannelDetailSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestChannelDetailFailed:failInfo];
    }
}
@end
