//
//  StoreListOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/3/18.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "StoreListOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"
@interface StoreListOperation ()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_StoreListProtocol> notifiedObject;
@end

@implementation StoreListOperation

- (void)didRequestStoreListWithCourseInfo:(NSDictionary * )infoDic withNotifiedObject:(id<UserModule_StoreListProtocol>)object
{
    
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestpayOrderWith:infoDic andProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    self.payOrderDetailInfo = successInfo;
    
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestStoreListKeyListSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestStoreListKeyListFailed:failInfo];
    }
}
@end
