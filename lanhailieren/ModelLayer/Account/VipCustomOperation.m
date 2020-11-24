//
//  VipCustomOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/5/6.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "VipCustomOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"
@interface VipCustomOperation()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_VIPCustomProtocol> notifiedObject;


@end

@implementation VipCustomOperation

- (void)didRequestVIPCustomWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_VIPCustomProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestGoodCategoryList:infoDic withProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    self.channelDetail = [successInfo objectForKey:@"data"];
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestVIPCustomSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestVIPCustomFailed:failInfo];
    }
}
@end
