//
//  StoreListOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/3/18.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreListOperation : NSObject

@property (nonatomic, strong)NSDictionary *payOrderDetailInfo;

- (void)didRequestStoreListWithCourseInfo:(NSDictionary * )infoDic withNotifiedObject:(id<UserModule_StoreListProtocol>)object;

@end

NS_ASSUME_NONNULL_END
