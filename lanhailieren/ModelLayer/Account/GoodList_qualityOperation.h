//
//  GoodList_qualityOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/3/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodList_qualityOperation : NSObject

@property (nonatomic, strong)NSMutableDictionary * goodList_qualityInfo;

@property (nonatomic, strong)NSMutableArray * goodList_quality;

@property (nonatomic, assign)int totalCount_quality;

- (void)didRequestGoodListQualityWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodList_qualityProtocol>)object;
@end
