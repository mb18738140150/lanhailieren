//
//  ChangePhoneOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/3/26.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ChangePhoneOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"

@interface ChangePhoneOperation ()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_ChangePhoneProtocol> notifiedObject;
@end

@implementation ChangePhoneOperation

- (void)didRequestChangePhoneWithCourseInfo:(NSDictionary * )infoDic withNotifiedObject:(id<UserModule_ChangePhoneProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestOrderListWithInfoDic:infoDic andProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestChangePhoneSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestChangePhoneFailed:failInfo];
    }
}

@end
