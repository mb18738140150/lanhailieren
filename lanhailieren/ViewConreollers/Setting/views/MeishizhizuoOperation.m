//
//  MeishizhizuoOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/6/16.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "MeishizhizuoOperation.h"
#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"
@interface MeishizhizuoOperation()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_MeishizhizuoListProtocol> notifiedObject;


@end

@implementation MeishizhizuoOperation

- (void)didRequestChannelListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_MeishizhizuoListProtocol>)object
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
        [self.notifiedObject didMeishizhizuoListSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didMeishizhizuoListFailed:failInfo];
    }
}
@end
