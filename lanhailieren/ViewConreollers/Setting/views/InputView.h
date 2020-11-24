//
//  InputView.h
//  lanhailieren
//
//  Created by aaa on 2020/3/6.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputView : UIView

- (instancetype)initWithFrame:(CGRect)frame andImage:(NSString *)imageName andPlaceholder:(NSString *)placeholder;

- (instancetype)initWithFrame:(CGRect)frame andUploadIcon:(NSString *)imageName;

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UITextField * contentTF;
@property (nonatomic, strong)UIButton * showSecriteBtn;
@property (nonatomic, strong)UIButton * verifyCodeBtn;
@property (nonatomic, strong)UIView * seperateView;

@property (nonatomic, strong)UIButton * uploadIconBtn;
@property (nonatomic, strong)UIImageView * uploadImageView;

@property (nonatomic, copy)void(^GetVerifyCodeBlock)();

@property (nonatomic, copy)void(^UploadIconImageBlock)();


- (void)resetSecurite;
- (void)resetVerifyCode;
- (void)resetUploadBtnWithImage:(UIImage *)image;
- (void)prepareUploadUI;

@end

