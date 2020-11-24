//
//  ChangePasswordOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/3/26.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ChangePasswordOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"

@interface ChangePasswordOperation ()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_ChangePasswordProtocol> notifiedObject;
@end

@implementation ChangePasswordOperation

- (void)didRequestChangePasswordWithCourseInfo:(NSDictionary * )infoDic withNotifiedObject:(id<UserModule_ChangePasswordProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestOrderListWithInfoDic:infoDic andProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestChangePasswordSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestChangePasswordFailed:failInfo];
    }
}

@end
