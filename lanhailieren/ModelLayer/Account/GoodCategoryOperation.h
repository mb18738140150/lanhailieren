//
//  GoodCategoryOperation.h
//  lanhailieren
//
//  Created by aaa on 2020/3/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodCategoryOperation : NSObject

@property (nonatomic, strong)NSMutableArray * goodCategoryList;

// 商品分类
- (void)didRequestGoodCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object;

@end

NS_ASSUME_NONNULL_END
