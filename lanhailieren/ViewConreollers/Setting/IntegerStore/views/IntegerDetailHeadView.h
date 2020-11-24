//
//  IntegerDetailHeadView.h
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegerDetailHeadView : UIView

@property (nonatomic ,strong)UILabel * titleLB;
@property (nonatomic ,strong)UILabel * contentLB;

@property (nonatomic ,strong)UIButton * tixianBtn;
@property (nonatomic, copy)void(^tixianBlock)();

- (void)resetWithInfo:(NSDictionary *)infoDic;
- (void)showTixianBtn;

@end
