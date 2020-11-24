//
//  FoodListViewController.h
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FoodListViewController : ViewController


@property (nonatomic, assign)NSString * key;// 关键字
@property (nonatomic, assign)int categor_id;// 分类id
@property (nonatomic, assign)int plate;// 板块 { 0：全部 1：必吃 2：最新 3：限时 4：精品 }
@property (nonatomic, assign)int is_hot;// 精品/热卖：1，其他不要求
@property (nonatomic, assign)int is_red;// 推荐：1，其他不要求

@end

NS_ASSUME_NONNULL_END
