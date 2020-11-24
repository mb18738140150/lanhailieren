//
//  GoodDetailOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/3/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "GoodDetailOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"

@interface GoodDetailOperation()<HttpRequestProtocol>

@property (nonatomic,weak) id<UserModule_GoodDetailProtocol> notifiedObject;

@end

@implementation GoodDetailOperation

- (void)didRequestGoodDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodDetailProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestGoodList:infoDic withProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    self.goodDetailInfo = [successInfo mutableCopy];
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestGoodDetailSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestGoodDetailFailed:failInfo];
    }
}


@end
