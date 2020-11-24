//
//  OrderFoodViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/5.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "OrderFoodViewController.h"
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

#import "BichiTableViewCell.h"
#define kBichiTableViewCellID @"BichiTableViewCellID"
#import "TuijianTableViewCell.h"
#define kTuijianTableViewCellID @"TuijianTableViewCellID"
#import "JingPinTableViewCell.h"
#define kJingPinTableViewCellID @"JingPinTableViewCellID"
#import "HeadCategiryTableViewCell.h"
#define kHeadCategiryTableViewCellID @"HeadCategiryTableViewCellID"
#import "FoodListViewController.h"
#import "ChoosStoreViewController.h"
#import "SearchFoodViewController.h"
#import "FoodIntroduceViewController.h"

@interface OrderFoodViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate, UITableViewDataSource,UserModule_GoodCategoryProtocol,UserModule_GoodList_qualityProtocol,UserModule_GoodList_recommendProtocol,UserModule_HotSearchProtocol,UserModule_BannerProtocol>

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UICollectionView * collectionview;
@property (nonatomic, strong)UITableView * tableview;

@property (nonatomic, strong)ChooceStoreView * chooceStoreView;

@property (nonatomic, strong)NSMutableArray * categoryDataSource;
@property (nonatomic, strong)NSMutableArray * bichiDataSource;
@property (nonatomic, strong)NSMutableArray * tuijianDataSource;
@property (nonatomic, strong)NSMutableArray * jingpinDataSource;

@property (nonatomic, strong)NSMutableArray * bannerList;

@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;
@end

@implementation OrderFoodViewController

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
    if (IS_PAD) {
        [self refreshUI_iPad];
    }else
    {
        [self refreshUI_iPhone];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getStoreSuccess:) name:kNotificationOfGetStoreSuccess object:nil];
}

- (void)getStoreSuccess:(NSNotification *)notification
{
    [self resetSelectStore:[UserManager sharedManager].currentSelectStore];
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"海鲜商城";
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kCommonMainTextColor_50};
}

- (void)backAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshUI_iPad
{
    self.leftBar = [[LeftBar alloc]initWithFrame:CGRectMake(0, 0, 53, kScreenHeight - 64)];
    [self.view addSubview:self.leftBar];
    
    self.chooceStoreView = [[ChooceStoreView alloc]initWithFrame:CGRectMake(53, 0, kScreenWidth - 53, 34)];
    [self.view addSubview:self.chooceStoreView];
    __weak typeof(self)weakSelf = self;
    self.chooceStoreView.ChooseStoreActionBlock = ^(NSDictionary *info) {
        [weakSelf pushChooseStoreVC];
    };
    self.chooceStoreView.searchFoodBlock = ^(NSDictionary *info) {
        SearchFoodViewController * searchVC = [[SearchFoodViewController alloc]init];
        searchVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:searchVC animated:YES];
    };
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(53, 34, kScreenWidth - 53, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 34) style:UITableViewStylePlain];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[BichiTableViewCell class] forCellReuseIdentifier:kBichiTableViewCellID];
    [self.tableview registerClass:[TuijianTableViewCell class] forCellReuseIdentifier:kTuijianTableViewCellID];
    [self.tableview registerClass:[JingPinTableViewCell class] forCellReuseIdentifier:kJingPinTableViewCellID];
    [self.tableview registerClass:[HeadCategiryTableViewCell class] forCellReuseIdentifier:kHeadCategiryTableViewCellID];
    [self.view addSubview:self.tableview];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    
}



#pragma mark - tableView delegate & datasource _iPad
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    if (indexPath.section == 1) {
        BichiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kBichiTableViewCellID forIndexPath:indexPath];
        [cell refreshUIWithInfo:@{@"dataArray":self.bichiDataSource}];
        cell.plateBlock = ^(NSDictionary *info) {
            NSString * str = [info objectForKey:@"title"];
            int plate = 0;
            if ([str containsString:@"必吃"]) {
                plate = 1;
            }else if ([str containsString:@"最新"])
            {
                plate = 2;
            }else if ([str containsString:@"限时"])
            {
                plate = 3;
            }else if ([str containsString:@"精品"])
            {
                plate = 4;
            }
            
            [weakSelf pushFoodListVCWithCategoryID:0 andPlate:plate andIs_hot:0 andIs_red:0];
        };
        
        return cell;
    }else if (indexPath.section == 2)
    {
        TuijianTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTuijianTableViewCellID forIndexPath:indexPath];
        [cell refreshUIWithInfo:@{@"dataArray":self.tuijianDataSource}];
        cell.foodClickBlock = ^(NSDictionary *info) {
            [weakSelf pushFoodIntroVC:info];
        };
        return cell;
    }else if (indexPath.section == 0)
    {
        HeadCategiryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kHeadCategiryTableViewCellID forIndexPath:indexPath];
        [cell refreshUIWithInfo:@{@"dataArray":self.categoryDataSource,@"image":@"placeholdImage"}];
        cell.FishCategory_headTableViewClickBlock = ^(NSDictionary *info) {
            NSLog(@"%@", info);
            // 分类——获取商品
            [weakSelf pushFoodListVCWithCategoryID:[[info objectForKey:@"id"] intValue] andPlate:0 andIs_hot:0 andIs_red:0];
        };
        return cell;
    }
    else
    {
        JingPinTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kJingPinTableViewCellID forIndexPath:indexPath];
        [cell refreshUIWithInfo:@{@"dataArray":self.jingpinDataSource}];
        cell.foodClickBlock = ^(NSDictionary *info) {
            [weakSelf pushFoodIntroVC:info];
        };
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        float width = (kScreenWidth) / 5;
        return (width) * 0.6 + 125;
    }else if (indexPath.section == 2)
    {
        float width = (kScreenWidth) / 5;
        return (width) * 0.5 + 85;
    }
    else if (indexPath.section == 0)
    {
       return tableView.hd_width * 0.25 + 78;
    }else
    {
        float width = (kScreenWidth - 53 - 60) / 5;
        return (width) * 0.7 + 104;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    __weak typeof(self)weakSelf = self;
    if (section == 3) {
        UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.hd_width, 30)];
        
        Head_tipCollectionReusableView * view = [[Head_tipCollectionReusableView alloc]initWithFrame:headView.bounds];
        [view refreshUIWith:@{@"title":@"精品商品"}];
        [headView addSubview:view];
        // 精品——获取商品
        view.goBlock = ^(NSDictionary *info) {
            [weakSelf pushFoodListVCWithCategoryID:0 andPlate:0 andIs_hot:1 andIs_red:0];
        };
        return headView;
    }else if(section == 2)
    {
        UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.hd_width, 30)];
        
        Head_tipCollectionReusableView * view = [[Head_tipCollectionReusableView alloc]initWithFrame:headView.bounds];
        [view refreshUIWith:@{@"title":@"为您推荐"}];
        [headView addSubview:view];
        // 推荐——获取商品
        view.goBlock = ^(NSDictionary *info) {
            [weakSelf pushFoodListVCWithCategoryID:0 andPlate:0 andIs_hot:0 andIs_red:1];
        };
        return headView;
    }else
    {
        UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        return headView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 0;
    }else
    {
        return 30;
    }
}

#pragma mark - iPhone UI
- (void)refreshUI_iPhone
{
    
    self.chooceStoreView = [[ChooceStoreView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 34)];
    [self.view addSubview:self.chooceStoreView];
    __weak typeof(self)weakSelf = self;
    self.chooceStoreView.ChooseStoreActionBlock = ^(NSDictionary *info) {
        [weakSelf pushChooseStoreVC];
    };
    self.chooceStoreView.searchFoodBlock = ^(NSDictionary *info) {
        SearchFoodViewController * searchVC = [[SearchFoodViewController alloc]init];
        searchVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:searchVC animated:YES];
    };
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 34, kScreenWidth - 20, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 34 - 50) collectionViewLayout:layout];
    self.collectionview.backgroundColor = [UIColor clearColor];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    [self.collectionview registerClass:[BiChiCollectionViewCell class] forCellWithReuseIdentifier:kBiChiCollectionViewCellID];
    [self.collectionview registerClass:[TuijianCollectionViewCell class] forCellWithReuseIdentifier:kTuijianCollectionViewCellID];
    [self.collectionview registerClass:[JingpinCollectionViewCell class] forCellWithReuseIdentifier:kJingpinCollectionViewCellID];
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
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.bichiDataSource.count;
    }else if (section == 1)
    {
        return self.tuijianDataSource.count;
    }else if (section == 2)
    {
        return self.jingpinDataSource.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BiChiCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBiChiCollectionViewCellID forIndexPath:indexPath];
        [cell refreshUIWithInfo:[self.bichiDataSource objectAtIndex:indexPath.item]];
        return cell;
    }else if (indexPath.section == 1)
    {
        TuijianCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTuijianCollectionViewCellID forIndexPath:indexPath];
        [cell refreshUIWithInfo:[self.tuijianDataSource objectAtIndex:indexPath.item]];
        return cell;
    }else {
        JingpinCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kJingpinCollectionViewCellID forIndexPath:indexPath];
        [cell refreshUIWithInfo:[self.jingpinDataSource objectAtIndex:indexPath.item]];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake((kScreenWidth - 30) / 2, kScreenWidth * 0.2 + 75);
    }else if (indexPath.section == 1)
    {
        float width = (kScreenWidth - 30) / 2;
        return CGSizeMake((kScreenWidth - 30) / 2, width * 0.66 + 85);
    }else {
        float width = (kScreenWidth - 30) / 2;
        return CGSizeMake((kScreenWidth - 30) / 2, width * 0.7 + 85);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    if (indexPath.section == 0) {
        Head_categoryCollectionReusableView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHead_categoryCollectionReusableViewID forIndexPath:indexPath];
        headView.bannerImgUrlArray = self.bannerList;
        [headView refreshUIWith:@{@"dataArray":self.categoryDataSource,@"image":@"placeholdImage"}];
        
        // 分类——获取商品
        headView.FishCategory_headClickBlock = ^(NSDictionary *info) {
            
            [weakSelf pushFoodListVCWithCategoryID:[[info objectForKey:@"id"] intValue] andPlate:0 andIs_hot:0 andIs_red:0];
        };
        
        return headView;
    }else if (indexPath.section == 1)
    {
        Head_tipCollectionReusableView * tipHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHead_tipCollectionReusableViewID forIndexPath:indexPath];
        [tipHeadView refreshUIWith:@{@"title":@"为您推荐"}];
        
        // 推荐——获取商品
        tipHeadView.goBlock = ^(NSDictionary *info) {
            [weakSelf pushFoodListVCWithCategoryID:0 andPlate:0 andIs_hot:0 andIs_red:1];
        };
        
        return tipHeadView;
    }else
    {
        Head_tipCollectionReusableView * tipHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHead_tipCollectionReusableViewID forIndexPath:indexPath];
        [tipHeadView refreshUIWith:@{@"title":@"精品商品"}];
        // 精品——获取商品
        tipHeadView.goBlock = ^(NSDictionary *info) {
            [weakSelf pushFoodListVCWithCategoryID:0 andPlate:0 andIs_hot:1 andIs_red:0];
        };
        
        return tipHeadView;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        if (self.categoryDataSource.count > 4) {
            return CGSizeMake(collectionView.hd_width, collectionView.hd_width * 0.42 + 160);
        }
        return CGSizeMake(collectionView.hd_width, collectionView.hd_width * 0.42 + 90);
    }else
    {
        return CGSizeMake(collectionView.hd_width, 30);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSDictionary * info = [self.bichiDataSource objectAtIndex:indexPath.item];
        NSString * str = [info objectForKey:@"title"];
        int plate = 0;
        if ([str containsString:@"必吃"]) {
            plate = 1;
        }else if ([str containsString:@"最新"])
        {
            plate = 2;
        }else if ([str containsString:@"限时"])
        {
            plate = 3;
        }else if ([str containsString:@"精品"])
        {
            plate = 4;
        }
        
        [self pushFoodListVCWithCategoryID:0 andPlate:plate andIs_hot:0 andIs_red:0];
    }else
    {
        NSDictionary * foodInfo;
        if (indexPath.section == 1) {
            foodInfo = [self.tuijianDataSource objectAtIndex:indexPath.row];
        }else if (indexPath.section == 2)
        {
            foodInfo = [self.jingpinDataSource objectAtIndex:indexPath.row];
        }
        [self pushFoodIntroVC:foodInfo];
    }
    
}

- (void)pushFoodIntroVC:(NSDictionary *)info
{
    FoodIntroduceViewController * vc = [[FoodIntroduceViewController alloc]init];
    vc.good_id = [[info objectForKey:@"id"] intValue];
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushFoodListVCWithCategoryID:(int)categoryId andPlate:(int )plate andIs_hot:(int)isHot andIs_red:(int)isred
{
    FoodListViewController * vc = [[FoodListViewController alloc]init];
    vc.categor_id = categoryId;
    vc.plate = plate;
    vc.is_hot = isHot;
    vc.is_red = isred;
    vc.key = @"";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestGoodCategoryListWithInfo:@{@"command":@8} withNotifiedObject:self];
    
    [[UserManager sharedManager] didRequestGoodListQualityWithInfo:@{@"command":@9,@"type":@1,@"categor_id":@0,@"plate":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"1",@"is_hot":@1,@"is_red":@0} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestGoodListRecommendWithInfo:@{@"command":@9,@"type":@1,@"categor_id":@0,@"plate":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"1",@"is_hot":@0,@"is_red":@1} withNotifiedObject:self];
    
}

- (void)loadData
{
    [[UserManager sharedManager] didRequestGoodCategoryListWithInfo:@{@"command":@8} withNotifiedObject:self];
    
    [[UserManager sharedManager] didRequestGoodListQualityWithInfo:@{@"command":@9,@"type":@1,@"categor_id":@0,@"plate":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"1",@"is_hot":@1,@"is_red":@0} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestGoodListRecommendWithInfo:@{@"command":@9,@"type":@1,@"categor_id":@0,@"plate":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"1",@"is_hot":@0,@"is_red":@1} withNotifiedObject:self];
    [[UserManager sharedManager] HotSearchWith:@{@"command":@27} withNotifiedObject:self];
    
    [[UserManager sharedManager] didRequestBannerWithCourseInfo:@{@"command":@28} withNotifiedObject:self];
    
    
    
    
    NSDictionary * bichiInfo1 = @{@"title":@"必吃榜单",@"tags":@"吃货大本营就在这里",@"image":@"bg_mall_project1",@"iconImage":@"bichi_1"};
    NSDictionary * bichiInfo2 = @{@"title":@"最新上市",@"tags":@"新品抢先吃",@"image":@"bg_mall_project2",@"iconImage":@"bichi_2"};
    NSDictionary * bichiInfo3 = @{@"title":@"限时热卖",@"tags":@"买到就是赚到",@"image":@"bg_mall_project3",@"iconImage":@"bichi_3"};
    NSDictionary * bichiInfo4 = @{@"title":@"精品推荐",@"tags":@"品质生活必备",@"image":@"bg_mall_project4",@"iconImage":@"bichi_4"};
    [self.bichiDataSource addObject:bichiInfo1];
    [self.bichiDataSource addObject:bichiInfo2];
    [self.bichiDataSource addObject:bichiInfo3];
    [self.bichiDataSource addObject:bichiInfo4];
    
}

- (void)didRequestGoodCategorySuccessed
{
    [self.tableview.mj_header endRefreshing];
    [self.collectionview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    self.categoryDataSource = [[UserManager sharedManager] getGoodCategoryList];
    [self.tableview reloadData];
    [self.collectionview reloadData];
}

- (void)didRequestGoodCategoryFailed:(NSString *)failedInfo
{
    [self.tableview.mj_header endRefreshing];
    [self.collectionview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestGoodList_qualitySuccessed
{
    [self.tableview.mj_header endRefreshing];
    [self.collectionview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [self.jingpinDataSource removeAllObjects];
    for (NSDictionary * info in [[UserManager sharedManager] getGoodList_quality]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [mInfo setObject:[info objectForKey:@"sell_price"] forKey:@"price"];
        [self.jingpinDataSource addObject:mInfo];
    }
    
    [self.tableview reloadData];
    [self.collectionview reloadData];
}

- (void)didRequestGoodList_qualityFailed:(NSString *)failedInfo
{
    [self.tableview.mj_header endRefreshing];
    [self.collectionview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestGoodList_recommendFailed:(NSString *)failedInfo
{
    [self.tableview.mj_header endRefreshing];
    [self.collectionview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestGoodList_recommendSuccessed
{
    [self.tableview.mj_header endRefreshing];
    [self.collectionview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [self.tuijianDataSource removeAllObjects];
    for (NSDictionary * info in [[UserManager sharedManager] getGoodList_Recommend]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [mInfo setObject:[info objectForKey:@"sell_price"] forKey:@"price"];
        [self.tuijianDataSource addObject:mInfo];
    }
    
    [self.tableview reloadData];
    [self.collectionview reloadData];
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
    for (NSDictionary * info in [[UserManager sharedManager] getBannerList]) {
        NSString * imageUrl = [NSString stringWithFormat:@"%@%@", kRootImageUrl,[info objectForKey:@"img_url"]];
        [self.bannerList addObject:imageUrl];
    }
    
    if (IS_PAD) {
        [self.tableview reloadData];
    }else
    {
        [self.collectionview reloadData];
    }
}

- (void)didRequestBannerFailed:(NSString *)failedInfo
{
//    [[UserManager sharedManager] didRequestBannerWithCourseInfo:@{@"command":@28} withNotifiedObject:self];
}

@end
