//
//  ChangePhoneOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/3/26.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangePhoneOperation : NSObject
- (void)didRequestChangePhoneWithCourseInfo:(NSDictionary * )infoDic withNotifiedObject:(id<UserModule_ChangePhoneProtocol>)object;


@end

NS_ASSUME_NONNULL_END
