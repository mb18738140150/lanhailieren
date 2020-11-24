//
//  RecommendOperation.h
//  Accountant
//
//  Created by aaa on 2017/12/20.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendOperation : NSObject

@property (nonatomic, assign)int integral;

@property (nonatomic, strong)NSDictionary * recommendInfo;
@property (nonatomic, strong)NSMutableArray * integerDetailList;
@property (nonatomic, strong)NSMutableDictionary * integerDetailInfo;
@property (nonatomic, strong)NSDictionary * integerDetailListinfoDic;

@property (nonatomic, strong)NSMutableArray * rechargeDetailList;
@property (nonatomic, strong)NSMutableDictionary * rechargeDetailInfo;
@property (nonatomic, strong)NSDictionary * rechargeDetailListinfoDic;

// 积分明细
- (void)didRequestIntegralDetailListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RecommendProtocol>)object;


- (void)didRequestGetIntegralWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RecommendProtocol>)object;

- (void)didRequestGetRecommendIntegralWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RecommendProtocol>)object;

// 充值明细
- (void)didRequestRechargeDetailListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RechargeDetailListProtocol>)object;

@end
