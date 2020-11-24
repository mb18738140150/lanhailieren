//
//  RechargeFooterCollectionReusableView.h
//  lanhailieren
//
//  Created by aaa on 2020/3/9.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeFooterCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UIImageView * weixinECodeImageView;
@property (nonatomic, strong)UIImageView * zhi_f_bECodeImageView;

@property (nonatomic, strong)UIButton * weixinBtn;
@property (nonatomic, strong)UIButton * zhi_f_bBtn;


- (void)refreshUIWithInfo:(NSDictionary *)infoDic;

@end
