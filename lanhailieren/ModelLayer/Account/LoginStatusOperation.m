//
//  LoginStatusOperation.m
//  Accountant
//
//  Created by aaa on 2017/2/28.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "LoginStatusOperation.h"
#import "HttpRequestManager.h"
#import "PathUtility.h"

@interface LoginStatusOperation ()

@property (nonatomic,weak) id<UserModule_LoginProtocol>          loginNotifiedObject;

@property (nonatomic,weak) UserModel                            *userModel;

@end

@implementation LoginStatusOperation

- (void)clearLoginUserInfo
{
    self.userModel.userID = 0;
    self.userModel.userName = @"";
    self.userModel.isLogin = NO;
    self.userModel.userNickName = @"";
    self.userModel.headImageUrl = @"";
    self.userModel.telephone = @"";
    self.userModel.rongToken = @"";
    self.userModel.level = 0;
    self.userModel.level = 0;
    self.userModel.goldCoins = 0;
    self.userModel.codeview = 1;
    self.userModel.amount = 0;
    self.userModel.point = 0;
    self.userModel.exp = 0;
    self.userModel.status = 0;
    self.userModel.group_id = 0;
    self.userModel.group_name = @"";
    
    [self encodeUserInfo];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"password"];
}

- (void)setCurrentUser:(UserModel *)user
{
    self.userModel = user;
}

- (void)didLoginWithUserName:(NSString *)userName andPassword:(NSString *)password withNotifiedObject:(id<UserModule_LoginProtocol>)object
{
//    self.userModel.userName = userName;
    self.loginNotifiedObject = object;
    [[HttpRequestManager sharedManager] requestLoginWithUserName:userName andPassword:password andProcessDelegate:self];
}

- (void)didLoginWith:(NSDictionary *)info withNotifiedObject:(id<UserModule_LoginProtocol>)object
{
    self.loginNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustCompleteUserInfoWithDic:info andProcessDelegate:self];
}

//- (void)didGetUserInfoWith:(NSDictionary *)info withNotifiedObject:(id<UserModule_LoginProtocol>)object
//{
//    self.loginNotifiedObject = object;
//}

- (void)encodeUserInfo
{
    NSString *dataPath = [[PathUtility getDocumentPath] stringByAppendingPathComponent:@"user.data"];
    [NSKeyedArchiver archiveRootObject:self.userModel toFile:dataPath];
}

#pragma mark - request delegate
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
    if (self.loginNotifiedObject != nil) {
        [self.loginNotifiedObject didUserLoginSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    [self clearLoginUserInfo];
    if (self.loginNotifiedObject != nil) {
        [self.loginNotifiedObject didUserLoginFailed:failInfo];
    }
}

@end
