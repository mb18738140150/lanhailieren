//
//  payCourseOperation.m
//  Accountant
//
//  Created by aaa on 2017/11/22.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "PayCourseOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"
@interface PayCourseOperation ()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_HotSearchProtocol> notifiedObject;
@end

@implementation PayCourseOperation

- (void)didRequestpayOrderWithCourseInfo:(NSDictionary * )infoDic withNotifiedObject:(id<UserModule_HotSearchProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestpayOrderWith:infoDic andProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    self.payOrderDetailInfo = successInfo;
    
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestHotSearchKeyListSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestHotSearchKeyListFailed:failInfo];
    }
}

@end
