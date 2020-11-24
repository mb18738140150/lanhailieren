//
//  SaveCommentOperation.m
//  lanhailieren
//
//  Created by aaa on 2020/6/1.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "SaveCommentOperation.h"

#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"
@interface SaveCommentOperation()<HttpRequestProtocol>
@property (nonatomic,weak) id<UserModule_SaveCommentProtocol> notifiedObject;


@end

@implementation SaveCommentOperation

- (void)didRequestSaveCommentWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_SaveCommentProtocol>)object{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] requestGoodCategoryList:infoDic withProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    self.channelDetail = [successInfo objectForKey:@"data"];
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didSaveCommentSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didSaveCommentFailed:failInfo];
    }
}
@end
