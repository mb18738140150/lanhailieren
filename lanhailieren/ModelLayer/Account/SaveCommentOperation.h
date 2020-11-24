//
//  SaveCommentOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/6/1.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaveCommentOperation : NSObject

- (void)didRequestSaveCommentWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_SaveCommentProtocol>)object;
@property (nonatomic, strong)NSDictionary * channelDetail;

@end

NS_ASSUME_NONNULL_END
