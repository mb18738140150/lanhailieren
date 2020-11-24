//
//  CleanSearchKeyWordOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/3/23.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CleanSearchKeyWordOperation : NSObject

- (void)didRequestCleanSearchKeyWordWithCourseInfo:(NSDictionary * )infoDic withNotifiedObject:(id<UserModule_CleanSearchKeyWordProtocol>)object;


@end

NS_ASSUME_NONNULL_END
