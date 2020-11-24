//
//  CompleteUserInfoOperation.h
//  Accountant
//
//  Created by aaa on 2017/9/18.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModuleProtocol.h"
#import "UserModel.h"
@interface CompleteUserInfoOperation : NSObject

- (void)setCurrentUser:(UserModel *)user;

- (void)encodeUserInfo;
- (void)didRequestCompleteUserInfoWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CompleteUserInfoProtocol>)object;

@end
