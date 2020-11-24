//
//  LoginViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/5.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "LoginViewController.h"
#import "LogoView.h"
#import "ForgetPasswordViewController.h"
#import "RegisterViewController.h"
#import "DuanxinLoginViewController.h"

@interface LoginViewController ()<UserModule_LoginProtocol>

@property (nonatomic, strong)LogoView * logoView;
@property (nonatomic, strong)InputView * accountView;
@property (nonatomic, strong)InputView * passwordView;

@property (nonatomic, strong)UIButton * loginBtn;
@property (nonatomic, strong)UIButton * registerBtn;
@property (nonatomic, strong)UIButton * forgetPsdBtn;
@property (nonatomic, strong)UIButton * backBtn;

@end

@implementation LoginViewController

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
    [self.passwordView.contentTF resignFirstResponder];
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
    
    self.passwordView = [[InputView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.22, CGRectGetMaxY(self.accountView.frame) + 20, kScreenWidth * 0.56, 50) andImage:@"ic_password" andPlaceholder:@"请输入密码"];
    [self.passwordView resetSecurite];
    self.passwordView.contentTF.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:self.passwordView];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(kScreenWidth / 2 - 90, CGRectGetMaxY(self.passwordView.frame) + 25, 180, 30);
    self.loginBtn.layer.cornerRadius = self.loginBtn.hd_height / 2;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.backgroundColor = kMainRedColor;
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(self.accountView.hd_x, CGRectGetMaxY(self.loginBtn.frame) + 22, 80, 15);
    NSDictionary * attributeDic = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSForegroundColorAttributeName:kMainRedColor,NSUnderlineColorAttributeName:kMainRedColor,NSFontAttributeName:kMainFont};
    
    NSString * operationStr = @"";
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]){
        operationStr = @"短信登录";
    }else
    {
        operationStr = @"注册";
    }
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:operationStr];
    
    
    [tncString addAttributes:attributeDic range:NSMakeRange(0, tncString.length)];
    [self.registerBtn setAttributedTitle:tncString forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerBtn];
    
    self.forgetPsdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetPsdBtn.frame = CGRectMake(CGRectGetMaxX(self.accountView.frame) - 80, CGRectGetMaxY(self.loginBtn.frame) + 22, 80, 15);
    NSMutableAttributedString* fpString = [[NSMutableAttributedString alloc] initWithString:@"忘记密码?"];
    [fpString addAttributes:attributeDic range:NSMakeRange(0, fpString.length)];
    [self.forgetPsdBtn setAttributedTitle:fpString forState:UIControlStateNormal];
    [self.forgetPsdBtn addTarget:self action:@selector(forgetPsdAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetPsdBtn];
    
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
    
    self.passwordView = [[InputView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.accountView.frame) + 20, kScreenWidth  - 100, 50) andImage:@"ic_password" andPlaceholder:@"请输入密码"];
    [self.passwordView resetSecurite];
    self.passwordView.contentTF.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:self.passwordView];
    
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(kScreenWidth / 2 - 90, CGRectGetMaxY(self.passwordView.frame) + 25, 180, 30);
    self.loginBtn.layer.cornerRadius = self.loginBtn.hd_height / 2;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.backgroundColor = kMainRedColor;
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(self.accountView.hd_x, CGRectGetMaxY(self.loginBtn.frame) + 22, 80, 15);
    NSDictionary * attributeDic = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSForegroundColorAttributeName:kMainRedColor,NSUnderlineColorAttributeName:kMainRedColor,NSFontAttributeName:kMainFont};
    NSString * operationStr = @"";
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]){
        operationStr = @"短信登录";
    }else
    {
        operationStr = @"注册";
    }
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:operationStr];
    [tncString addAttributes:attributeDic range:NSMakeRange(0, tncString.length)];
    [self.registerBtn setAttributedTitle:tncString forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.registerBtn];
    
    self.forgetPsdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetPsdBtn.frame = CGRectMake(CGRectGetMaxX(self.accountView.frame) - 80, CGRectGetMaxY(self.loginBtn.frame) + 22, 80, 15);
    NSMutableAttributedString* fpString = [[NSMutableAttributedString alloc] initWithString:@"忘记密码?"];
    [fpString addAttributes:attributeDic range:NSMakeRange(0, fpString.length)];
    [self.forgetPsdBtn setAttributedTitle:fpString forState:UIControlStateNormal];
    [self.forgetPsdBtn addTarget:self action:@selector(forgetPsdAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetPsdBtn];
}

- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
}

- (void)loginAction
{
    NSLog(@"login");
    if (self.accountView.contentTF.text.length == 0 || self.passwordView.contentTF.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"手机号与密码均不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    [self resignTextFiled];
    
    [SVProgressHUD show];
    [[UserManager sharedManager] loginWithUserName:self.accountView.contentTF.text andPassword:self.passwordView.contentTF.text withNotifiedObject:self];
}

- (void)registerAction
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        DuanxinLoginViewController * duanxinVC = [[DuanxinLoginViewController alloc]init];
        [self.navigationController pushViewController:duanxinVC animated:YES];
    }else
    {
        __weak typeof(self)weakSelf = self;
        NSLog(@"register");
        RegisterViewController * registPsdVC = [[RegisterViewController alloc]init];
        registPsdVC.loginBlock = ^(NSDictionary *info) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
        
        [self.navigationController pushViewController:registPsdVC animated:YES];
    }
    
}

- (void)forgetPsdAction
{
    NSLog(@"forgetPsd");
    ForgetPasswordViewController * forgrtPsdVC = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forgrtPsdVC animated:YES];
}


#pragma mark - login request Protocal
- (void)didUserLoginSuccessed
{
    [[NSUserDefaults standardUserDefaults] setObject:self.accountView.contentTF.text forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:self.passwordView.contentTF.text forKey:@"password"];
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



@end
