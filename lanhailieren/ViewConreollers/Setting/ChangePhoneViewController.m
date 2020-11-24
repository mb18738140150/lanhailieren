//
//  ChangePhoneViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/26.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ChangePhoneViewController.h"

@interface ChangePhoneViewController ()<UserModule_VerifyCodeProtocol,UserModule_ChangePhoneProtocol>
@property (nonatomic, strong)LogoView * logoView;
@property (nonatomic, strong)InputView * accountView;
@property (nonatomic, strong)InputView * verifyCodeView;
@property (nonatomic, strong)InputView * passwordView;

@property (nonatomic, strong)UIButton * sureBtn;
@property (nonatomic, strong)UIButton * registerBtn;
@property (nonatomic, strong)UIButton * logBtn;
@property (nonatomic,strong) NSTimer                    *timer;
@property (nonatomic,assign) int                        count;
@property (nonatomic, strong)NSDate * codeDate;

@property (nonatomic, strong)NSString * auth_code;

@end

static int a = 59;

@implementation ChangePhoneViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _count = a;
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
    self.navigationItem.title = @"修改手机号";
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
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
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
    
    self.logoView = [[LogoView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.154, kScreenWidth, 77)];
    [self.view addSubview:self.logoView];
    
    self.accountView = [[InputView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.22, CGRectGetMaxY(self.logoView.frame) + 30, kScreenWidth * 0.56, 50) andImage:@"ic_tel" andPlaceholder:@"请输入手机号"];
    [self.view addSubview:self.accountView];
    
    self.verifyCodeView = [[InputView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.22, CGRectGetMaxY(self.accountView.frame) + 30, kScreenWidth * 0.56, 50) andImage:@"ic_verification_code" andPlaceholder:@"请输入验证码"];
    [self.verifyCodeView resetVerifyCode];
    [self.view addSubview:self.verifyCodeView];
    __weak typeof(self)weakSelf = self;
    self.verifyCodeView.GetVerifyCodeBlock = ^{
        NSLog(@"获取验证码");
        [weakSelf getVerifyCode];
    };
    
    self.passwordView = [[InputView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.22, CGRectGetMaxY(self.verifyCodeView.frame) + 20, kScreenWidth * 0.56, 50) andImage:@"input_mima" andPlaceholder:@"请输入新手机号"];
    self.passwordView.contentTF.keyboardType = UIKeyboardTypeNumberPad;
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
    
    self.logoView = [[LogoView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.185, kScreenWidth, 77)];
    [self.view addSubview:self.logoView];
    
    self.accountView = [[InputView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.logoView.frame) + 30, kScreenWidth  - 100, 50) andImage:@"ic_tel" andPlaceholder:@"请输入手机号"];
    [self.view addSubview:self.accountView];
    
    self.verifyCodeView = [[InputView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.accountView.frame) + 30, kScreenWidth - 100, 50) andImage:@"ic_verification_code" andPlaceholder:@"请输入验证码"];
    [self.verifyCodeView resetVerifyCode];
    [self.view addSubview:self.verifyCodeView];
    __weak typeof(self)weakSelf = self;
    self.verifyCodeView.GetVerifyCodeBlock = ^{
        NSLog(@"获取验证码");
        [weakSelf getVerifyCode];
    };
    
    self.passwordView = [[InputView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.verifyCodeView.frame) + 20, kScreenWidth  - 100, 50) andImage:@"input_mima" andPlaceholder:@"请输入新手机号"];
    self.passwordView.contentTF.keyboardType = UIKeyboardTypeNumberPad;
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

- (void)getVerifyCode
{
    if (self.accountView.contentTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    [[UserManager sharedManager] getVerifyCodeWithPhoneNumber:@{@"phone":self.accountView.contentTF.text,@"command":@"2"} withNotifiedObject:self];
    self.verifyCodeView.verifyCodeBtn.enabled = NO;
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerRun{
    if (self.count == 0) {
        self.verifyCodeView.verifyCodeBtn.enabled = YES;
        self.count = a;
        [self.timer invalidate];
        self.timer = nil;
        [self.verifyCodeView.verifyCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        return ;
    }
    [self.verifyCodeView.verifyCodeBtn setTitle:[NSString stringWithFormat:@"%ds", self.count] forState:UIControlStateNormal];
    self.count--;
    NSLog(@"剩余 %ds",self.count);
}

- (void)sureAction
{
    NSLog(@"complate");
    
    if (self.accountView.contentTF.text.length == 0 || self.passwordView.contentTF.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if ( self.verifyCodeView.contentTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"验证码不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    NSTimeInterval seconds = [[NSDate date]timeIntervalSinceDate:self.codeDate];
    if (seconds >120) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"时间超时,请重新获取验证码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestChangePhoneWithCourseInfo:@{@"command":@6,@"mobile":self.accountView.contentTF.text,@"input_code":self.verifyCodeView.contentTF.text,@"auth_code":self.auth_code} withNotifiedObject:self];
    
}

- (void)didRequestChangePhoneSuccessed
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}

- (void)didRequestChangePhoneFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didVerifyCodeSuccessed
{
    [SVProgressHUD dismiss];
    self.codeDate = [NSDate date];
    self.auth_code = [[UserManager sharedManager] getVerifyCode];
}

- (void)didVerifyCodeFailed:(NSString *)failInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


@end
