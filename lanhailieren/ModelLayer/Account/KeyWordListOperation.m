//
//  KeyWordListOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/3/23.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "KeyWordListOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"

@interface KeyWordListOperation ()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_GetSearchKeyWordListProtocol> notifiedObject;
@end

@implementation KeyWordListOperation

- (NSMutableArray *)searchKeyWordList
{
    if (!_searchKeyWordList) {
        _searchKeyWordList = [NSMutableArray array];
    }
    return _searchKeyWordList;
}

- (void)didRequestGetSearchKeyWordListWithCourseInfo:(NSDictionary * )infoDic withNotifiedObject:(id<UserModule_GetSearchKeyWordListProtocol>)object{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestOrderListWithInfoDic:infoDic andProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    [self.searchKeyWordList removeAllObjects];
    NSArray *dataList = [successInfo objectForKey:@"data"];
    for (NSDictionary *infoDic in dataList) {
        [self.searchKeyWordList addObject:infoDic];
    }
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestGetSearchKeyWordListSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestGetSearchKeyWordListFailed:failInfo];
    }
}
@end
