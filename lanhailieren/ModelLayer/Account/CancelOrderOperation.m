//
//  CancelOrderOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/3/26.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "CancelOrderOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"

@interface CancelOrderOperation ()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_CancelOrderProtocol> notifiedObject;
@end

@implementation CancelOrderOperation

- (void)didRequestCancelOrderWithCourseInfo:(NSDictionary * )infoDic withNotifiedObject:(id<UserModule_CancelOrderProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestOrderListWithInfoDic:infoDic andProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestCancelOrderSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestCancelOrderFailed:failInfo];
    }
}
@end
