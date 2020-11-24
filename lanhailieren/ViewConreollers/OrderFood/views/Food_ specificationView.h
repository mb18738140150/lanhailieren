//
//  Food_ specificationView.h
//  lanhailieren
//
//  Created by aaa on 2020/3/14.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>


// 弃用
NS_ASSUME_NONNULL_BEGIN

@interface Food_specificationView : UIView

@property (nonatomic, copy)void (^countBlock)();
@property (nonatomic, copy)void (^specificationComplateBlock)(NSDictionary * info);

- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
