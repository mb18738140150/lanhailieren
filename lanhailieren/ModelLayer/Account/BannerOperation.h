//
//  BannerOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/3/26.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerOperation : NSObject

- (void)didRequestBannerWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_BannerProtocol>)object;
@property (nonatomic, strong)NSArray * bannerList;

@end

NS_ASSUME_NONNULL_END
