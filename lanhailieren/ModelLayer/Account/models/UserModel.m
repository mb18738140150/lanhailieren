//
//  UserModel.m
//  Accountant
//
//  Created by aaa on 2017/2/28.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.userName forKey:@"userName"];
    [coder encodeObject:@(self.userID) forKey:@"userId"];
    [coder encodeObject:@(self.isLogin) forKey:@"isLogin"];
    [coder encodeObject:self.userNickName forKey:@"userNickName"];
    [coder encodeObject:self.headImageUrl forKey:@"headImageUrl"];
    [coder encodeObject:self.telephone forKey:@"telephone"];
    [coder encodeObject:@(self.level) forKey:@"level"];
    [coder encodeObject:self.rongToken forKey:@"rongToken"];
    [coder encodeObject:self.levelDetail forKey:@"levelDetail"];
    [coder encodeObject:@(self.goldCoins) forKey:@"goldCoins"];
    [coder encodeObject:@(self.amount) forKey:@"amount"];
    [coder encodeObject:@(self.point) forKey:@"point"];
    [coder encodeObject:@(self.exp) forKey:@"exp"];
    [coder encodeObject:@(self.status) forKey:@"status"];
    [coder encodeObject:@(self.group_id) forKey:@"group_id"];
    [coder encodeObject:self.group_name forKey:@"group_name"];
    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init] ) {
        self.userName = [coder decodeObjectForKey:@"userName"];
        self.userID = [[coder decodeObjectForKey:@"userId"] intValue];
        self.isLogin = [[coder decodeObjectForKey:@"isLogin"] boolValue];
        self.userNickName = [coder decodeObjectForKey:@"userNickName"];
        self.headImageUrl = [coder decodeObjectForKey:@"headImageUrl"];
        self.telephone = [coder decodeObjectForKey:@"telephone"];
        self.level = [[coder decodeObjectForKey:@"level"] intValue];
        self.rongToken = [coder decodeObjectForKey:@"rongToken"];
        self.levelDetail = [NSString stringWithFormat:@"%@", [coder decodeObjectForKey:@"levelDetail"]];
        self.goldCoins = [[coder decodeObjectForKey:@"goldCoins"] intValue];
        
        self.amount = [[coder decodeObjectForKey:@"amount"] intValue];
        self.point = [[coder decodeObjectForKey:@"point"] intValue];
        self.exp = [[coder decodeObjectForKey:@"exp"] intValue];
        self.status = [[coder decodeObjectForKey:@"status"] intValue];
        self.group_id = [[coder decodeObjectForKey:@"group_id"] intValue];
        self.group_name = [coder decodeObjectForKey:@"group_name"];
        
    }
    return self;
}

@end
