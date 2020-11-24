//
//  RecommendOperation.m
//  Accountant
//
//  Created by aaa on 2017/12/20.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "RecommendOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"

@interface RecommendOperation ()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_RecommendProtocol> notifiedObject;
@property (nonatomic,weak) id<UserModule_RechargeDetailListProtocol> rechargeNotifiedObject;

@property (nonatomic, strong)NSNumber *commond;
@end

@implementation RecommendOperation
- (NSMutableArray *)integerDetailList
{
    if (!_integerDetailList) {
        _integerDetailList = [NSMutableArray array];
    }
        return _integerDetailList;
}

- (void)didRequestIntegralDetailListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RecommendProtocol>)object{
    self.commond = [infoDic objectForKey:kCommand];
    self.integerDetailListinfoDic = infoDic;
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestRecommendWithInfoDic:infoDic andProcessDelegate:self];
}

// 充值明细
- (void)didRequestRechargeDetailListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RechargeDetailListProtocol>)object
{
    self.commond = [infoDic objectForKey:kCommand];
    self.rechargeDetailListinfoDic = infoDic;
    self.rechargeNotifiedObject = object;
    [[HttpRequestManager sharedManager] requestRecommendWithInfoDic:infoDic andProcessDelegate:self];
}

- (void)didRequestGetIntegralWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RecommendProtocol>)object
{
    self.commond = [infoDic objectForKey:kCommand];
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestGetRecommendWithInfoDic:infoDic andProcessDelegate:self];
}

- (void)didRequestGetRecommendIntegralWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RecommendProtocol>)object
{
    self.commond = [infoDic objectForKey:kCommand];
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestGetRecommendIntegralWithInfoDic:infoDic andProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    switch (self.commond.intValue) {
        case 17:
            {
                self.integerDetailInfo = [NSMutableDictionary dictionary];
                [self.integerDetailInfo setObject:[successInfo objectForKey:@"totalCount"] forKey:@"totalCount"];
                int page_index = [[self.integerDetailListinfoDic objectForKey:@"page_index"] intValue];
                if (page_index == 1) {
                    [self.integerDetailList removeAllObjects];
                }
                
                for (NSDictionary * info in [successInfo objectForKey:@"data"]) {
                    [self.integerDetailList addObject:info];
                }
            }
            break;
        case 18:
        {
            self.rechargeDetailInfo = [NSMutableDictionary dictionary];
            [self.rechargeDetailInfo setObject:[successInfo objectForKey:@"totalCount"] forKey:@"totalCount"];
            int page_index = [[self.rechargeDetailListinfoDic objectForKey:@"page_index"] intValue];
            if (page_index == 1) {
                [self.rechargeDetailList removeAllObjects];
            }
            
            for (NSDictionary * info in [successInfo objectForKey:@"data"]) {
                [self.rechargeDetailList addObject:info];
            }
            if (isObjectNotNil(self.rechargeNotifiedObject)) {
                [self.rechargeNotifiedObject didRequestRechargeDetailListSuccessed];
            }
            return;
        }
            break;
        case 53:
            self.recommendInfo = successInfo;
            break;
            
        default:
            break;
    }
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestRecommendSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (self.commond.intValue == 18) {
        if (isObjectNotNil(self.rechargeNotifiedObject)) {
            [self.rechargeNotifiedObject didRequestRechargeDetailListFailed:failInfo];
        }
        return;
    }
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestRecommendFailed:failInfo];
    }
}
@end
