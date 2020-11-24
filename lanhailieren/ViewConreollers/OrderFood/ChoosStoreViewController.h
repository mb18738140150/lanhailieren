//
//  ChoosStoreViewController.h
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChoosStoreViewController : ViewController

@property (nonatomic, copy)void (^chooseStoreBlock)(NSDictionary * info);
@property (nonatomic, copy)void (^backBlock)(NSDictionary * info);


@end

NS_ASSUME_NONNULL_END
