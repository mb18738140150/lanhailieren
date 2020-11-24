//
//  VRImageViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/5/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "VRImageViewController.h"
//#import "GVRPanoramaView.h"

@interface VRImageViewController ()

//@property (nonatomic ,strong)GVRPanoramaView * panoView;

@end

@implementation VRImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationViewSetup];
//    self.panoView = [[GVRPanoramaView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    self.panoView.delegate = self;
//    _panoView.enableFullscreenButton = YES;
//    _panoView.enableCardboardButton = YES;
//    [_panoView loadImage:[UIImage imageNamed:@"VR.png"] ofType:kGVRPanoramaImageTypeStereoOverUnder];
//    [self.view addSubview:self.panoView];
    
}
- (void)navigationViewSetup
{
    self.navigationItem.title = self.title;
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
- (void)loadImage
{
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:@""] options:SDWebImageScaleDownLargeImages progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        float progress = receivedSize*100/expectedSize;
        NSLog(@"当前下载进度:%.2lf%%",progress);
        
        [SVProgressHUD showProgress:progress];
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        [SVProgressHUD dismiss];
        
        if (image) {
            //            @autoreleasepool {
//            [self.panoView loadImage:image];
            //            };
        }
        if (error) {
            NSLog(@"下载图片失败");
            
        }
    }];
}



@end
