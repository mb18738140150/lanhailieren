//
//  ClubViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/21.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ClubViewController.h"
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


#import "XishaFoodCategoryCollectionViewCell.h"
#define kXishaFoodCategoryCollectionViewCellID @"XishaFoodCategoryCollectionViewCellID"
#import "XishaFoodListCollectionViewCell.h"
#define kXishaFoodListCollectionViewCellID @"XishaFoodListCollectionViewCellID"

#import "HeadCategiryTableViewCell.h"
#define kHeadCategiryTableViewCellID @"HeadCategiryTableViewCellID"

#import "MyCollectionCollectionViewCell.h"
#define kMyCollectionCollectionViewCellID @"MyCollectionCollectionViewCellID"
#import "JoinClubCollectionViewCell.h"
#define kJoinClubTableViewCellID @"JoinClubCollectionViewCell"

#import "VipCustomViewController.h"
#import "ClubContestViewController.h"
#import "ClubActivityViewController.h"
#import "ClubSearchRecommendViewController.h"
#import "AboutClubViewController.h"
#import "ClubActivityDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WBQRCodeVC.h"
#import "WCQRCodeVC.h"
#import "CLPlayerView.h"

#import "FoodMakeCommentDetailViewController.h"
#import "CustomView.h"
#import "bottomAlertView.h"
#import "CateDetailViewController.h"
#import "JoinClubViewController.h"

@interface ClubViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UserModule_BannerProtocol,UserModule_GoodCategoryProtocol,UserModule_ChannelListProtocol,UserModule_ChannelDetailProtocol,UserModule_XishameishiListProtocol,UserModule_MeishizhizuoListProtocol,UserModule_YuleshipinListProtocol,UserModule_VIPCustomProtocol,UserModule_StoreListProtocol,UserModule_GoodProtocol,UserModule_CollectProtocol,UserModule_XishameishiDetailProtocol>

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UICollectionView * collectionview;

@property (nonatomic, strong)ChooceStoreView * chooceStoreView;

@property (nonatomic, strong)NSMutableArray * categoryDataSource;
@property (nonatomic, strong)NSMutableArray * bichiDataSource;
@property (nonatomic, strong)NSMutableArray * tuijianDataSource;
@property (nonatomic, strong)NSMutableArray * jingpinDataSource;

@property (nonatomic, strong)NSMutableArray * xishameishiDataSource;
@property (nonatomic, strong)NSMutableArray * meishizhizuoDataSource;
@property (nonatomic, strong)NSMutableArray * yuleshipinDataSource;
@property (nonatomic, strong)NSMutableArray * joinUsDataSource;


@property (nonatomic, strong)NSMutableArray * bannerList;

@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;

@property (nonatomic, weak) CLPlayerView *playerView;
@property (nonatomic, assign)MyCollectionCollectionViewCell * cell;// 记录cell
@property (nonatomic,  strong)NSDictionary * currentSelectInfo;// 当前选中分类下具体item

@end

@implementation ClubViewController
- (NSMutableArray *)xishameishiDataSource
{
    if (!_xishameishiDataSource) {
        _xishameishiDataSource = [NSMutableArray array];
    }
    return _xishameishiDataSource;
}
- (NSMutableArray *)meishizhizuoDataSource
{
    if (!_meishizhizuoDataSource) {
        _meishizhizuoDataSource = [NSMutableArray array];
    }
    return _meishizhizuoDataSource;
}
- (NSMutableArray *)yuleshipinDataSource
{
    if (!_yuleshipinDataSource) {
        _yuleshipinDataSource = [NSMutableArray array];
    }
    return _yuleshipinDataSource;
}
- (NSMutableArray *)joinUsDataSource
{
    if (!_joinUsDataSource) {
        _joinUsDataSource = [NSMutableArray array];
    }
    return _joinUsDataSource;
}


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
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"海钓俱乐部";
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
    self.chooceStoreView.searchFoodBlock = ^(NSDictionary *info) {
        ClubSearchRecommendViewController * vc = [[ClubSearchRecommendViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 34, kScreenWidth - 20, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 34 - kTabBarHeight) collectionViewLayout:layout];
    self.collectionview.backgroundColor = [UIColor clearColor];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    [self.collectionview registerClass:[XishaFoodCategoryCollectionViewCell class] forCellWithReuseIdentifier:kXishaFoodCategoryCollectionViewCellID];
    [self.collectionview registerClass:[XishaFoodListCollectionViewCell class] forCellWithReuseIdentifier:kXishaFoodListCollectionViewCellID];
    [self.collectionview registerClass:[MyCollectionCollectionViewCell class] forCellWithReuseIdentifier:kMyCollectionCollectionViewCellID];
    [self.collectionview registerClass:[JoinClubCollectionViewCell class] forCellWithReuseIdentifier:kJoinClubTableViewCellID];
    
    [self.collectionview registerClass:[Head_categoryCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHead_categoryCollectionReusableViewID];
    [self.collectionview registerClass:[Head_tipCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHead_tipCollectionReusableViewID];
    
    [self.view addSubview:self.collectionview];
    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
}

- (void)resetSelectStore:(NSDictionary *)info
{
    [self.chooceStoreView resetStoreName:[info objectForKey:@"title"]];
}

#pragma mark uicollectionview delegate & datasource _iPhone
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 6;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else if (section == 1)
    {
        return self.tuijianDataSource.count;
    }else if (section == 2)
    {
        if (IS_PAD) {
            if (self.xishameishiDataSource.count> 8) {
                return 8;
            }else
            {
                return self.xishameishiDataSource.count;
            }
        }else
        {
            if (self.xishameishiDataSource.count> 4) {
                return 4;
            }else
            {
                return self.xishameishiDataSource.count;
            }
        }
    }
    else if (section == 3)
    {
        if (self.meishizhizuoDataSource.count> 4) {
            return 4;
        }else
        {
            return self.meishizhizuoDataSource.count;
        }
    }
    else if (section == 4)
    {
        if (self.yuleshipinDataSource.count> 4) {
            return 4;
        }else
        {
            return self.yuleshipinDataSource.count;
        }
    }
    else if (section == 5)
    {
        return self.joinUsDataSource.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XishaFoodCategoryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kXishaFoodCategoryCollectionViewCellID forIndexPath:indexPath];
        [cell refreshUIWithInfo:[self.bichiDataSource objectAtIndex:indexPath.item]];
        return cell;
    }else if(indexPath.section == 1)
    {
        XishaFoodListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kXishaFoodListCollectionViewCellID forIndexPath:indexPath];
        [cell refreshClubUI:[self.tuijianDataSource objectAtIndex:indexPath.item]];
        return cell;
    }else if(indexPath.section == 2)
    {
        XishaFoodListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kXishaFoodListCollectionViewCellID forIndexPath:indexPath];
        [cell refreshUI:[self.xishameishiDataSource objectAtIndex:indexPath.item]];
        return cell;
    }
    else if(indexPath.section == 3)
    {
        MyCollectionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyCollectionCollectionViewCellID forIndexPath:indexPath];
        NSDictionary * info = [self.meishizhizuoDataSource objectAtIndex:indexPath.row] ;
        __weak typeof(self)weakSelf = self;
        __weak typeof(cell)wealCell = cell;
        
        [cell refreshUI:info];
        [cell resetFoodMakeUI];
        [cell resetFoodMakeUI_Club];
        cell.playBlock = ^(NSDictionary * _Nonnull info) {
            [weakSelf cl_tableViewCellPlayVideoWithCell:wealCell];
        };
        
        
        cell.goodBlock = ^(NSDictionary * _Nonnull info) {
            NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
            [mInfo setObject:info forKey:@"info"];
            [mInfo setObject:@(FoodOperationType_good) forKey:@"type"];
            [self foodOperation:mInfo andchannelName:@"food"];
            NSLog(@"good");
        };
        cell.commentBlock = ^(NSDictionary * _Nonnull info) {
            NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
            [mInfo setObject:info forKey:@"info"];
            [mInfo setObject:@(FoodOperationType_Comment) forKey:@"type"];
            [self foodOperation:mInfo andchannelName:@"food"];
            NSLog(@"good");
        };
        cell.collectBlock = ^(NSDictionary * _Nonnull info) {
            NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
            [mInfo setObject:info forKey:@"info"];
            [mInfo setObject:@(FoodOperationType_collection) forKey:@"type"];
            [self foodOperation:mInfo andchannelName:@"food"];
            NSLog(@"good");
        };
        cell.shareBlock = ^(NSDictionary * _Nonnull info) {
            NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
            [mInfo setObject:info forKey:@"info"];
            [mInfo setObject:@(FoodOperationType_share) forKey:@"type"];
            [self foodOperation:mInfo andchannelName:@"food"];
            NSLog(@"good");
        };
        
        cell.customMadeBlock = ^(NSDictionary * _Nonnull info) {
            NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
            [mInfo setObject:info forKey:@"info"];
            [mInfo setObject:@(FoodOperationType_customMade) forKey:@"type"];
            [self foodOperation:mInfo andchannelName:@"food"];
            NSLog(@"custom made");
        };
        
        return cell;
    }
    else if(indexPath.section == 4)
    {
        MyCollectionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyCollectionCollectionViewCellID forIndexPath:indexPath];
        NSDictionary * info = [self.yuleshipinDataSource objectAtIndex:indexPath.row] ;
        __weak typeof(self)weakSelf = self;
        __weak typeof(cell)wealCell = cell;
        
        [cell refreshUI:info];
        [cell resetFoodMakeUI_Club];
        cell.playBlock = ^(NSDictionary * _Nonnull info) {
            [weakSelf cl_tableViewCellPlayVideoWithCell:wealCell];
        };
        
        
        cell.goodBlock = ^(NSDictionary * _Nonnull info) {
            NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
            [mInfo setObject:info forKey:@"info"];
            [mInfo setObject:@(FoodOperationType_good) forKey:@"type"];
            [self foodOperation:mInfo andchannelName:@"arder"];
            NSLog(@"good");
        };
        cell.commentBlock = ^(NSDictionary * _Nonnull info) {
            NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
            [mInfo setObject:info forKey:@"info"];
            [mInfo setObject:@(FoodOperationType_Comment) forKey:@"type"];
            [self foodOperation:mInfo andchannelName:@"arder"];
            NSLog(@"good");
        };
        cell.collectBlock = ^(NSDictionary * _Nonnull info) {
            NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
            [mInfo setObject:info forKey:@"info"];
            [mInfo setObject:@(FoodOperationType_collection) forKey:@"type"];
            [self foodOperation:mInfo andchannelName:@"arder"];
            NSLog(@"good");
        };
        cell.shareBlock = ^(NSDictionary * _Nonnull info) {
            NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
            [mInfo setObject:info forKey:@"info"];
            [mInfo setObject:@(FoodOperationType_share) forKey:@"type"];
            [self foodOperation:mInfo andchannelName:@"arder"];
            NSLog(@"good");
        };
        
        return cell;
    }
    else
    {
        JoinClubCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kJoinClubTableViewCellID forIndexPath:indexPath];
        [cell refreshUIWith:[self.joinUsDataSource objectAtIndex:indexPath.row]];
        __weak typeof(self)weakSelf = self;
        cell.applyBlock = ^(NSDictionary *info) {
            [weakSelf showCustomMadeView:info];
        };
        
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return CGSizeMake(0, 0);
    }else if (indexPath.section == 1)
    {
        CGFloat itemWidth = (kScreenWidth - 20) ;
        if (IS_PAD) {
            itemWidth = (kScreenWidth - 30) / 2;
        }
        return CGSizeMake(itemWidth, itemWidth * 0.4 + 72);
    }
    else if (indexPath.section == 2)
    {
         float width = (kScreenWidth - 30) / 2;
               if (IS_PAD) {
                   width = (kScreenWidth - 50) / 4;
               }
               return CGSizeMake(width, width * 0.73 + 30);
    }
    else if (indexPath.section == 3)
    {
        if (IS_PAD) {
            CGFloat itemWidth = (kScreenWidth - 30) / 2 - 1;
            CGFloat imageWidth = (itemWidth - 15);
            return  CGSizeMake(itemWidth, imageWidth * 0.48 + 55);
        }else
        {
            CGFloat imageWidth = (kScreenWidth - 20);
            return CGSizeMake(kScreenWidth, imageWidth * 0.41 + 55);
        }
    }
    else if (indexPath.section == 4)
    {
        if (IS_PAD) {
            CGFloat itemWidth = (kScreenWidth - 30) / 2 - 1;
            CGFloat imageWidth = (itemWidth - 15);
            return CGSizeMake(itemWidth, imageWidth * 0.48 + 55);
        }else
        {
            CGFloat imageWidth = (kScreenWidth - 20);
            return CGSizeMake(kScreenWidth, imageWidth * 0.41 + 40);
        }
    }
    else if (indexPath.section == 5)
    {
        float width = collectionView.hd_width;
        if (IS_PAD) {
            width = (collectionView.hd_width - 11) / 2;
            return CGSizeMake(width, width * 0.9 + 175);
        }
        
        return CGSizeMake(width, width * 0.9 + 175);
    }
    
    return CGSizeMake(0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    if (indexPath.section == 0) {
        Head_categoryCollectionReusableView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHead_categoryCollectionReusableViewID forIndexPath:indexPath];
        headView.bannerImgUrlArray = self.bannerList;
        headView.maxItem = 4;
        [headView refreshUIWith:@{@"dataArray":self.categoryDataSource,@"image":@"placeholdImage"}];
        
        
        headView.FishCategory_headClickBlock = ^(NSDictionary *info) {
            [weakSelf pushCategoryVC:info];
        };
        
        return headView;
    }else if (indexPath.section == 1)
    {
        Head_tipCollectionReusableView * tipHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHead_tipCollectionReusableViewID forIndexPath:indexPath];
        [tipHeadView refreshCenterContent:@{@"title":@"推荐活动"}];
        
        return tipHeadView;
    }else if (indexPath.section == 2)
    {
        Head_tipCollectionReusableView * tipHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHead_tipCollectionReusableViewID forIndexPath:indexPath];
        [tipHeadView refreshCenterContent:@{@"title":@"西沙美食推荐"}];
        
        return tipHeadView;
    }
    else if (indexPath.section == 3)
    {
        Head_tipCollectionReusableView * tipHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHead_tipCollectionReusableViewID forIndexPath:indexPath];
        [tipHeadView refreshCenterContent:@{@"title":@"美食制作推荐"}];
        
        return tipHeadView;
    }
    else if (indexPath.section == 4)
    {
        Head_tipCollectionReusableView * tipHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHead_tipCollectionReusableViewID forIndexPath:indexPath];
        [tipHeadView refreshCenterContent:@{@"title":@"休闲娱乐推荐"}];
        
        return tipHeadView;
    }
    else
    {
        Head_tipCollectionReusableView * tipHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHead_tipCollectionReusableViewID forIndexPath:indexPath];
        [tipHeadView refreshCenterContent:@{@"title":@"加入我们"}];
        
        return tipHeadView;
    }
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        if (IS_PAD) {
            return CGSizeMake(collectionView.hd_width, collectionView.hd_width * 0.25 + 90);
        }
        
        if (self.categoryDataSource.count > 4) {
            return CGSizeMake(collectionView.hd_width, collectionView.hd_width * 0.42 + 160);
        }
        return CGSizeMake(collectionView.hd_width, collectionView.hd_width * 0.42 + 90);
    }else if (section ==  2)
    {
        if (self.xishameishiDataSource.count == 0) {
            return CGSizeMake(0, 0);
        }
    }
    else if (section ==  3)
    {
        if (self.meishizhizuoDataSource.count == 0) {
            return CGSizeMake(0, 0);
        }
    }
    else if (section ==  4)
    {
        if (self.yuleshipinDataSource.count == 0) {
            return CGSizeMake(0, 0);
        }
    }
    else if (section ==  5)
    {
        if (self.joinUsDataSource.count == 0) {
            return CGSizeMake(0, 0);
        }
    }
    
    return CGSizeMake(collectionView.hd_width, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1)
    {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestClubActivityDetailWithInfo:@{@"command":@31,@"channel_name":@"activity",@"id":[self.tuijianDataSource[indexPath.row] objectForKey:@"id"]} withNotifiedObject:self];
    }
    else if (indexPath.section == 2)
    {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestXiShaMeiShiDetailWithInfo:@{@"command":@31,@"channel_name":@"dish",@"id":[self.xishameishiDataSource[indexPath.row] objectForKey:@"id"]} withNotifiedObject:self];
    }
}

- (void)foodOperation:(NSDictionary *)info1 andchannelName:(NSString *)channelName
{
    if (![[UserManager sharedManager] isUserLogin]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfLoginClick object:nil];
        return;
    }
    NSDictionary * info = [info1 objectForKey:@"info"];
    self.currentSelectInfo = info;
    switch ([[info1 objectForKey:@"type"] intValue]) {
        case FoodOperationType_good:
        {
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestDianzanDetailWithInfo:@{@"command":@36,@"channel_name":channelName,@"article_id":[info objectForKey:@"id"],@"click_type":@2} withNotifiedObject:self];
        }
            break;
        case FoodOperationType_Comment:
        {
            [_playerView destroyPlayer];
            FoodMakeCommentDetailViewController * vc = [[FoodMakeCommentDetailViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.channel_name = channelName;
            vc.infoDic = info;
            [self.navigationController pushViewController:vc animated:YES];
            __weak typeof(self)weakSelf = self;
            vc.refreshBlock = ^(BOOL refresh) {
                [weakSelf loadData];
            };
        }
            break;
        case FoodOperationType_collection:
        {
            [SVProgressHUD show];
            if ([[info objectForKey:@"is_collect"] intValue]) {
                // 已收藏，取消收藏
                [[UserManager sharedManager] didRequestCollectDetailWithInfo:@{@"command":@35,@"channel_name":channelName,@"article_id":[info objectForKey:@"id"]} withNotifiedObject:self];
            }else
            {
                [[UserManager sharedManager] didRequestCollectDetailWithInfo:@{@"command":@34,@"channel_name":channelName,@"article_id":[info objectForKey:@"id"]} withNotifiedObject:self];
            }
        }
            break;
        case FoodOperationType_share:
        {
            [_playerView pausePlay];
            
            bottomAlertView * alertV = [[bottomAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            [self.view.window addSubview:alertV];
            
            
            NSMutableDictionary * mShareInfo = [NSMutableDictionary dictionary];
            [mShareInfo setObject:channelName forKey:@"channel_name"];
            [mShareInfo setObject:[info objectForKey:@"id"] forKey:@"id"];
            [[NSUserDefaults standardUserDefaults] setObject:mShareInfo forKey:kCurrentShareInfo];
            [UserManager sharedManager].currentShareVC = self;
            
            alertV.shareBolck = ^(NSDictionary * _Nonnull info_Type) {
                switch ([[info_Type objectForKey:@"tag"] intValue]) {
                    case 1:
                    {
                        UIImage *thumbImage = [UIImage imageNamed:@"AppIcon"];
                         NSString * urlStr = kShareUrl;
                        [WXApiRequestHandler sendLinkURL:urlStr
                            TagName:kTagName
                              Title:[info objectForKey:@"title"]
                        Description:[info objectForKey:@"zhaiyao"]
                         ThumbImage:thumbImage
                            InScene:WXSceneSession];
                    }
                        break;
                    case 0:
                    {
                         UIImage *thumbImage = [UIImage imageNamed:@"AppIcon"];
                                                   NSString * urlStr = kShareUrl;
                                                  [WXApiRequestHandler sendLinkURL:urlStr
                                                      TagName:kTagName
                                                        Title:[info objectForKey:@"title"]
                                                  Description:[info objectForKey:@"zhaiyao"]
                                                   ThumbImage:thumbImage
                                                      InScene:WXSceneTimeline];
                    }
                        break;
                    default:
                        break;
                }
            };
            
        }
            break;
        case FoodOperationType_customMade:
        {
            [self showCustomMadeView_makeFood:info];
            [_playerView pausePlay];
        }
            break;
            
        default:
            break;
    }
}

- (void)pushCategoryVC:(NSDictionary *)info
{
    NSLog(@"%@", info);
    switch ([[info objectForKey:@"id"] intValue]) {
        case 1:
            {
                NSLog(@"about club");
                AboutClubViewController * vc = [[AboutClubViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 2:
        {
            NSLog(@"club active");
            ClubActivityViewController * vipVC = [[ClubActivityViewController alloc]init];
            vipVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vipVC animated:YES];
        }
            break;
        case 3:
        {
            NSLog(@"club bisai");
            ClubContestViewController * vipVC = [[ClubContestViewController alloc]init];
            vipVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vipVC animated:YES];
        }
            break;
        case 4:
        {
            VipCustomViewController * vipVC = [[VipCustomViewController alloc]init];
            vipVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vipVC animated:YES];
        }
            break;
            case 5:
            {
                WCQRCodeVC *WCVC = [[WCQRCodeVC alloc] init];
                WCVC.hidesBottomBarWhenPushed = YES;
                [self QRCodeScanVC:WCVC];
            }
                break;
            case 6:
            {
                JoinClubViewController * vc = [[JoinClubViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            
        default:
            break;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 因为复用，同一个cell可能会走多次
    if ([_cell isEqual:cell]) {
        // 区分是否是播放器所在的cell，销毁时将指针置空
        [_playerView destroyPlayer];
        _cell = nil;
    }
    
}

- (void)cl_tableViewCellPlayVideoWithCell:(MyCollectionCollectionViewCell *)cell
{
    // 记录被点击的cell
    _cell = cell;
    // 销毁播放器
    [_playerView destroyPlayer];
    CLPlayerView * playerView = [[CLPlayerView alloc]initWithFrame:cell.iconImageView.frame];
    _playerView = playerView;
    [cell.contentView addSubview:playerView];
    
    // 视频地址
    _playerView.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[cell.infoDic objectForKey:@"video_src"]]];
    [_playerView updateWithConfigure:^(CLPlayerViewConfigure *configure) {
        configure.topToolBarHiddenType = TopToolBarHiddenSmall;
    }];
    [_playerView playVideo];
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮点击");
    }];
    [_playerView endPlay:^{
        [self->_playerView destroyPlayer];
        self->_playerView = nil;
        self->_cell = nil;
    }];
    
}

- (void)showCustomMadeView_makeFood:(NSDictionary *)infoDic
{
    if ([[infoDic objectForKey:kGroup_id] intValue] > [[[[UserManager sharedManager] getUserInfos] objectForKey:kGroup_id] intValue]) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"由于您的等级不够，暂时不能定制，请联系门店升级" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
        return;
    }
    
    CustomView * customView = [[CustomView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    __weak typeof(self)weakSelf = self;
    customView.customMakeCommitBlock = ^(NSDictionary *info) {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestVIPCustomWithInfo:@{@"command":@37,@"channel_name":@"food",@"article_id":[infoDic objectForKey:@"id"],@"shop_id":@(0),@"name":[info objectForKey:@"name"],@"phone":[info objectForKey:@"phone"],@"address":[info objectForKey:@"address"],@"webchat":@"",@"birthday":@""} withNotifiedObject:weakSelf];
    };
    
    [window addSubview:customView];
}

- (void)showCustomMadeView:(NSDictionary *)infoDic
{
    CustomView * customView = [[CustomView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) withJopinClub:YES];
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    __weak typeof(self)weakSelf = self;
    customView.customMakeCommitBlock = ^(NSDictionary *info) {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestVIPCustomWithInfo:@{@"command":@37,@"channel_name":@"shop",@"article_id":[infoDic objectForKey:@"id"],@"shop_id":@0,@"name":[info objectForKey:@"name"],@"phone":[info objectForKey:@"phone"],@"address":@"",@"webchat":[info objectForKey:@"webchat"],@"birthday":[info objectForKey:@"birthday"]} withNotifiedObject:weakSelf];
    };
    
    [window addSubview:customView];
}

- (void)getCurrentpage_indexInfo{
    [self doResetQuestionRequest];
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

#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    [SVProgressHUD show];
    
    if ([[UserManager sharedManager] getGoodCategoryList] <= 0) {
        [[UserManager sharedManager] didRequestGoodCategoryListWithInfo:@{@"command":@8,@"channel_name":@"goods"} withNotifiedObject:nil];
    }
    if ([[UserManager sharedManager] getXishaFoodCategoryList] <= 0) {
        [[UserManager sharedManager] didRequestXishaFoodCategoryListWithInfo:@{@"command":@8,@"channel_name":@"dish"} withNotifiedObject:nil];
    }
    if ([[UserManager sharedManager] getFisheryHarvestCategoryList] <= 0) {
        [[UserManager sharedManager] didRequestFisheryHarvestCategoryListWithInfo:@{@"command":@8,@"channel_name":@"fish"} withNotifiedObject:nil];
    }
    if ([[UserManager sharedManager] getArderCategoryList] <= 0) {
        [[UserManager sharedManager] didRequestArderCategoryListWithInfo:@{@"command":@8,@"channel_name":@"arder"} withNotifiedObject:nil];
    }
    
    if ([[UserManager sharedManager] getFoodMakeCategoryList] <= 0) {
        [[UserManager sharedManager] didRequestFoodMakeCategoryListWithInfo:@{@"command":@8,@"channel_name":@"food"} withNotifiedObject:nil];
    }
    
    if ([[UserManager sharedManager] getClubActivityCategoryList] <= 0) {
        [[UserManager sharedManager] didRequestClubActivityCategoryListWithInfo:@{@"command":@8,@"channel_name":@"activity"} withNotifiedObject:nil];
    }
    
    if(self.bannerList.count == 0)
    {
        [[UserManager sharedManager] didRequestBannerWithCourseInfo:@{@"command":@28,@"channel_name":@"club"} withNotifiedObject:self];
    }
    
    [[UserManager sharedManager] didRequestClubChannelListWithInfo:@{@"command":@30,@"channel_name":@"activity",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"0",@"is_red":@1} withNotifiedObject:self];
    
    [[UserManager sharedManager] didRequestArderCategoryListWithInfo:@{@"command":@8,@"channel_name":@"arder"} withNotifiedObject:nil];
    [[UserManager sharedManager] didRequestXishaFoodCategoryListWithInfo:@{@"command":@8,@"channel_name":@"dish"} withNotifiedObject:nil];
    [[UserManager sharedManager] didRequestFoodMakeCategoryListWithInfo:@{@"command":@8,@"channel_name":@"food"} withNotifiedObject:nil];
    [[UserManager sharedManager] didRequestClubActivityCategoryListWithInfo:@{@"command":@8,@"channel_name":@"activity"} withNotifiedObject:nil];
     [[UserManager sharedManager] didRequestFisheryHarvestCategoryListWithInfo:@{@"command":@8,@"channel_name":@"fish"} withNotifiedObject:nil];
    
    
    [[UserManager sharedManager] didRequestXiShaMeiShiList_ClubWithInfo:@{@"command":@30,@"channel_name":@"dish",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"0",@"is_red":@1} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestFoodMakeList_ClubWithInfo:@{@"command":@30,@"channel_name":@"food",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"0",@"is_red":@1} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestYuleShipin_ClubWithInfo:@{@"command":@30,@"channel_name":@"arder",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"0",@"is_red":@1} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestStoreListWith:@{@"command":@13,@"key":@""} withNotifiedObject:self];
}

- (void)loadData
{
    if ([[UserManager sharedManager] getGoodCategoryList] <= 0) {
        [[UserManager sharedManager] didRequestGoodCategoryListWithInfo:@{@"command":@8,@"channel_name":@"goods"} withNotifiedObject:nil];
    }
    if ([[UserManager sharedManager] getXishaFoodCategoryList] <= 0) {
        [[UserManager sharedManager] didRequestXishaFoodCategoryListWithInfo:@{@"command":@8,@"channel_name":@"dish"} withNotifiedObject:nil];
    }
    if ([[UserManager sharedManager] getFisheryHarvestCategoryList] <= 0) {
        [[UserManager sharedManager] didRequestFisheryHarvestCategoryListWithInfo:@{@"command":@8,@"channel_name":@"fish"} withNotifiedObject:nil];
    }
    if ([[UserManager sharedManager] getArderCategoryList] <= 0) {
        [[UserManager sharedManager] didRequestArderCategoryListWithInfo:@{@"command":@8,@"channel_name":@"arder"} withNotifiedObject:nil];
    }
    
    if ([[UserManager sharedManager] getFoodMakeCategoryList] <= 0) {
        [[UserManager sharedManager] didRequestFoodMakeCategoryListWithInfo:@{@"command":@8,@"channel_name":@"food"} withNotifiedObject:nil];
    }
    
    if ([[UserManager sharedManager] getClubActivityCategoryList] <= 0) {
        [[UserManager sharedManager] didRequestClubActivityCategoryListWithInfo:@{@"command":@8,@"channel_name":@"activity"} withNotifiedObject:nil];
    }
    
    
    
    [[UserManager sharedManager] didRequestClubChannelListWithInfo:@{@"command":@30,@"channel_name":@"activity",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"0",@"is_red":@1} withNotifiedObject:self];

    [[UserManager sharedManager] didRequestBannerWithCourseInfo:@{@"command":@28,@"channel_name":@"club"} withNotifiedObject:self];
    
    
    NSDictionary * bichiInfo1 = @{@"title":@"店内美食",@"tags":@"全部美食",@"image":@"",@"iconImage":@"nav_food"};
    NSDictionary * bichiInfo2 = @{@"title":@"门店VR",@"tags":@"立体展示",@"image":@"",@"iconImage":@"nav_vr"};
    NSDictionary * bichiInfo3 = @{@"title":@"检测报告",@"tags":@"权威检测",@"image":@"",@"iconImage":@"nav_report"};
    NSDictionary * bichiInfo4 = @{@"title":@"渔获介绍",@"tags":@"详细介绍",@"image":@"",@"iconImage":@"nav_introduce"};
    [self.bichiDataSource addObject:bichiInfo1];
    [self.bichiDataSource addObject:bichiInfo2];
    [self.bichiDataSource addObject:bichiInfo3];
    [self.bichiDataSource addObject:bichiInfo4];
    
    NSDictionary * info1 = @{@"title":@"关于俱乐部",@"tags":@"全部美食",@"image":@"",@"iconImage":@"club_index_nav1",@"id":@1};
    NSDictionary * info2 = @{@"title":@"俱乐部活动",@"tags":@"立体展示",@"image":@"",@"iconImage":@"club_index_nav2",@"id":@2};
    NSDictionary * info3 = @{@"title":@"俱乐部比赛",@"tags":@"权威检测",@"image":@"",@"iconImage":@"club_index_nav3",@"id":@3};
    NSDictionary * info4 = @{@"title":@"会员专区",@"tags":@"详细介绍",@"image":@"",@"iconImage":@"club_index_nav4",@"id":@4};
    NSDictionary * info5 = @{@"title":@"溯源扫码",@"tags":@"",@"image":@"",@"iconImage":@"index_nav5",@"id":@5};
    NSDictionary * info6 = @{@"title":@"入会方式",@"tags":@"",@"image":@"",@"iconImage":@"index_nav6",@"id":@6};
    
//    [self.categoryDataSource addObject:info5];
//    [self.categoryDataSource addObject:info6];
    [self.categoryDataSource addObject:info1];
    [self.categoryDataSource addObject:info2];
    [self.categoryDataSource addObject:info3];
    [self.categoryDataSource addObject:info4];
    if (!([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi])) {
        [self.categoryDataSource removeObject:info4];
    }
    
    [[UserManager sharedManager] didRequestXiShaMeiShiList_ClubWithInfo:@{@"command":@30,@"channel_name":@"dish",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"0",@"is_red":@1} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestFoodMakeList_ClubWithInfo:@{@"command":@30,@"channel_name":@"food",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"0",@"is_red":@1} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestYuleShipin_ClubWithInfo:@{@"command":@30,@"channel_name":@"arder",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"0",@"is_red":@1} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestStoreListWith:@{@"command":@13,@"key":@""} withNotifiedObject:self];
    
}

- (void)didRequestChannelListSuccessed
{
    [self.collectionview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [self.tuijianDataSource removeAllObjects];
    for (NSDictionary * info in [[UserManager sharedManager] getclubChannelList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [mInfo setObject:[info objectForKey:@"zhaiyao"] forKey:@"content"];
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
    ClubActivityDetailViewController * vc = [[ClubActivityDetailViewController alloc]init];
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

- (void)didRequestBannerSuccessed
{
    [self.bannerList removeAllObjects];
    for (NSDictionary * info in [[UserManager sharedManager] getBannerList]) {
        NSString * imageUrl = [NSString stringWithFormat:@"%@%@", kRootImageUrl,[info objectForKey:@"img_url"]];
        [self.bannerList addObject:imageUrl];
    }
    
    
    [self.collectionview reloadData];
}

- (void)didRequestBannerFailed:(NSString *)failedInfo
{
    if ([[UserManager sharedManager] isUserLogin]) {
        [[UserManager sharedManager] didRequestBannerWithCourseInfo:@{@"command":@28} withNotifiedObject:self];
    }
}

- (void)didXishameishiListSuccessed
{
    self.xishameishiDataSource = [[UserManager sharedManager] getXiShaMeiShi_clubList];
    [self.collectionview reloadData];
}

- (void)didXishameishiListFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didYuleshipinListSuccessed
{
    self.yuleshipinDataSource = [[UserManager sharedManager] getYuLeShiPin_clubList];
    [self.collectionview reloadData];
}

- (void)didYuleshipinListFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didMeishizhizuoListSuccessed
{
    self.meishizhizuoDataSource = [[UserManager sharedManager] getFoodMake_clubList];
    [self.collectionview reloadData];
}

- (void)didMeishizhizuoListFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestStoreListKeyListSuccessed
{
    [SVProgressHUD dismiss];
    [self.joinUsDataSource removeAllObjects];
    for (NSDictionary * info in [[UserManager sharedManager] getStoreList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [self.joinUsDataSource addObject:mInfo];
    }
    [self.collectionview reloadData];
}

- (void)didRequestStoreListKeyListFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestGoodSuccessed
{
    [self getCurrentpage_indexInfo];
}

- (void)didRequestGoodFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestCollectSuccessed
{
    [self getCurrentpage_indexInfo];
}

- (void)didRequestCollectFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    self.currentSelectInfo = nil;
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestXishameishiDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestXishameishiDetailSuccessed
{
    [SVProgressHUD dismiss];
    CateDetailViewController * vc = [[CateDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.info = [[UserManager sharedManager] getXiShaMeiShiDetailInfo];
    [self.navigationController pushViewController:vc  animated:YES];
}

- (void)didRequestVIPCustomFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestVIPCustomSuccessed
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"申请成功"];
    
    [[UserManager sharedManager] didRequestStoreListWith:@{@"command":@13,@"key":@""} withNotifiedObject:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
