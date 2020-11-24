//
//  FooeSpecificationView.h
//  lanhailieren
//
//  Created by aaa on 2020/3/14.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FooeSpecificationView : UIView

@property (nonatomic, copy)void (^countBlock)();
@property (nonatomic, copy)void (^specificationComplateBlock)(NSDictionary * info);

- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
