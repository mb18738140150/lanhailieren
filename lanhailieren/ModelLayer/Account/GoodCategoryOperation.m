//
//  GoodCategoryOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/3/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "GoodCategoryOperation.h"
#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"
@interface GoodCategoryOperation()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_GoodCategoryProtocol> notifiedObject;


@end

@implementation GoodCategoryOperation

- (void)didRequestGoodCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestGoodCategoryList:infoDic withProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    self.goodCategoryList = [successInfo objectForKey:@"data"];
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestGoodCategorySuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestGoodCategoryFailed:failInfo];
    }
}

@end
