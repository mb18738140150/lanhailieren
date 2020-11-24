//
//  BannerOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/3/26.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "BannerOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"

@interface BannerOperation ()<HttpRequestProtocol>

@property (nonatomic,weak) id<UserModule_BannerProtocol> notifiedObject;

@end

@implementation BannerOperation


- (void)didRequestBannerWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_BannerProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestAddressList:infoDic withProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    self.bannerList = [successInfo objectForKey:@"data"] ;
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestBannerSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestBannerFailed:failInfo];
    }
}

@end
