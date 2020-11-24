//
//  KeyWordListOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/3/23.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyWordListOperation : NSObject

@property (nonatomic, strong)NSMutableArray *searchKeyWordList;

- (void)didRequestGetSearchKeyWordListWithCourseInfo:(NSDictionary * )infoDic withNotifiedObject:(id<UserModule_GetSearchKeyWordListProtocol>)object;

@end

NS_ASSUME_NONNULL_END
