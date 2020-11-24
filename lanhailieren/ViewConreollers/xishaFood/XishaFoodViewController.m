//
//  XishaFoodViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/20.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "XishaFoodViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WBQRCodeVC.h"
#import "WCQRCodeVC.h"

#import "ChooceStoreView.h"
#import "BiChiCollectionViewCell.h"
#define kBiChiCollectionViewCellID @"BiChiCollectionViewCellID"
#import "TuijianCollectionViewCell.h"
#define kTuijianCollectionViewCellID @"TuijianCollectionViewCellID"
#import "JingpinCollectionViewCell.h"
#define kJingpinCollectionViewCellID @"JingpinCollectionViewCellID"
#import "Head_categoryCollectionReusableView.h"
#define kHead_categoryCollectionReusableViewID  @"Head_categoryCollectionReusableViewID"
#import "Head_tipCollectionReusableView.h"
#define kHead_tipCollectionReusableViewID @"Head_tipCollectionReusableViewID"

//#import "BichiTableViewCell.h"
//#define kBichiTableViewCellID @"BichiTableViewCellID"
#import "XishaFoodCategoryCollectionViewCell.h"
#define kXishaFoodCategoryCollectionViewCellID @"XishaFoodCategoryCollectionViewCellID"
#import "XishaFoodListCollectionViewCell.h"
#define kXishaFoodListCollectionViewCellID @"XishaFoodListCollectionViewCellID"

//#import "TuijianTableViewCell.h"
//#define kTuijianTableViewCellID @"TuijianTableViewCellID"
//#import "JingPinTableViewCell.h"
//#define kJingPinTableViewCellID @"JingPinTableViewCellID"
#import "HeadCategiryTableViewCell.h"
#define kHeadCategiryTableViewCellID @"HeadCategiryTableViewCellID"
#import "FoodListViewController.h"
#import "ChoosStoreViewController.h"
#import "SearchFoodViewController.h"
#import "FoodIntroduceViewController.h"

#import "StoreVRListViewController.h"
#import "TestReportListViewController.h"
#import "CateDetailViewController.h"
#import "FisheryHarvestViewController.h"
#import "XishaSearchGoodFoodViewController.h"
#import "ClubActivityDetailViewController.h"
#import "StoreGoodFoodViewController.h"
#import "StoreGoodFoodSearchViewController.h"
#import "CateDetailViewController.h"


@interface XishaFoodViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UserModule_GoodCategoryProtocol,UserModule_HotSearchProtocol,UserModule_BannerProtocol,UserModule_ChannelListProtocol,UserModule_ChannelDetailProtocol,UserModule_BannerProtocol>

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UICollectionView * collectionview;

@property (nonatomic, strong)ChooceStoreView * chooceStoreView;

@property (nonatomic, strong)NSMutableArray * categoryDataSource;
@property (nonatomic, strong)NSMutableArray * bichiDataSource;
@property (nonatomic, strong)NSMutableArray * tuijianDataSource;
@property (nonatomic, strong)NSMutableArray * jingpinDataSource;

@property (nonatomic, strong)NSMutableArray * bannerList;

@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;

@end

@implementation XishaFoodViewController


- (NSMutableArray *)bannerList
{
    if (!_bannerList) {
        _bannerList = [NSMutableArray array];
    }
    return _bannerList;
}

- (NSMutableArray *)categoryDataSource
{
    if (!_categoryDataSource) {
        _categoryDataSource = [NSMutableArray array];
    }
    return _categoryDataSource;
}

- (NSMutableArray *)bichiDataSource
{
    if (!_bichiDataSource) {
        _bichiDataSource = [NSMutableArray array];
    }
    return _bichiDataSource;
}

- (NSMutableArray *)tuijianDataSource
{
    if (!_tuijianDataSource) {
        _tuijianDataSource = [NSMutableArray array];
    }
    return _tuijianDataSource;
}

- (NSMutableArray *)jingpinDataSource
{
    if (!_jingpinDataSource) {
        _jingpinDataSource = [NSMutableArray array];
    }
    return _jingpinDataSource;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self resetSelectStore:[UserManager sharedManager].currentSelectStore];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page_size = 10;
    self.page_index = 1;
    [self navigationViewSetup];
    [self loadData];
    [self refreshUI_iPhone];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getStoreSuccess:) name:kNotificationOfGetStoreSuccess object:nil];
}

- (void)getStoreSuccess:(NSNotification *)notification
{
    [self resetSelectStore:[UserManager sharedManager].currentSelectStore];
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"西沙美食之旅";
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kCommonMainTextColor_50};
}

- (void)backAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - iPhone UI
- (void)refreshUI_iPhone
{
    
    self.chooceStoreView = [[ChooceStoreView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 34)];
    [self.view addSubview:self.chooceStoreView];
    [self.chooceStoreView hideStoreView];
    __weak typeof(self)weakSelf = self;
    self.chooceStoreView.scanFoodBlock = ^(NSDictionary *info) {
        WCQRCodeVC *WCVC = [[WCQRCodeVC alloc] init];
        WCVC.hidesBottomBarWhenPushed = YES;
        [weakSelf QRCodeScanVC:WCVC];
    };
    self.chooceStoreView.searchFoodBlock = ^(NSDictionary *info) {
        StoreGoodFoodSearchViewController * searchVC = [[StoreGoodFoodSearchViewController alloc]init];
        searchVC.channel_name = @"dish";
        searchVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:searchVC animated:YES];
    };
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 6;
    layout.minimumLineSpacing = 6;
    
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 34, kScreenWidth - 20, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 34 - 50) collectionViewLayout:layout];
    self.collectionview.backgroundColor = [UIColor clearColor];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    [self.collectionview registerClass:[XishaFoodCategoryCollectionViewCell class] forCellWithReuseIdentifier:kXishaFoodCategoryCollectionViewCellID];
    [self.collectionview registerClass:[XishaFoodListCollectionViewCell class] forCellWithReuseIdentifier:kXishaFoodListCollectionViewCellID];
//    [self.collectionview registerClass:[JingpinCollectionViewCell class] forCellWithReuseIdentifier:kJingpinCollectionViewCellID];
    [self.collectionview registerClass:[Head_categoryCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHead_categoryCollectionReusableViewID];
    [self.collectionview registerClass:[Head_tipCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHead_tipCollectionReusableViewID];
    
    
    [self.view addSubview:self.collectionview];
    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
}

- (void)pushChooseStoreVC
{
    __weak typeof(self)weakSelf = self;
    ChoosStoreViewController * vc = [[ChoosStoreViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.chooseStoreBlock = ^(NSDictionary * _Nonnull info) {
        [weakSelf resetSelectStore:info];
        [UserManager sharedManager].currentSelectStore = info;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)resetSelectStore:(NSDictionary *)info
{
    [self.chooceStoreView resetStoreName:[info objectForKey:@"title"]];
}

#pragma mark uicollectionview delegate & datasource _iPhone
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.bichiDataSource.count;
    }else if (section == 1)
    {
        return self.tuijianDataSource.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XishaFoodCategoryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kXishaFoodCategoryCollectionViewCellID forIndexPath:indexPath];
        [cell refreshUIWithInfo:[self.bichiDataSource objectAtIndex:indexPath.item]];
        return cell;
    }else
    {
        XishaFoodListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kXishaFoodListCollectionViewCellID forIndexPath:indexPath];
        [cell refreshUI:[self.tuijianDataSource objectAtIndex:indexPath.item]];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGFloat itemWidth = (kScreenWidth - 28) / 2;
        if (IS_PAD) {
            itemWidth = (kScreenWidth - 50) / 4;
        }
        return CGSizeMake(itemWidth, itemWidth * 0.45);
    }else
    {
        float width = (kScreenWidth - 30) / 2;
        if (IS_PAD) {
            width = (kScreenWidth - 50) / 4;
        }
        return CGSizeMake(width, width * 0.73 + 30);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    if (indexPath.section == 0) {
        Head_categoryCollectionReusableView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHead_categoryCollectionReusableViewID forIndexPath:indexPath];
        headView.bannerImgUrlArray = self.bannerList;
        
        [headView refreshUIWith:@{@"dataArray":self.categoryDataSource,@"image":@"placeholdImage"}];
        [headView hideSeperateView];
        // 分类——获取商品
        headView.FishCategory_headClickBlock = ^(NSDictionary *info) {
            
            [weakSelf pushFoodListVCWithCategoryID:[[info objectForKey:@"id"] intValue] andPlate:0 andIs_hot:0 andIs_red:0];
        };
        
        return headView;
    }else
    {
        Head_tipCollectionReusableView * tipHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHead_tipCollectionReusableViewID forIndexPath:indexPath];
        [tipHeadView refreshCenterContent:@{@"title":@"推荐榜单"}];
        [tipHeadView showMore];
//        // 推荐——获取商品
        tipHeadView.goBlock = ^(NSDictionary *info) {
//            [weakSelf pushFoodListVCWithCategoryID:0 andPlate:0 andIs_hot:0 andIs_red:1];
//            plate = 1;
            [weakSelf pushFoodListVCWithCategoryID:0 andPlate:0 andIs_hot:0 andIs_red:0];
        };
        
        return tipHeadView;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        if(IS_PAD)
        {
            return CGSizeMake(collectionView.hd_width, collectionView.hd_width * 0.25 + 90);
        }
        
        int count = (int) self.categoryDataSource.count / 4;//
        int number = (int)self.categoryDataSource.count % 4;//
        if (number > 0) {
            count = count + 1;
        }
        
        if (count > 1) {
            return CGSizeMake(collectionView.hd_width, collectionView.hd_width * 0.42 + 80 * count);
        }
        return CGSizeMake(collectionView.hd_width, collectionView.hd_width * 0.42 + 90);
    }else
    {
        return CGSizeMake(collectionView.hd_width, 40);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSDictionary * info = [self.bichiDataSource objectAtIndex:indexPath.item];
        NSString * str = [info objectForKey:@"title"];
        int plate = 0;
        if ([str containsString:@"溯源"]) {
            WCQRCodeVC *WCVC = [[WCQRCodeVC alloc] init];
            WCVC.hidesBottomBarWhenPushed = YES;
            [self QRCodeScanVC:WCVC];
        }else if ([str containsString:@"VR"])
        {
            plate = 2;
            StoreVRListViewController * vc = [[StoreVRListViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc  animated:YES];
        }else if ([str containsString:@"检测"])
        {
            plate = 3;
            TestReportListViewController * vc = [[TestReportListViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc  animated:YES];
        }else if ([str containsString:@"渔获"])
        {
            plate = 4;
            FisheryHarvestViewController * vc = [[FisheryHarvestViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc  animated:YES];
        }
    }else
    {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestClubActivityDetailWithInfo:@{@"command":@31,@"channel_name":@"dish",@"id":[self.tuijianDataSource[indexPath.row] objectForKey:@"id"]} withNotifiedObject:self];
    }
    
}

- (void)pushFoodListVCWithCategoryID:(int)categoryId andPlate:(int )plate andIs_hot:(int)isHot andIs_red:(int)isred
{
    StoreGoodFoodViewController * vc = [[StoreGoodFoodViewController alloc]init];
    vc.category_id = categoryId;
    vc.channel_name = @"dish";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    [SVProgressHUD show];
    self.categoryDataSource = [[UserManager sharedManager] getXishaFoodCategoryList];
    [[UserManager sharedManager] didRequestStore_todayGoodFoodListWithInfo:@{@"command":@30,@"channel_name":@"dish",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"0",@"is_red":@1} withNotifiedObject:self];
    
}

- (void)loadData
{
    self.categoryDataSource = [[UserManager sharedManager] getXishaFoodCategoryList];
    if([[[UserManager sharedManager] getXishaFoodCategoryList] count] == 0)
    {
        [[UserManager sharedManager] didRequestXishaFoodCategoryListWithInfo:@{@"command":@8,@"channel_name":@"dish"} withNotifiedObject:self];
    }
    
    [[UserManager sharedManager] didRequestXishaFoodBannerWithCourseInfo:@{@"command":@28,@"channel_name":@"dish"} withNotifiedObject:self];
    
    [[UserManager sharedManager] HotSearchWith:@{@"command":@27} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestBannerWithCourseInfo:@{@"command":@28} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestStore_todayGoodFoodListWithInfo:@{@"command":@30,@"channel_name":@"dish",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"0",@"is_red":@1} withNotifiedObject:self];
    
    NSDictionary * bichiInfo1 = @{@"title":@"溯源扫码",@"tags":@"扫码查看",@"image":@"",@"iconImage":@"nav_food"};
    NSDictionary * bichiInfo2 = @{@"title":@"门店VR",@"tags":@"立体展示",@"image":@"",@"iconImage":@"nav_vr"};
    NSDictionary * bichiInfo3 = @{@"title":@"检测报告",@"tags":@"权威检测",@"image":@"",@"iconImage":@"nav_report"};
    NSDictionary * bichiInfo4 = @{@"title":@"渔获介绍",@"tags":@"详细介绍",@"image":@"",@"iconImage":@"nav_introduce"};
    [self.bichiDataSource addObject:bichiInfo1];
    [self.bichiDataSource addObject:bichiInfo2];
    [self.bichiDataSource addObject:bichiInfo3];
    [self.bichiDataSource addObject:bichiInfo4];
    
}

- (void)didRequestGoodCategorySuccessed
{
    [self.collectionview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    self.categoryDataSource = [[UserManager sharedManager] getXishaFoodCategoryList];
    [self.collectionview reloadData];
}

- (void)didRequestGoodCategoryFailed:(NSString *)failedInfo
{
    [self.collectionview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


- (void)didRequestHotSearchKeyListSuccessed
{
    
}

- (void)didRequestHotSearchKeyListFailed:(NSString *)failedInfo
{
    
}

- (void)didRequestBannerSuccessed
{
    [self.bannerList removeAllObjects];
    for (NSDictionary * info in [[UserManager sharedManager] getXishaFoodBannerList]) {
        NSString * imageUrl = [NSString stringWithFormat:@"%@%@", kRootImageUrl,[info objectForKey:@"img_url"]];
        [self.bannerList addObject:imageUrl];
    }
    [self.collectionview reloadData];
}

- (void)didRequestBannerFailed:(NSString *)failedInfo
{
    [[UserManager sharedManager] didRequestXishaFoodBannerWithCourseInfo:@{@"command":@28,@"channel_name":@"dish"} withNotifiedObject:self];
}

- (void)didRequestChannelListSuccessed
{
    [self.collectionview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [self.tuijianDataSource removeAllObjects];
    for (NSDictionary * info in [[UserManager sharedManager] getStoreTodayGoodFoodList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [self.tuijianDataSource addObject:mInfo];
    }
    
    [self.collectionview reloadData];
}

- (void)didRequestChannelListFailed:(NSString *)failedInfo
{
    [self.collectionview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
- (void)didRequestChannelDetailSuccessed
{
    [SVProgressHUD dismiss];
    CateDetailViewController * vc = [[CateDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.info = [[UserManager sharedManager] getClubActivityDetail];
    [self.navigationController pushViewController:vc  animated:YES];
    
}

- (void)didRequestChannelDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


#pragma mark - scan
- (void)QRCodeScanVC:(UIViewController *)scanVC {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.navigationController pushViewController:scanVC animated:YES];
                        });
                        NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                [self.navigationController pushViewController:scanVC animated:YES];
                break;
            }
            case AVAuthorizationStatusDenied: {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - 揽海猎人] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [self presentViewController:alertC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusRestricted: {
                NSLog(@"因为系统原因, 无法访问相册");
                break;
            }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
}


@end
