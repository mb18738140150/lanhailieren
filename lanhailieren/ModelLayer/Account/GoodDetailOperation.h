//
//  GoodDetailOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/3/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodDetailOperation : NSObject


@property (nonatomic, strong)NSMutableDictionary * goodDetailInfo;
- (void)didRequestGoodDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodDetailProtocol>)object;

@end
