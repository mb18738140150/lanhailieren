//
//  UserModel.h
//  Accountant
//
//  Created by aaa on 2017/2/28.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>

@property (nonatomic,assign) int                 userID;

@property (nonatomic,assign) BOOL                isLogin;

@property (nonatomic,strong) NSString           *userName;

@property (nonatomic,strong) NSString           *userNickName;

@property (nonatomic,strong) NSString           *headImageUrl;

@property (nonatomic,strong) NSString           *telephone;

@property (nonatomic, strong) NSString          *rongToken;

@property (nonatomic, assign) int               codeview;

@property (nonatomic,assign) int                 amount;//余额

@property (nonatomic,assign) int                 point;//积分

@property (nonatomic,assign) int                 exp;//经验值

@property (nonatomic,assign) int                 status;//状态值

@property (nonatomic,assign) int                 group_id;//所属组别，会员级别
/**
 1  :   普通
 2  :   会员
 3  :   vip
 */
@property (nonatomic,strong) NSString *                 group_name;//组别名称

@property (nonatomic,assign) int                 level;

@property (nonatomic, copy)NSString                *levelDetail;

@property (nonatomic, assign)int goldCoins;

@end
