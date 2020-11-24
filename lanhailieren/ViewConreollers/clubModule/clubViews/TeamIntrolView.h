//
//  TeamIntrolView.h
//  lanhailieren
//
//  Created by aaa on 2020/4/22.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamIntrolView : UIView

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)NSDictionary * infoDic;
- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSDictionary *)infoDic;

@end
