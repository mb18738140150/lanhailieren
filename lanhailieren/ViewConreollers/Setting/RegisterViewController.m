//
//  RegisterViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/5.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "RegisterDataViewController.h"

@interface RegisterViewController ()<UserModule_RegistProtocol,UserModule_VerifyCodeProtocol>

@property (nonatomic, strong)LogoView * logoView;
@property (nonatomic, strong)InputView * accountView;
@property (nonatomic, strong)InputView * verifyCodeView;
@property (nonatomic, strong)InputView * passwordView;

@property (nonatomic, strong)UIButton * nextBtn;
@property (nonatomic, strong)UIButton * loginBtn;
@property (nonatomic, strong)UIButton * forgetPsdBtn;

@property (nonatomic,strong) NSTimer                    *timer;
@property (nonatomic,assign) int                        count;
@property (nonatomic, strong)NSDate * codeDate;

@end

static int a = 59;

@implementation RegisterViewController

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
    _count = a;
    
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
    self.accountView.contentTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.accountView];
    
    self.verifyCodeView = [[InputView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.22, CGRectGetMaxY(self.accountView.frame) + 30, kScreenWidth * 0.56, 50) andImage:@"ic_verification_code" andPlaceholder:@"请输入验证码"];
    [self.verifyCodeView resetVerifyCode];
    [self.view addSubview:self.verifyCodeView];
    __weak typeof(self)weakSelf = self;
    self.verifyCodeView.GetVerifyCodeBlock = ^{
        NSLog(@"获取验证码");
        [weakSelf getVerifyCode];
    };
    
    self.passwordView = [[InputView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.22, CGRectGetMaxY(self.verifyCodeView.frame) + 20, kScreenWidth * 0.56, 50) andImage:@"input_mima" andPlaceholder:@"请输入密码"];
    [self.passwordView resetSecurite];
    self.passwordView.contentTF.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:self.passwordView];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(kScreenWidth / 2 - 90, CGRectGetMaxY(self.passwordView.frame) + 25, 180, 30);
    self.nextBtn.layer.cornerRadius = self.nextBtn.hd_height / 2;
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.backgroundColor = kMainRedColor;
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nextAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBtn];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(self.accountView.hd_x, CGRectGetMaxY(self.nextBtn.frame) + 22, 80, 15);
    NSDictionary * attributeDic = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSForegroundColorAttributeName:kMainRedColor,NSUnderlineColorAttributeName:kMainRedColor,NSFontAttributeName:kMainFont};
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"账户登录"];
    [tncString addAttributes:attributeDic range:NSMakeRange(0, tncString.length)];
    [self.loginBtn setAttributedTitle:tncString forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
    self.forgetPsdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetPsdBtn.frame = CGRectMake(CGRectGetMaxX(self.accountView.frame) - 80, CGRectGetMaxY(self.nextBtn.frame) + 22, 80, 15);
    NSMutableAttributedString* fpString = [[NSMutableAttributedString alloc] initWithString:@"忘记密码?"];
    [fpString addAttributes:attributeDic range:NSMakeRange(0, fpString.length)];
    [self.forgetPsdBtn setAttributedTitle:fpString forState:UIControlStateNormal];
    [self.forgetPsdBtn addTarget:self action:@selector(forgetPsdAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.forgetPsdBtn];
    
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
    self.accountView.contentTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.accountView];
    
    self.verifyCodeView = [[InputView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.accountView.frame) + 30, kScreenWidth  - 100, 50) andImage:@"ic_verification_code" andPlaceholder:@"请输入验证码"];
    [self.verifyCodeView resetVerifyCode];
    [self.view addSubview:self.verifyCodeView];
    
    __weak typeof(self)weakSelf = self;
    self.verifyCodeView.GetVerifyCodeBlock = ^{
        NSLog(@"获取验证码");
        [weakSelf getVerifyCode];
    };
    
    
    self.passwordView = [[InputView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.verifyCodeView.frame) + 20, kScreenWidth  - 100, 50) andImage:@"input_mima" andPlaceholder:@"请输入密码"];
    [self.passwordView resetSecurite];
    self.passwordView.contentTF.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:self.passwordView];
    
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(kScreenWidth / 2 - 90, CGRectGetMaxY(self.passwordView.frame) + 25, 180, 30);
    self.nextBtn.layer.cornerRadius = self.nextBtn.hd_height / 2;
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.backgroundColor = kMainRedColor;
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nextAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBtn];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(self.accountView.hd_x, CGRectGetMaxY(self.nextBtn.frame) + 22, 80, 15);
    NSDictionary * attributeDic = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSForegroundColorAttributeName:kMainRedColor,NSUnderlineColorAttributeName:kMainRedColor,NSFontAttributeName:kMainFont};
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"账户登录"];
    [tncString addAttributes:attributeDic range:NSMakeRange(0, tncString.length)];
    [self.loginBtn setAttributedTitle:tncString forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
    self.forgetPsdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetPsdBtn.frame = CGRectMake(CGRectGetMaxX(self.accountView.frame) - 80, CGRectGetMaxY(self.nextBtn.frame) + 22, 80, 15);
    NSMutableAttributedString* fpString = [[NSMutableAttributedString alloc] initWithString:@"忘记密码?"];
    [fpString addAttributes:attributeDic range:NSMakeRange(0, fpString.length)];
    [self.forgetPsdBtn setAttributedTitle:fpString forState:UIControlStateNormal];
    [self.forgetPsdBtn addTarget:self action:@selector(forgetPsdAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.forgetPsdBtn];
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


- (void)loginAction
{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    NSLog(@"login");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)forgetPsdAction
{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    NSLog(@"forgetPsdAction");
    ForgetPasswordViewController * forgrtPsdVC = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forgrtPsdVC animated:YES];
}

- (void)nextAction
{
    if (self.accountView.contentTF.text.length == 0 || self.passwordView.contentTF.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"手机号与密码均不能为空"];
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
    
    NSLog(@"%@", [[UserManager sharedManager] getVerifyCode]);
    NSTimeInterval seconds = [[NSDate date]timeIntervalSinceDate:self.codeDate];
    if (seconds >120) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"时间超时,请重新获取验证码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSLog(@"nextAction");
    [SVProgressHUD show];
    [[UserManager sharedManager] registWithDic:@{@"phone":self.accountView.contentTF.text,@"password":self.passwordView.contentTF.text,@"input_code":self.verifyCodeView.contentTF.text,@"auth_code":[[UserManager sharedManager] getVerifyCode],@"command":@"1"} withNotifiedObject:self];
    
    return;
}

- (void)didRegistSuccessed
{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [SVProgressHUD showSuccessWithStatus:@"注册成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        
        int userId = [[UserManager sharedManager] getUserIdFromRegidster];
        __weak typeof(self)weakSelf = self;
        RegisterDataViewController * dataVC = [[RegisterDataViewController alloc]init];
        dataVC.userId = userId;

        [self.navigationController pushViewController:dataVC animated:YES];
    });
}

- (void)didRegistFailed:(NSString *)failInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didVerifyCodeSuccessed
{
    [SVProgressHUD dismiss];
    self.codeDate = [NSDate date];
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