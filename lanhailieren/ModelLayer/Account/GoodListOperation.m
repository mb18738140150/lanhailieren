//
//  GoodListOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/3/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "GoodListOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"

@interface GoodListOperation()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_GoodListProtocol> notifiedObject;
@property (nonatomic,weak) id<UserModule_GoodList_recommendProtocol> recommendNotifiedObject;
@property (nonatomic,weak) id<UserModule_GoodList_qualityProtocol> qualityNotifiedObject;

@end

@implementation GoodListOperation

- (NSMutableArray *)goodList
{
    if (!_goodList) {
        _goodList = [NSMutableArray array];
    }
    return _goodList;
}

- (NSMutableArray *)goodList_quality
{
    if (!_goodList_quality) {
        _goodList_quality = [NSMutableArray array];
    }
    return _goodList_quality;
}

- (NSMutableArray *)goodList_recommend
{
    if (!_goodList_recommend) {
        _goodList_recommend = [NSMutableArray array];
    }
    return _goodList_recommend;
}

- (void)didRequestGoodListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodListProtocol>)object
{
    self.goodListInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestGoodList:infoDic withProcessDelegate:self];
}

- (void)didRequestGoodListRecommendWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodList_recommendProtocol>)object
{
    self.goodList_recommendInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
    self.recommendNotifiedObject = object;
    [[HttpRequestManager sharedManager] requestGoodList:infoDic withProcessDelegate:self];
}

- (void)didRequestGoodListQualityWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodList_qualityProtocol>)object
{
    self.goodList_qualityInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
    self.qualityNotifiedObject = object;
    [[HttpRequestManager sharedManager] requestGoodList:infoDic withProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    if ([[self.goodListInfo objectForKey:@"command"] intValue] == 9) {
        
        NSArray * goodListInfo = [successInfo objectForKey:@"data"];
        self.totalCount = [[successInfo objectForKey:@"totalCount"] intValue];
            // 商品列表界面判断各个板块总数量，此处只获取并保存每一分页数量
        [self.goodList removeAllObjects];
        for (NSDictionary * info in goodListInfo) {
            [self.goodList addObject:info];
        }
        if (isObjectNotNil(self.notifiedObject)) {
            [self.notifiedObject didRequestGoodListSuccessed];
        }
        [self.goodListInfo setObject:@0 forKey:@"command"];
        return;
    }
    if ([[self.goodList_recommendInfo objectForKey:@"command"] intValue] == 9) {
        
        NSArray * goodListInfo = [successInfo objectForKey:@"data"];
        self.totalCount_recommend = [[successInfo objectForKey:@"totalCount"] intValue];
        int page_index = [[self.goodList_recommendInfo objectForKey:@"page_index"] intValue];
        if (page_index == 1) {
            [self.goodList_recommend removeAllObjects];
        }
        for (NSDictionary * info in goodListInfo) {
            [self.goodList_recommend addObject:info];
        }
        if (isObjectNotNil(self.recommendNotifiedObject)) {
            [self.recommendNotifiedObject didRequestGoodList_recommendSuccessed];
        }
        [self.goodList_recommendInfo setObject:@0 forKey:@"command"];
        return;
    }
    
    if ([[self.goodList_qualityInfo objectForKey:@"command"] intValue] == 9) {
        
        NSArray * goodListInfo = [successInfo objectForKey:@"data"];
        self.totalCount_quality = [[successInfo objectForKey:@"totalCount"] intValue];
        int page_index = [[self.goodList_qualityInfo objectForKey:@"page_index"] intValue];
        if (page_index == 1) {
            [self.goodList_quality removeAllObjects];
        }
        for (NSDictionary * info in goodListInfo) {
            [self.goodList_quality addObject:info];
        }
        if (isObjectNotNil(self.qualityNotifiedObject)) {
            [self.qualityNotifiedObject didRequestGoodList_qualitySuccessed];
        }
        [self.goodList_qualityInfo setObject:@0 forKey:@"command"];
        return;
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if ([[self.goodListInfo objectForKey:@"command"] intValue] == 9) {
        
        if (isObjectNotNil(self.notifiedObject)) {
            [self.notifiedObject didRequestGoodListFailed:failInfo];
        }
        [self.goodListInfo setObject:@0 forKey:@"command"];
        return;
    }
    if ([[self.goodList_recommendInfo objectForKey:@"command"] intValue] == 9) {
        
        if (isObjectNotNil(self.recommendNotifiedObject)) {
            [self.recommendNotifiedObject didRequestGoodList_recommendFailed:failInfo];
        }
        [self.goodList_recommendInfo setObject:@0 forKey:@"command"];
        return;
    }
    
    if ([[self.goodList_qualityInfo objectForKey:@"command"] intValue] == 9) {
        
        if (isObjectNotNil(self.qualityNotifiedObject)) {
            [self.qualityNotifiedObject didRequestGoodList_qualityFailed:failInfo];
        }
        [self.goodList_qualityInfo setObject:@0 forKey:@"command"];
        return;
    }
}

@end
