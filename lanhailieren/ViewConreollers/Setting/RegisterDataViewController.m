//
//  RegisterDataViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/5.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "RegisterDataViewController.h"
#import "UIImagePickerController+Nonroating.h"

@interface RegisterDataViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UserModule_CompleteUserInfoProtocol,HttpUploadProtocol>

@property (nonatomic, strong)LogoView * logoView;
@property (nonatomic, strong)InputView * accountView;
@property (nonatomic, strong)InputView * uploadImageView;

@property (nonatomic, strong)UIButton * sureBtn;
@property (nonatomic, strong)UIButton * registerBtn;
@property (nonatomic, strong)UIButton * forgetPsdBtn;

@property (nonatomic, strong)UIImagePickerController * imagePic;
@property (nonatomic, strong)UIImage                 * nImage;
@property (nonatomic, strong)NSString * iconImageStr;
@property (nonatomic, strong)NSString * iconMsg;
@end

@implementation RegisterDataViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isFromSetting) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        return;
    }
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isFromSetting) {
        [self navigationViewSetup];
    }
    
    UIControl *resignControl = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [resignControl addTarget:self action:@selector(resignTextFiled) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resignControl];
    if (IS_PAD) {
        [self refreshUI_iPad];
    }else
    {
        [self refreshUI_iPhone];
    }
    self.iconImageStr = @"";
    self.imagePic = [[UIImagePickerController alloc] init];
    _imagePic.allowsEditing = YES;
    _imagePic.delegate = self;
    
    
    if(self.isFromSetting)
    {
        self.registerBtn.hidden = YES;
    }
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"修改资料";
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
}

- (void)refreshUI_iPad
{
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"bg_white"];
    [self.view addSubview:backImageView];
    
    self.logoView = [[LogoView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.185, kScreenWidth, 77)];
    [self.view addSubview:self.logoView];
    
    self.accountView = [[InputView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.22, CGRectGetMaxY(self.logoView.frame) + 30, kScreenWidth * 0.56, 50) andImage:@"ic_nickname" andPlaceholder:@"请输入昵称"];
    self.accountView.contentTF.text = [[[UserManager sharedManager] getUserInfos] objectForKey:kUserNickName];
    [self.view addSubview:self.accountView];
    
    self.uploadImageView = [[InputView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.22, CGRectGetMaxY(self.accountView.frame) + 20, kScreenWidth * 0.56, 90) andUploadIcon:[[[UserManager sharedManager] getUserInfos] objectForKey:kUserHeaderImageUrl]];
    [self.uploadImageView resetSecurite];
    [self.uploadImageView prepareUploadUI];
    [self.view addSubview:self.uploadImageView];
    
    __weak typeof(self)weakSelf = self;
    self.uploadImageView.UploadIconImageBlock = ^{
        [weakSelf choceIconImage];
    };
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(kScreenWidth / 2 - 90, CGRectGetMaxY(self.uploadImageView.frame) + 25, 180, 30);
    self.sureBtn.layer.cornerRadius = self.sureBtn.hd_height / 2;
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.backgroundColor = kMainRedColor;
    [self.sureBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [self.sureBtn addTarget:self action:@selector(loginAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sureBtn];
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(self.accountView.hd_x, CGRectGetMaxY(self.sureBtn.frame) + 22, 80, 15);
    NSDictionary * attributeDic = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSForegroundColorAttributeName:kMainRedColor,NSUnderlineColorAttributeName:kMainRedColor,NSFontAttributeName:kMainFont};
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"新用户注册"];
    [tncString addAttributes:attributeDic range:NSMakeRange(0, tncString.length)];
    [self.registerBtn setAttributedTitle:tncString forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.registerBtn];
    
    self.forgetPsdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetPsdBtn.frame = CGRectMake(CGRectGetMaxX(self.accountView.frame) - 80, CGRectGetMaxY(self.sureBtn.frame) + 22, 80, 15);
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
    
    self.accountView = [[InputView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.logoView.frame) + 30, kScreenWidth  - 100, 50) andImage:@"ic_nickname" andPlaceholder:@"请输入昵称"];
    self.accountView.contentTF.text = [[[UserManager sharedManager] getUserInfos] objectForKey:kUserNickName];
    [self.view addSubview:self.accountView];
    
    self.uploadImageView = [[InputView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.accountView.frame) + 20, kScreenWidth  - 100, 90) andUploadIcon:[[[UserManager sharedManager] getUserInfos] objectForKey:kUserHeaderImageUrl]];
    [self.uploadImageView resetSecurite];
    [self.uploadImageView prepareUploadUI];
    
    [self.view addSubview:self.uploadImageView];
    
    __weak typeof(self)weakSelf = self;
    self.uploadImageView.UploadIconImageBlock = ^{
        [weakSelf choceIconImage];
    };
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(kScreenWidth / 2 - 90, CGRectGetMaxY(self.uploadImageView.frame) + 25, 180, 30);
    self.sureBtn.layer.cornerRadius = self.sureBtn.hd_height / 2;
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.backgroundColor = kMainRedColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [self.sureBtn addTarget:self action:@selector(loginAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sureBtn];
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(self.accountView.hd_x, CGRectGetMaxY(self.sureBtn.frame) + 22, 80, 15);
    NSDictionary * attributeDic = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSForegroundColorAttributeName:kMainRedColor,NSUnderlineColorAttributeName:kMainRedColor,NSFontAttributeName:kMainFont};
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"新用户注册"];
    [tncString addAttributes:attributeDic range:NSMakeRange(0, tncString.length)];
    [self.registerBtn setAttributedTitle:tncString forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.registerBtn];
    
    self.forgetPsdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetPsdBtn.frame = CGRectMake(CGRectGetMaxX(self.accountView.frame) - 80, CGRectGetMaxY(self.sureBtn.frame) + 22, 80, 15);
    NSMutableAttributedString* fpString = [[NSMutableAttributedString alloc] initWithString:@"忘记密码?"];
    [fpString addAttributes:attributeDic range:NSMakeRange(0, fpString.length)];
    [self.forgetPsdBtn setAttributedTitle:fpString forState:UIControlStateNormal];
    [self.forgetPsdBtn addTarget:self action:@selector(forgetPsdAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.forgetPsdBtn];
}

- (void)loginAction
{
    NSLog(@"login");
    if (self.accountView.contentTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"昵称不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if (self.nImage == nil) {
        [SVProgressHUD show];
        [[UserManager sharedManager] completeUserInfoWithDic:@{@"command":@4,@"user_id":@(self.userId),@"nick_name":self.accountView.contentTF.text,@"avatar":self.iconImageStr} withNotifiedObject:self];
    }else
    {
        [self upLoadImage:self.nImage];
    }
    
}

#pragma mark - complate userInfo protocal
- (void)didCompleteUserSuccessed
{
    [SVProgressHUD dismiss];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didCompleteUserFailed:(NSString *)failInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)registerAction
{
    NSLog(@"register");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)forgetPsdAction
{
    NSLog(@"forgetPsd");
    
}

- (void)choceIconImage
{
    
    UIAlertController * alertcontroller = [UIAlertController alertControllerWithTitle:@"选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    if(IS_PAD){
        UIPopoverPresentationController * popoverPresentationController = [alertcontroller popoverPresentationController];
        if (popoverPresentationController) {
            popoverPresentationController.sourceView = self.view;
            popoverPresentationController.sourceRect = CGRectMake(53, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - 200, kScreenWidth - 53, 200);
        }
        
    }
    
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.imagePic.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imagePic animated:YES completion:nil];
        }else
        {
            UIAlertController * tipControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有相机,请选择图库" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                ;
            }];
            [tipControl addAction:sureAction];
            [self presentViewController:tipControl animated:YES completion:nil];
            
        }
    }];
    UIAlertAction * libraryAction = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [SoftManager shareSoftManager].isPhontoLibrary = YES;
        [self presentViewController:self.imagePic animated:YES completion:nil];
    }];
    
    [alertcontroller addAction:cancleAction];
    [alertcontroller addAction:cameraAction];
    [alertcontroller addAction:libraryAction];
    
    [self presentViewController:alertcontroller animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.nImage = image;
    [self.uploadImageView resetUploadBtnWithImage:self.nImage];
    [SVProgressHUD show];
    
    [self upLoadImage:image];
    [SoftManager shareSoftManager].isPhontoLibrary = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)upLoadImage:(UIImage *)image
{
    [SVProgressHUD show];
    NSLog(@"uploadImage");
    [[HttpUploaderManager sharedManager]uploadImage:UIImagePNGRepresentation(image) withProcessDelegate:self andType:@"user"];
}
#pragma mark - uploadImageProtocol
- (void)didUploadSuccess:(NSDictionary *)successInfo
{
    [SVProgressHUD dismiss];
    self.iconImageStr = [successInfo objectForKey:@"img_url"];
    
    [[UserManager sharedManager] completeUserInfoWithDic:@{@"command":@4,@"user_id":@(self.userId),@"nick_name":self.accountView.contentTF.text,@"avatar":self.iconImageStr} withNotifiedObject:self];
}

- (void)didUploadFailed:(NSString *)uploadFailed
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:uploadFailed];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
