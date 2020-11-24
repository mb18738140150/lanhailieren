//
//  AddSearchKeyWordOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/3/23.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddSearchKeyWordOperation : NSObject

- (void)didRequestAddSearchKeyWordWithCourseInfo:(NSDictionary * )infoDic withNotifiedObject:(id<UserModule_AddSearchKeyWordProtocol>)object;


@end

NS_ASSUME_NONNULL_END
