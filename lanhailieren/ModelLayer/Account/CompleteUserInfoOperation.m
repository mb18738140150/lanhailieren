//
//  CompleteUserInfoOperation.m
//  Accountant
//
//  Created by aaa on 2017/9/18.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "CompleteUserInfoOperation.h"
#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"
#import "PathUtility.h"
@interface CompleteUserInfoOperation ()<HttpRequestProtocol>

@property (nonatomic,weak) id<UserModule_CompleteUserInfoProtocol> notifiedObject;
@property (nonatomic,weak) UserModel                            *userModel;
@end

@implementation CompleteUserInfoOperation

- (void)setCurrentUser:(UserModel *)user
{
    self.userModel = user;
}

- (void)didRequestCompleteUserInfoWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CompleteUserInfoProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager]reqeustCompleteUserInfoWithDic:infoDic andProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    
    NSLog(@"successInfo = %@", successInfo);
    
    successInfo = [successInfo objectForKey:@"data"];
    self.userModel.userID = [[successInfo objectForKey:@"id"] intValue];
    self.userModel.userName = [successInfo objectForKey:@"user_name"];
    if ([[successInfo objectForKey:@"nick_name"] class] == [NSNull class] || [successInfo objectForKey:@"nick_name"] == nil || [[successInfo objectForKey:@"nick_name"] isEqualToString:@""]) {
        self.userModel.userNickName = @"用户";
    }else{
        self.userModel.userNickName = [successInfo objectForKey:@"nick_name"];
    }
    self.userModel.headImageUrl = [successInfo objectForKey:@"avatar"];
    
    if ([[successInfo objectForKey:@"phone"] class] == [NSNull class] || [successInfo objectForKey:@"phone"] == nil || [[successInfo objectForKey:@"phone"] isEqualToString:@""]) {
        self.userModel.telephone = @"未绑定";
    }else{
        self.userModel.telephone = [successInfo objectForKey:@"phone"];
    }
    self.userModel.amount = [[successInfo objectForKey:@"amount"] intValue];
    self.userModel.point = [[successInfo objectForKey:@"point"] intValue];
    self.userModel.exp = [[successInfo objectForKey:@"exp"] intValue];
    self.userModel.status = [[successInfo objectForKey:@"status"] intValue];
    self.userModel.group_id = [[successInfo objectForKey:@"group_id"] intValue];
    
    if ([[successInfo objectForKey:@"group_name"] isKindOfClass:[NSNull class]] || ![successInfo objectForKey:@"group_name"]) {
        self.userModel.group_name = @"";
    }else
    {
        self.userModel.group_name = [successInfo objectForKey:@"group_name"];
    }
    
    if ([[successInfo objectForKey:@"rongToken"] isKindOfClass:[NSNull class]] || ![successInfo objectForKey:@"rongToken"]) {
        self.userModel.rongToken = @"";
    }else
    {
        self.userModel.rongToken = [successInfo objectForKey:@"rongToken"];
    }
    self.userModel.level = [[successInfo objectForKey:@"level"] intValue];
    self.userModel.codeview = [[successInfo objectForKey:@"codeView"] intValue];
    self.userModel.levelDetail = @"";
    if (![[successInfo objectForKey:@"levelDetail"] isKindOfClass:[NSNull class]] && [successInfo objectForKey:@"levelDetail"]) {
        self.userModel.levelDetail = [successInfo objectForKey:@"levelDetail"];
    }
    
    self.userModel.isLogin = YES;
    [self encodeUserInfo];
    
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didCompleteUserSuccessed];
    }
}
- (void)encodeUserInfo
{
    NSString *dataPath = [[PathUtility getDocumentPath] stringByAppendingPathComponent:@"user.data"];
    [NSKeyedArchiver archiveRootObject:self.userModel toFile:dataPath];
}
- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didCompleteUserFailed:failInfo];
    }
}

@end
