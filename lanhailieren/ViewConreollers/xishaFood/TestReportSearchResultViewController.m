//
//  TestReportSearchResultViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/5/3.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "TestReportSearchResultViewController.h"

#import "XishaFoodListCollectionViewCell.h"
#define kXishaFoodListCollectionViewCellID @"XishaFoodListCollectionViewCellID"
#import "XishaSearchTestReportViewController.h"
#import "ClubActivityDetailViewController.h"
#import "SpecificationLayout.h"

#import "NoDataCollectionViewCell.h"
#define kNoDataCellID @"NoDataCollectionViewCellID"

@interface TestReportSearchResultViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UserModule_ChannelListProtocol,UserModule_ChannelDetailProtocol>

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UICollectionView * collectionview;

@property (nonatomic, strong)ChooceStoreView * chooceStoreView;

@property (nonatomic, strong)NSMutableArray * categoryDataSource;

@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;

@end

@implementation TestReportSearchResultViewController

- (NSMutableArray *)categoryDataSource
{
    if (!_categoryDataSource) {
        _categoryDataSource = [NSMutableArray array];
    }
    return _categoryDataSource;
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
    self.navigationItem.title = @"渔获权威检测报告";
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

#pragma mark - iPhone UI
- (void)refreshUI_iPhone
{
    SpecificationLayout * layout = [[SpecificationLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth - 20, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 5) collectionViewLayout:layout];
    self.collectionview.backgroundColor = [UIColor clearColor];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    
    [self.collectionview registerClass:[XishaFoodListCollectionViewCell class] forCellWithReuseIdentifier:kXishaFoodListCollectionViewCellID];
    [self.collectionview registerClass:[NoDataCollectionViewCell class] forCellWithReuseIdentifier:kNoDataCellID];

    
    [self.view addSubview:self.collectionview];
    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    self.collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
}

- (void)resetSelectStore:(NSDictionary *)info
{
    [self.chooceStoreView resetStoreName:[info objectForKey:@"title"]];
}

#pragma mark uicollectionview delegate & datasource _iPhone
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.categoryDataSource.count == 0) {
        return 1;;
    }
    return self.categoryDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.categoryDataSource.count == 0) {
        NoDataCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNoDataCellID forIndexPath:indexPath];
        [cell refreshUI];
        
        return cell;
    }
    XishaFoodListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kXishaFoodListCollectionViewCellID forIndexPath:indexPath];
    [cell refreshUI:[self.categoryDataSource objectAtIndex:indexPath.item]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.categoryDataSource.count == 0) {
           return CGSizeMake(collectionView.hd_width, collectionView.hd_height);
       }
    float width = (collectionView.hd_width - 2) / 2;
    if (IS_PAD) {
        width = (collectionView.hd_width - 4) / 4;
    }
    return CGSizeMake(width, width * 0.73 + 30);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.categoryDataSource.count == 0) {
        return;
    }
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClubContestDetailWithInfo:@{@"command":@31,@"channel_name":@"report",@"id":[self.categoryDataSource[indexPath.row] objectForKey:@"id"]} withNotifiedObject:self];
    
}


#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    self.page_index = 1;
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestStoreTestReportListWithInfo:@{@"command":@30,@"channel_name":@"report",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":self.key,@"sort":@(0),@"is_red":@0} withNotifiedObject:self];
    
}


- (void)doNextPageQuestionRequest
{
    self.page_index++;
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestStoreTestReportListWithInfo:@{@"command":@30,@"channel_name":@"report",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":self.key,@"sort":@(0),@"is_red":@0} withNotifiedObject:self];
    
}
- (void)loadData
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestStoreTestReportListWithInfo:@{@"command":@30,@"channel_name":@"report",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":self.key,@"sort":@(0),@"is_red":@0} withNotifiedObject:self];
    
}

- (void)didRequestChannelListSuccessed
{
    [SVProgressHUD dismiss];
    [self.collectionview.mj_header endRefreshing];
    
    if (self.page_index == 1) {
        [self.categoryDataSource removeAllObjects];
    }
    for (NSDictionary * info in [[UserManager sharedManager] getStoreTestReportList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [self.categoryDataSource addObject:mInfo];
    }
    
    
    if ([[UserManager sharedManager] getStoreTestReportListTotalCount] <= self.categoryDataSource.count) {
        [self.collectionview.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        [self.collectionview.mj_footer endRefreshing];
    }
    
    
    [self.collectionview reloadData];
    
}

- (void)didRequestChannelListFailed:(NSString *)failedInfo
{
    [self.collectionview.mj_header endRefreshing];
    [self.collectionview.mj_footer endRefreshing];
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
    vc.info = [[UserManager sharedManager] getClubContestDetail];
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

@end
