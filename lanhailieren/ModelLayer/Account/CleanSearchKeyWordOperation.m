//
//  CleanSearchKeyWordOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/3/23.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "CleanSearchKeyWordOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"

@interface CleanSearchKeyWordOperation ()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_CleanSearchKeyWordProtocol> notifiedObject;
@end

@implementation CleanSearchKeyWordOperation


- (void)didRequestCleanSearchKeyWordWithCourseInfo:(NSDictionary * )infoDic withNotifiedObject:(id<UserModule_CleanSearchKeyWordProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestOrderListWithInfoDic:infoDic andProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestCleanSearchKeyWordSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestCleanSearchKeyWordFailed:failInfo];
    }
}
@end
