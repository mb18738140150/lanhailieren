//
//  CollectOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/4/30.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "CollectOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"
@interface CollectOperation()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_CollectProtocol> notifiedObject;


@end

@implementation CollectOperation

- (void)didRequestCollectWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CollectProtocol>)object{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestGoodCategoryList:infoDic withProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    self.channelDetail = [successInfo objectForKey:@"data"];
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestCollectSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestCollectFailed:failInfo];
    }
}
@end
