//
//  TouSuFanKuiViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/9.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "TouSuFanKuiViewController.h"

#import "UIMacro.h"
#import "CommonMacro.h"
#import "SVProgressHUD.h"
#import "UIUtility.h"
#import "PublishImageView.h"
#import "UIImage+Base64.h"
#import "ShowPhotoViewController.h"
#import "MKPPlaceholderTextView.h"
#import "FankuiTableViewCell.h"
#define kFankuiTableViewCellID @"FankuiTableViewCellID"

@interface TouSuFanKuiViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ShowPhotoDelegate,UITextViewDelegate,HYSegmentedControlDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)HYSegmentedControl * segmentC;
@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic,strong) UIControl          *resignControl;

@property (nonatomic,strong) UITableView        *contentTableView;

//@property (nonatomic,strong) UILabel            *titleLabel;
//@property (nonatomic,strong) UITextField        *titleField;
@property (nonatomic,strong) UILabel            *categoryLabel;
//@property (nonatomic,strong) UIButton           *selectedCategoryButton;
//@property (nonatomic,strong) UILabel            *categorySelectedLabel;
@property (nonatomic,strong) UILabel            *contentLabel;
@property (nonatomic,strong) MKPPlaceholderTextView         *contentField;

@property (nonatomic,strong) PublishImageView   *imageView1;
@property (nonatomic,strong) PublishImageView   *imageView2;
@property (nonatomic,strong) PublishImageView   *imageView3;

@property (nonatomic,assign) int                 clickImageIndex;


@property (nonatomic,strong) NSMutableArray     *imagesArray;

@property (nonatomic,strong) UIButton           *button1;
@property (nonatomic,strong) UIButton           *button2;
@property (nonatomic,strong) UIButton           *button3;
@property (nonatomic,strong) UIButton           *button4;

@property (nonatomic,assign) int                 categoryId;
@property (nonatomic,strong) NSString           *categoryName;

@property (nonatomic, strong)UIImagePickerController * imagePic;
@property (nonatomic, strong)UIImage                 * nImage;

@property (nonatomic,strong)UIButton * submitBtn;

@property (nonatomic, strong)UIScrollView * scrollView;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * adminDataSource;

@end

@implementation TouSuFanKuiViewController

- (NSMutableArray *)adminDataSource
{
    if (!_adminDataSource) {
        _adminDataSource = [NSMutableArray array];
    }
    return _adminDataSource;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
   
    self.imagesArray = [[NSMutableArray alloc] init];
    self.clickImageIndex = 0;
    [self loadData];
    [self navigationViewSetup];
    [self contentViewSetup];
    
    [self button1Click];
    
}

- (void)loadData
{
    NSDictionary * dataInfo = @{@"replyTime":@"2020-02-02 22:21:21",@"content":@"武汉一清防控持续阿卡假的你速回复雕塑回复扣水电费hi会iOS杜甫hi弄成课教案三年素花覅UR一是的覅uasnfisaunfiukjnviuni看地方鸡内金德生科技非农日弄皮肤破发IM；欧迪芬IM噢IM哦片firm哦",@"replay":@"武汉一清防控持续阿卡假的你速回复雕塑回复扣水电费hi会iOS杜甫hi弄成课教案三年素花覅UR一是的覅uasnfisaunfiukjnviuni看地方鸡内金德生科技非农日弄皮肤破发IM；欧迪芬IM噢IM哦片firm哦",@"state":@"待发货",kQuestionImgStr:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1583823033016&di=0823fe508155bec7aab1274a9c00cc2f&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F68%2F61%2F300000839764127060614318218_950.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1583823033015&di=ec85c2224ceacefccba3dca9c265ce12&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F14%2F75%2F01300000164186121366756803686.jpg"]};
    NSDictionary  * passwordFoodInfo = @{@"replyTime":@"2020-02-02 22:21:21",@"content":@"武汉一清防控持续阿卡假的你速回复雕塑回复扣水电费hi会iOS杜甫hi弄成课教案三年素花覅UR一是的覅uasnfisaunfiukjnviuni看地方鸡内金德生科技非农日弄皮肤破发IM；欧迪芬IM噢IM哦片firm哦",@"replay":@"",@"state":@"待发货",kQuestionImgStr:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1583823033016&di=0823fe508155bec7aab1274a9c00cc2f&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F68%2F61%2F300000839764127060614318218_950.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1583823033015&di=ec85c2224ceacefccba3dca9c265ce12&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F14%2F75%2F01300000164186121366756803686.jpg"]};
    NSDictionary  * phoneNumberInfo = @{@"replyTime":@"2020-02-02 22:21:21",@"content":@"武汉一清防控持续阿卡假的你速回复雕塑回复扣水电费hi会iOS杜甫hi弄成课教案三年素花覅UR一是的覅uasnfisaunfiukjnviuni看地方鸡内金德生科技非农日弄皮肤破发IM；欧迪芬IM噢IM哦片firm哦",@"replay":@"武汉一清防控持续阿卡假的你速回复雕塑回复扣水电费hi会iOS杜甫hi弄成课教案三年素花覅UR一是的覅uasnfisaunfiukjnviuni看地方鸡内金德生科技非农日弄皮肤破发IM；欧迪芬IM噢IM哦片firm哦",@"state":@"待发货",kQuestionImgStr:@[]};
    NSDictionary  * addressInfo = @{@"replyTime":@"2020-02-02 22:21:21",@"content":@"武汉一清防控持续阿卡假的你速回复雕塑回复扣水电费hi会iOS杜甫hi弄成课教案三年素花覅UR一是的覅uasnfisaunfiukjnviuni看地方鸡内金德生科技非农日弄皮肤破发IM；欧迪芬IM噢IM哦片firm哦",@"replay":@"武汉一清防控持续阿卡假的你速回复雕塑回复扣水电费hi会iOS杜甫hi弄成课教案三年素花覅UR一是的覅uasnfisaunfiukjnviuni看地方鸡内金德生科技非农日弄皮肤破发IM；欧迪芬IM噢IM哦片firm哦",@"state":@"待发货",kQuestionImgStr:@[]};
    
    [self.adminDataSource addObject:dataInfo];
    [self.adminDataSource addObject:passwordFoodInfo];
    [self.adminDataSource addObject:phoneNumberInfo];
    [self.adminDataSource addObject:addressInfo];
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"投诉反馈";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kCommonMainTextColor_50};
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publishQuestion)];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xFF671D)} forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = item;
    [self.navigationItem.rightBarButtonItem setTintColor:kCommonMainTextColor_50];
    TeamHitBarButtonItem * leftBarItem = [TeamHitBarButtonItem leftButtonWithImage:[UIImage imageNamed:@"public-返回"] title:@""];
    [leftBarItem addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBarItem];
}

- (void)backAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)publishQuestion
{
    
}


- (void)selectCategory
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"选择分类" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"会计",@"出纳",@"税务",@"其它", nil];
    [alert show];
}


- (void)resignText
{
    [self.contentField resignFirstResponder];
}

- (void)contentViewSetup
{
    self.imagePic = [[UIImagePickerController alloc] init];
    _imagePic.allowsEditing = YES;
    _imagePic.delegate = self;
    
    if (IS_PAD) {
        [self refreshUI_iPad];
        
        return;
    }
    
    self.resignControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight)];
    [self.resignControl addTarget:self action:@selector(resignText) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.resignControl];
    
    self.segmentC = [[HYSegmentedControl alloc] initWithOriginX:(kScreenWidth / 2 - 100) OriginY:0 Titles:@[@"投诉反馈", @"我的反馈"] delegate:self drop:NO color:kMainRedColor];
    [self.segmentC hideBottomBackLine];
    [self.view addSubview:self.segmentC];
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight - 45 - kNavigationBarHeight - kStatusBarHeight)];
    self.scrollView.scrollEnabled = NO;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * 2, self.scrollView.hd_height);
    [self.resignControl addSubview:self.scrollView];
    //    self.scrollView.delegate = self;
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, self.scrollView.hd_height) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerClass:[FankuiTableViewCell class] forCellReuseIdentifier:kFankuiTableViewCellID];
    [self.scrollView addSubview:self.tableview];
    
    self.categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 20)];
    self.categoryLabel.text = @"投诉 / 反馈";
    self.categoryLabel.font = [UIFont systemFontOfSize:16];
    [self.scrollView addSubview:self.categoryLabel];
    
    MKPPlaceholderTextView *textView = [[MKPPlaceholderTextView alloc]init];
    textView.placeholder = @"想对我们说点什么？";
    textView.frame = CGRectMake(20, CGRectGetMaxY(self.categoryLabel.frame) + 16, kScreenWidth - 40, 240);
    textView.delegate = self;
    textView.layer.cornerRadius = 1;
    textView.layer.masksToBounds = YES;
    textView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    textView.layer.borderWidth = 1;
    [self.scrollView addSubview:textView];
    self.contentField = textView;
    
    self.imageView1 = [[PublishImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.contentField.frame) + 10, 60, 60)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageClickFunc1)];
    [self.imageView1 addGestureRecognizer:tap1];
    self.imageView1.userInteractionEnabled = YES;
    
    self.imageView2 = [[PublishImageView alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(self.contentField.frame) + 10, 60, 60)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageClickFunc2)];
    [self.imageView2 addGestureRecognizer:tap2];
    self.imageView2.userInteractionEnabled = YES;
    
    self.imageView3 = [[PublishImageView alloc] initWithFrame:CGRectMake(180, CGRectGetMaxY(self.contentField.frame) + 10, 60, 60)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageClickFunc3)];
    [self.imageView3 addGestureRecognizer:tap3];
    self.imageView3.userInteractionEnabled = YES;
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake((kScreenWidth * 0.7 ) / 2, CGRectGetMaxY(self.imageView1.frame) + 37, kScreenWidth * 0.3, 40);
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    submitBtn.backgroundColor = kMainRedColor;
    [self.scrollView addSubview:submitBtn];
    self.submitBtn = submitBtn;
    [submitBtn addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self resetImageViews];
    
}
- (void)refreshUI_iPad
{
    self.leftBar = [[LeftBar alloc]initWithFrame:CGRectMake(0, 0, 53, kScreenHeight - 64)];
    [self.view addSubview:self.leftBar];
    
    self.resignControl = [[UIControl alloc] initWithFrame:CGRectMake(53, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight)];
    [self.resignControl addTarget:self action:@selector(resignText) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.resignControl];
    
    self.segmentC = [[HYSegmentedControl alloc] initWithOriginX:(53 + (kScreenWidth - 53) / 2 - 100 ) OriginY:0 Titles:@[@"投诉反馈", @"我的反馈"] delegate:self drop:NO color:kMainRedColor];
    [self.segmentC hideBottomBackLine];
    [self.view addSubview:self.segmentC];
    
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth - 53, kScreenHeight - 45 - kNavigationBarHeight - kStatusBarHeight)];
    self.scrollView.scrollEnabled = NO;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * 2 - 106, self.scrollView.hd_height);
    [self.resignControl addSubview:self.scrollView];
//    self.scrollView.delegate = self;
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth - 53, 0, kScreenWidth - 53, self.scrollView.hd_height) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerClass:[FankuiTableViewCell class] forCellReuseIdentifier:kFankuiTableViewCellID];
    [self.scrollView addSubview:self.tableview];
    
    
    self.categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 20)];
    self.categoryLabel.text = @"投诉 / 反馈";
    self.categoryLabel.font = [UIFont systemFontOfSize:16];
    [self.scrollView addSubview:self.categoryLabel];
    
    MKPPlaceholderTextView *textView = [[MKPPlaceholderTextView alloc]init];
    textView.placeholder = @"想对我们说点什么？";
    textView.frame = CGRectMake(20, CGRectGetMaxY(self.categoryLabel.frame) + 16, kScreenWidth - 40 - 53, 240);
    textView.delegate = self;
    textView.layer.cornerRadius = 1;
    textView.layer.masksToBounds = YES;
    textView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    textView.layer.borderWidth = 1;
    [self.scrollView addSubview:textView];
    self.contentField = textView;
    
    self.imageView1 = [[PublishImageView alloc] initWithFrame:CGRectMake(30 , CGRectGetMaxY(self.contentField.frame) + 10, 60, 60)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageClickFunc1)];
    [self.imageView1 addGestureRecognizer:tap1];
    self.imageView1.userInteractionEnabled = YES;
    
    self.imageView2 = [[PublishImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame) + 20, CGRectGetMaxY(self.contentField.frame) + 10, 60, 60)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageClickFunc2)];
    [self.imageView2 addGestureRecognizer:tap2];
    self.imageView2.userInteractionEnabled = YES;
    
    self.imageView3 = [[PublishImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView2.frame) + 20+ 53, CGRectGetMaxY(self.contentField.frame) + 10, 60, 60)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageClickFunc3)];
    [self.imageView3 addGestureRecognizer:tap3];
    self.imageView3.userInteractionEnabled = YES;
    
    [self.imageView1 showCloseImage];
    [self.imageView2 showCloseImage];
    [self.imageView3 showCloseImage];
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake((kScreenWidth * 0.7 - 53) / 2, CGRectGetMaxY(self.imageView1.frame) + 37, kScreenWidth * 0.3, 40);
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    submitBtn.backgroundColor = kMainRedColor;
    [self.scrollView addSubview:submitBtn];
    self.submitBtn = submitBtn;
    [submitBtn addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self resetImageViews];
}


- (void)resetImageViews
{
    [self.imageView1 removeFromSuperview];
    [self.imageView2 removeFromSuperview];
    [self.imageView3 removeFromSuperview];
    NSUInteger imageCount = self.imagesArray.count;
    if (imageCount == 0) {
        [self.imageView1 resetDefaultImage];
        [self.scrollView addSubview:self.imageView1];
    }
    if (imageCount == 1) {
        self.imageView1.contentImageView.image = [self.imagesArray objectAtIndex:0];
        [self.scrollView addSubview:self.imageView1];
        [self.imageView2 resetDefaultImage];
        [self.scrollView addSubview:self.imageView2];
    }
    if (imageCount == 2) {
        self.imageView1.contentImageView.image = [self.imagesArray objectAtIndex:0];
        [self.scrollView addSubview:self.imageView1];
        self.imageView2.contentImageView.image = [self.imagesArray objectAtIndex:1];
        [self.scrollView addSubview:self.imageView2];
        [self.imageView3 resetDefaultImage];
        [self.scrollView addSubview:self.imageView3];
    }
    if (imageCount == 3) {
        self.imageView1.contentImageView.image = [self.imagesArray objectAtIndex:0];
        [self.scrollView addSubview:self.imageView1];
        self.imageView2.contentImageView.image = [self.imagesArray objectAtIndex:1];
        [self.scrollView addSubview:self.imageView2];
        self.imageView3.contentImageView.image = [self.imagesArray objectAtIndex:2];
        [self.scrollView addSubview:self.imageView3];
    }
    
}

- (void)selectImage
{
    if (self.clickImageIndex < self.imagesArray.count) {
        ShowPhotoViewController *vc = [[ShowPhotoViewController alloc] initWithImage:[self.imagesArray objectAtIndex:self.clickImageIndex]];
        vc.delegate = self;
        vc.isShowDelete = YES;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }else{
        [self choceIconImage];
    }
}

- (void)uploadImage:(UIImage *)image
{
//    [SVProgressHUD show];
//    NSData *data = UIImagePNGRepresentation(image);
//    [[ImageManager sharedManager] didUploadImage:data withNotifiedObject:self];
}

#pragma mark - upload delegate

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
    if (self.clickImageIndex < self.imagesArray.count) {
        [self.imagesArray removeObjectAtIndex:self.clickImageIndex];
        [self.imagesArray insertObject:image atIndex:self.clickImageIndex];
    }else{
        [self.imagesArray addObject:image];
    }
    [self resetImageViews];
    [SoftManager shareSoftManager].isPhontoLibrary = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - show photo delegate
- (void)didPhotoDelete
{
    [self.imagesArray removeObjectAtIndex:self.clickImageIndex];
    [self resetImageViews];
}

#pragma mark - pick image func


#pragma mark - response func
- (void)addImageClickFunc1
{
    self.clickImageIndex = 0;
    [self selectImage];
}

- (void)addImageClickFunc2
{
    self.clickImageIndex = 1;
    [self selectImage];
}

- (void)addImageClickFunc3
{
    self.clickImageIndex = 2;
    [self selectImage];
}

- (void)resetButtons
{
    [self resignText];
    [self.button1 setTitleColor:kTableViewCellSeparatorColor forState:UIControlStateNormal];
    [self.button2 setTitleColor:kTableViewCellSeparatorColor forState:UIControlStateNormal];
    [self.button3 setTitleColor:kTableViewCellSeparatorColor forState:UIControlStateNormal];
    [self.button4 setTitleColor:kTableViewCellSeparatorColor forState:UIControlStateNormal];
}

- (void)button1Click
{
    [self resetButtons];
    [self.button1 setTitleColor:UIColorFromRGB(0xFF671D) forState:UIControlStateNormal];
    self.categoryId = 17;
}

- (void)button2Click
{
    [self resetButtons];
    [self.button2 setTitleColor:UIColorFromRGB(0xFF671D) forState:UIControlStateNormal];
    self.categoryId = 18;
}

- (void)button3Click
{
    [self resetButtons];
    [self.button3 setTitleColor:UIColorFromRGB(0xFF671D) forState:UIControlStateNormal];
    self.categoryId = 19;
}

- (void)button4Click
{
    [self resetButtons];
    [self.button4 setTitleColor:UIColorFromRGB(0xFF671D) forState:UIControlStateNormal];
    self.categoryId = 20;
}

- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(index * _scrollView.hd_width, 0) animated:NO];
}

#pragma mark - tableviewdelegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.adminDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FankuiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kFankuiTableViewCellID forIndexPath:indexPath];
    [cell refreshUIWith:[self.adminDataSource objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * infoDic = [self.adminDataSource objectAtIndex:indexPath.row];
    
    NSString * content = [infoDic objectForKey:@"content"];
    CGSize contentSize = [content boundingRectWithSize:CGSizeMake(self.tableview.hd_width - 50, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont_16} context:nil].size;
    
    NSArray *imgs = [infoDic objectForKey:kQuestionImgStr];
    float imageHeight = 70;
    
    CGFloat contentHeight = [[infoDic objectForKey:@"replay"] boundingRectWithSize:CGSizeMake(self.tableview.hd_width - 24 - 55, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont_16} context:nil].size.height;
    if ([[infoDic objectForKey:@"replay"] length] > 0) {
        
        if (imgs.count > 0) {
            return contentHeight + 70 + 10 + contentSize.height + 15 + 16 + 15 + 1 + 15 + 13 + 5 + imageHeight;
        }
        return contentHeight + 70 + 10 + contentSize.height + 15 + 16 + 15 + 1 + 15 + 13 + 5;
    }
    if (imgs.count > 0) {
        return contentSize.height + 15 + 16 + 15 + 1 + 15 + 13 + 5 + imageHeight;
    }
    return contentSize.height + 15 + 16 + 15 + 1 + 15 + 13 + 5;
}

@end
