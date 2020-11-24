//
//  GoodListOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/3/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodListOperation : NSObject

@property (nonatomic, strong)NSMutableDictionary * goodListInfo;
@property (nonatomic, strong)NSMutableDictionary * goodList_recommendInfo;
@property (nonatomic, strong)NSMutableDictionary * goodList_qualityInfo;

@property (nonatomic, strong)NSMutableArray * goodList;
@property (nonatomic, strong)NSMutableArray * goodList_recommend;
@property (nonatomic, strong)NSMutableArray * goodList_quality;

@property (nonatomic, assign)int totalCount;
@property (nonatomic, assign)int totalCount_quality;
@property (nonatomic, assign)int totalCount_recommend;

- (void)didRequestGoodListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodListProtocol>)object;

- (void)didRequestGoodListRecommendWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodList_recommendProtocol>)object;

- (void)didRequestGoodListQualityWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodList_qualityProtocol>)object;

@end

