//
//  DianzanOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/4/30.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "DianzanOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"
@interface DianzanOperation()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_GoodProtocol> notifiedObject;


@end

@implementation DianzanOperation

- (void)didRequestDianzanWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestGoodCategoryList:infoDic withProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    self.channelDetail = [successInfo objectForKey:@"data"];
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestGoodSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestGoodFailed:failInfo];
    }
}
@end
