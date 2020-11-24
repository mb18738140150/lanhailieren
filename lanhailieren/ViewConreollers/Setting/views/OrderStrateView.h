//
//  OrderStrateView.h
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderStrateView : UIView

@property (nonatomic, strong)UIImageView * imageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UIButton * btn;
@property (nonatomic, strong)NSDictionary * info;

@property (nonatomic, copy)void (^ClickBlock)(NSDictionary * info);

- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSDictionary *)info;

@end

