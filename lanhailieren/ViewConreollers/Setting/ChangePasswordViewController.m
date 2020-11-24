//
//  ChangePasswordViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/26.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UserModule_ChangePasswordProtocol>

@property (nonatomic, strong)LogoView * logoView;
@property (nonatomic, strong)InputView * accountView;
@property (nonatomic, strong)InputView * verifyCodeView;
@property (nonatomic, strong)InputView * passwordView;

@property (nonatomic, strong)UIButton * sureBtn;
@property (nonatomic, strong)UIButton * registerBtn;
@property (nonatomic, strong)UIButton * logBtn;

@end

@implementation ChangePasswordViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationViewSetup];
    
    UIControl *resignControl = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [resignControl addTarget:self action:@selector(resignTextFiled) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resignControl];
    if (IS_PAD) {
        [self refreshUI_iPad];
    }else
    {
        [self refreshUI_iPhone];
    }
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"修改密码";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kCommonMainTextColor_50};
    TeamHitBarButtonItem * leftBarItem = [TeamHitBarButtonItem leftButtonWithImage:[UIImage imageNamed:@"public-返回"] title:@""];
    [leftBarItem addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBarItem];
}

- (void)backAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)resignTextFiled
{
    [self.accountView.contentTF resignFirstResponder];
    [self.passwordView.contentTF resignFirstResponder];
    [self.verifyCodeView.contentTF resignFirstResponder];
}
- (void)refreshUI_iPad
{
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"bg_white"];
    [self.view addSubview:backImageView];
    
    self.logoView = [[LogoView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.154- kNavigationBarHeight - kStatusBarHeight, kScreenWidth, 77)];
    [self.view addSubview:self.logoView];
    
    self.accountView = [[InputView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.22, CGRectGetMaxY(self.logoView.frame) + 30, kScreenWidth * 0.56, 50) andImage:@"input_mima" andPlaceholder:@"请输入旧密码"];
    [self.accountView resetSecurite];
    self.accountView.contentTF.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:self.accountView];
    
    self.verifyCodeView = [[InputView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.22, CGRectGetMaxY(self.accountView.frame) + 30, kScreenWidth * 0.56, 50) andImage:@"input_mima" andPlaceholder:@"请输入新密码"];
    [self.verifyCodeView resetSecurite];
    self.verifyCodeView.contentTF.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:self.verifyCodeView];
    
    
    self.passwordView = [[InputView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.22, CGRectGetMaxY(self.verifyCodeView.frame) + 30, kScreenWidth * 0.56, 50) andImage:@"input_mima" andPlaceholder:@"请确认新密码"];
    [self.passwordView resetSecurite];
    self.passwordView.contentTF.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:self.passwordView];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(kScreenWidth / 2 - 90, CGRectGetMaxY(self.passwordView.frame) + 25, 180, 30);
    self.sureBtn.layer.cornerRadius = self.sureBtn.hd_height / 2;
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.backgroundColor = kMainRedColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [self.sureBtn addTarget:self action:@selector(sureAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sureBtn];
    
}
- (void)refreshUI_iPhone
{
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"bg_white"];
    [self.view addSubview:backImageView];
    
    self.logoView = [[LogoView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.185 - kNavigationBarHeight - kStatusBarHeight, kScreenWidth, 77)];
    [self.view addSubview:self.logoView];
    
    self.accountView = [[InputView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.logoView.frame) + 30, kScreenWidth  - 100, 50) andImage:@"input_mima" andPlaceholder:@"请输入旧密码"];
    [self.accountView resetSecurite];
    self.accountView.contentTF.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:self.accountView];
    
    self.verifyCodeView = [[InputView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.accountView.frame) + 30, kScreenWidth - 100, 50) andImage:@"input_mima" andPlaceholder:@"请输入新密码"];
    [self.verifyCodeView resetSecurite];
    self.verifyCodeView.contentTF.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:self.verifyCodeView];
    
    
    self.passwordView = [[InputView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.verifyCodeView.frame) + 30, kScreenWidth  - 100, 50) andImage:@"input_mima" andPlaceholder:@"请确认新密码"];
    [self.passwordView resetSecurite];
    self.passwordView.contentTF.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:self.passwordView];
    
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(kScreenWidth / 2 - 90, CGRectGetMaxY(self.passwordView.frame) + 25, 180, 30);
    self.sureBtn.layer.cornerRadius = self.sureBtn.hd_height / 2;
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.backgroundColor = kMainRedColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [self.sureBtn addTarget:self action:@selector(sureAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sureBtn];
}

- (void)sureAction
{
    NSLog(@"complate");
    
    if (self.accountView.contentTF.text.length == 0 || self.passwordView.contentTF.text.length == 0 || self.verifyCodeView.contentTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"新密码与旧密码均不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
//    NSString * oldPsd = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
//    if (![oldPsd isEqualToString:self.accountView.contentTF.text]) {
//        [SVProgressHUD showErrorWithStatus:@"旧密码有误，请重新输入"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//        });
//        return;
//    }
    
    if (![self.verifyCodeView.contentTF.text isEqualToString:self.passwordView.contentTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入新密码不一致"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestChangePasswordWithCourseInfo:@{@"command":@7,@"old_pwd":self.accountView.contentTF.text,@"new_pwd":self.verifyCodeView.contentTF.text} withNotifiedObject:self];
    
}

- (void)didRequestChangePasswordFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestChangePasswordSuccessed
{
    [[NSUserDefaults standardUserDefaults] setObject:self.passwordView.contentTF.text forKey:@"password"];
    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end
