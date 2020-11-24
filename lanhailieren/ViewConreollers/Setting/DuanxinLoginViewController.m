//
//  DuanxinLoginViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/6/5.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "DuanxinLoginViewController.h"
#import "LogoView.h"
@interface DuanxinLoginViewController ()<UserModule_VerifyCodeProtocol,UserModule_LoginProtocol>

@property (nonatomic, strong)LogoView * logoView;
@property (nonatomic, strong)InputView * accountView;
@property (nonatomic, strong)InputView * verifyCodeView;

@property (nonatomic, strong)UIButton * loginBtn;
@property (nonatomic, strong)UIButton * registerBtn;
@property (nonatomic, strong)UIButton * forgetPsdBtn;
@property (nonatomic, strong)UIButton * backBtn;

@property (nonatomic,strong) NSTimer                    *timer;
@property (nonatomic,assign) int                        count;
@property (nonatomic, strong)NSDate * codeDate;

@property (nonatomic,strong) NSString                    *auth_code;

@end

static int a = 59;
@implementation DuanxinLoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)resignTextFiled
{
    [self.accountView.contentTF resignFirstResponder];
    [self.verifyCodeView.contentTF resignFirstResponder];
}

- (void)refreshUI_iPad
{
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"bg_white"];
    [self.view addSubview:backImageView];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(10, 20, 25, 25);
    [self.backBtn setImage:[UIImage imageNamed:@"ic_fooeIntroduceback"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    
    self.logoView = [[LogoView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.185, kScreenWidth, 77)];
    [self.view addSubview:self.logoView];
    
    self.accountView = [[InputView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.22, CGRectGetMaxY(self.logoView.frame) + 30, kScreenWidth * 0.56, 50) andImage:@"ic_account" andPlaceholder:@"请输入手机号"];
    [self.view addSubview:self.accountView];
    
    
    self.verifyCodeView = [[InputView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.22, CGRectGetMaxY(self.accountView.frame) + 30, kScreenWidth * 0.56, 50) andImage:@"ic_verification_code" andPlaceholder:@"请输入验证码"];
    [self.verifyCodeView resetVerifyCode];
    [self.view addSubview:self.verifyCodeView];
    __weak typeof(self)weakSelf = self;
    self.verifyCodeView.GetVerifyCodeBlock = ^{
        NSLog(@"获取验证码");
        [weakSelf getVerifyCode];
    };
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(kScreenWidth / 2 - 90, CGRectGetMaxY(self.verifyCodeView.frame) + 25, 180, 30);
    self.loginBtn.layer.cornerRadius = self.loginBtn.hd_height / 2;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.backgroundColor = kMainRedColor;
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
}

- (void)refreshUI_iPhone
{
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"bg_white"];
    [self.view addSubview:backImageView];
    
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(10, 20, 25, 25);
    [self.backBtn setImage:[UIImage imageNamed:@"ic_fooeIntroduceback"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    
    self.logoView = [[LogoView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.185, kScreenWidth, 77)];
    [self.view addSubview:self.logoView];
    
    self.accountView = [[InputView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.logoView.frame) + 30, kScreenWidth  - 100, 50) andImage:@"ic_account" andPlaceholder:@"请输入手机号"];
    [self.view addSubview:self.accountView];
    
    self.verifyCodeView = [[InputView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.accountView.frame) + 30, kScreenWidth - 100, 50) andImage:@"ic_verification_code" andPlaceholder:@"请输入验证码"];
    [self.verifyCodeView resetVerifyCode];
    [self.view addSubview:self.verifyCodeView];
    __weak typeof(self)weakSelf = self;
    self.verifyCodeView.GetVerifyCodeBlock = ^{
        NSLog(@"获取验证码");
        [weakSelf getVerifyCode];
    };
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(kScreenWidth / 2 - 90, CGRectGetMaxY(self.verifyCodeView.frame) + 25, 180, 30);
    self.loginBtn.layer.cornerRadius = self.loginBtn.hd_height / 2;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.backgroundColor = kMainRedColor;
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
}

- (void)backAction
{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginAction
{
    NSLog(@"login");
    if (self.accountView.contentTF.text.length == 0 || self.verifyCodeView.contentTF.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"手机号与短信验证码均不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    [self resignTextFiled];
    
    if(!self.auth_code){
        self.auth_code = @"";
    }
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didLoginWith:@{@"command":@0,@"phone":self.accountView.contentTF.text,@"input_code":self.verifyCodeView.contentTF.text,@"auth_code":self.auth_code} withNotifiedObject:self];
}


- (void)getVerifyCode
{
    [self.verifyCodeView.contentTF becomeFirstResponder];
    
    if (self.accountView.contentTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    [SVProgressHUD show];
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

#pragma mark - login request Protocal
- (void)didUserLoginSuccessed
{
    
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.accountView.contentTF.text forKey:@"userName"];
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}
- (void)didUserLoginFailed:(NSString *)failedInfo
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

-(void) dealloc
{
   if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
