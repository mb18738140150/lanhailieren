//
//  AddSearchKeyWordOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/3/23.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "AddSearchKeyWordOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"

@interface AddSearchKeyWordOperation ()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_AddSearchKeyWordProtocol> notifiedObject;
@end

@implementation AddSearchKeyWordOperation


- (void)didRequestAddSearchKeyWordWithCourseInfo:(NSDictionary * )infoDic withNotifiedObject:(id<UserModule_AddSearchKeyWordProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestOrderListWithInfoDic:infoDic andProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestAddSearchKeyWordSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestAddSearchKeyWordFailed:failInfo];
    }
}
@end
