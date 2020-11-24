//
//  GoodList_qualityOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/3/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "GoodList_qualityOperation.h"
#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"

@interface GoodList_qualityOperation()<HttpRequestProtocol>

@property (nonatomic,weak) id<UserModule_GoodList_qualityProtocol> qualityNotifiedObject;

@end

@implementation GoodList_qualityOperation

- (NSMutableArray *)goodList_quality
{
    if (!_goodList_quality) {
        _goodList_quality = [NSMutableArray array];
    }
    return _goodList_quality;
}

- (void)didRequestGoodListQualityWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodList_qualityProtocol>)object
{
    self.goodList_qualityInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
    self.qualityNotifiedObject = object;
    [[HttpRequestManager sharedManager] requestGoodList:infoDic withProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
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
    if ([[self.goodList_qualityInfo objectForKey:@"command"] intValue] == 9) {
        
        if (isObjectNotNil(self.qualityNotifiedObject)) {
            [self.qualityNotifiedObject didRequestGoodList_qualityFailed:failInfo];
        }
        [self.goodList_qualityInfo setObject:@0 forKey:@"command"];
        return;
    }
}


@end
