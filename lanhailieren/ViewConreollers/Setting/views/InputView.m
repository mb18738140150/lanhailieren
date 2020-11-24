//
//  InputView.m
//  lanhailieren
//
//  Created by aaa on 2020/3/6.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "InputView.h"

@interface InputView()<UITextFieldDelegate>

@property (nonatomic, strong)NSString * imageName;
@property (nonatomic, strong)NSString * placeholder;

@end

@implementation InputView

- (instancetype)initWithFrame:(CGRect)frame andImage:(NSString *)imageName andPlaceholder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageName = imageName;
        self.placeholder = placeholder;
        [self prepareUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andUploadIcon:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageName = imageName;
        [self prepareUploadUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.layer.cornerRadius = self.hd_height / 2;
    self.layer.masksToBounds = YES;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 17, 15, 15)];
    self.iconImageView.image = [UIImage imageNamed:self.imageName];
    [self addSubview:self.iconImageView];
    
    self.contentTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width - 40 , self.hd_height)];
    self.contentTF.placeholder = self.placeholder;
    self.contentTF.font = kMainFont;
    self.contentTF.textColor = UIColorFromRGB(0x4e4e4e);
    self.contentTF.returnKeyType = UIReturnKeyDone;
    self.contentTF.delegate = self;
    self.contentTF.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.contentTF];

    
    self.showSecriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.showSecriteBtn.frame = CGRectMake(self.hd_width - 35, 17, 15, 15);
    [self.showSecriteBtn setImage:[UIImage imageNamed:@"ic_hidden"] forState:UIControlStateNormal];
    [self.showSecriteBtn setImage:[UIImage imageNamed:@"ic_show"] forState:UIControlStateSelected];
    [self.showSecriteBtn addTarget:self action:@selector(showPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    self.showSecriteBtn.hidden = YES;
    [self addSubview:self.showSecriteBtn];
    
    self.seperateView = [[UIView alloc]initWithFrame:CGRectMake(self.hd_width - 90, 17, 1, 15)];
    self.seperateView.backgroundColor = kMainRedColor;
    [self addSubview:self.seperateView];
    self.seperateView.hidden = YES;
    
    self.verifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.verifyCodeBtn.frame = CGRectMake(CGRectGetMaxX(self.seperateView.frame) + 1, 15, 70, 20);
    [self.verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.verifyCodeBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
    self.verifyCodeBtn.titleLabel.font = kMainFont_12;
    [self.verifyCodeBtn addTarget:self action:@selector(verifyCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.verifyCodeBtn];
    self.verifyCodeBtn.hidden = YES;
    
}

- (void)prepareUploadUI
{
    self.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.layer.cornerRadius = 18;
    self.layer.masksToBounds = YES;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 17, 15, 15)];
    self.iconImageView.image = [UIImage imageNamed:self.imageName];
    [self addSubview:self.iconImageView];
    
    self.uploadIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.uploadIconBtn.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 15, 13, 64, 64);
    
    NSString * str = kRootImageUrl;;
    self.uploadImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 15, 13, 64, 64)];
    [self.uploadImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", str,self.imageName]] placeholderImage:[UIImage imageNamed:@"shangchuantouxiang"]];
    
//    [self.uploadIconBtn setImage:[UIImage imageNamed:@"shangchuantouxiang"] forState:UIControlStateNormal];
//    [self.uploadIconBtn.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", str,self.imageName]] placeholderImage:[UIImage imageNamed:@"shangchuantouxiang"]];
    NSLog(@"%@", [NSString stringWithFormat:@"%@%@", str,self.imageName]);
    [self.uploadIconBtn addTarget:self action:@selector(uploadImageAction) forControlEvents:UIControlEventTouchUpInside];
    self.uploadIconBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:self.uploadImageView];
    [self addSubview:self.uploadIconBtn];
    
}

// 获取验证码
- (void)verifyCodeAction
{
    if (self.GetVerifyCodeBlock) {
        self.GetVerifyCodeBlock();
    }
}


- (void)resetVerifyCode
{
    self.seperateView.hidden = NO;
    self.verifyCodeBtn.hidden = NO;
}

- (void)showPasswordAction
{
    self.showSecriteBtn.selected = !self.showSecriteBtn.selected;
    
    if (self.showSecriteBtn.selected) {
        self.contentTF.secureTextEntry = NO;
    }else
    {
        self.contentTF.secureTextEntry = YES;
    }
    
}

- (void)resetSecurite
{
    self.showSecriteBtn.hidden = NO;
    self.contentTF.secureTextEntry = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)uploadImageAction
{
    if (self.UploadIconImageBlock) {
        self.UploadIconImageBlock();
    }
}

- (void)resetUploadBtnWithImage:(UIImage *)image
{
    self.uploadImageView.image = image;
//    [self.uploadIconBtn setImage:image forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
