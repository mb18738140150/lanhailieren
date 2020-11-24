//
//  ShowQRCodeView.h
//  lanhailieren
//
//  Created by aaa on 2020/3/11.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowQRCodeView : UIView

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIButton * closeBtn;
@property (nonatomic, strong)UILabel * priceLB;
@property (nonatomic, strong)UILabel * tipLB;

@property (nonatomic, strong)UIView * qrCodeBackView;
@property (nonatomic, strong)UIImageView * qrCodeImageView;
@property (nonatomic, strong)UIButton * p_a_yTypeBtn;

- (void)refreshQrCOdeWithInfo:(NSDictionary *)info;

@end
