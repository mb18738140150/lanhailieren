//
//  XishaSearchFisheryHarvestViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/28.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "XishaSearchFisheryHarvestViewController.h"

#import "SearchHeaderView.h"
#import "JingpinCollectionViewCell.h"
#define kJingpinCollectionViewCellID @"JingpinCollectionViewCellID"
#import "HotSearchCategoryTableViewCell.h"
#define kHotSearchCategoryTableViewCellID @"HotSearchCategoryTableViewCellID"
#import "FoodIntroduceViewController.h"
#import "FoodListViewController.h"
#import "XishaSearchFisheryHarvestResultViewController.h"

@interface XishaSearchFisheryHarvestViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UserModule_HotSearchProtocol,UserModule_GetSearchKeyWordListProtocol,UserModule_CleanSearchKeyWordProtocol,UserModule_AddSearchKeyWordProtocol>

@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)UICollectionView * collectionview;
@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)NSArray * hotKeyArray;

@property (nonatomic, strong)SearchHeaderView * searchHeaderView;
//@property (nonatomic, assign)int page_size;
//@property (nonatomic, assign)int page_index;
@property (nonatomic, strong)NSString * currentKey;

@end

@implementation XishaSearchFisheryHarvestViewController


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentKey = @"";
    [self loadData];
    [self navigationViewSetup];
    if (IS_PAD) {
        [self refreshUI_iPad];
    }else
    {
        [self refreshUI_iPhone];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)loadData
{
    NSDictionary * infoDic = [[UserManager sharedManager] getHotSearchKeyInfo];
    self.hotKeyArray = [infoDic objectForKey:@"data"];
    [[UserManager sharedManager] HotSearchWith:@{@"command":@27} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestSearchKeyWordListWithCourseInfo:@{@"command":@25} withNotifiedObject:self];
    
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"渔获介绍";
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
- (void)refreshUI_iPad
{
    [self refreshUI_iPhone];
    return;
    
    
    self.leftBar = [[LeftBar alloc]initWithFrame:CGRectMake(0, 0, 53, kScreenHeight - 64)];
    [self.view addSubview:self.leftBar];
    
    UIView * view = [self topView];
    [self.view addSubview:view];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10;
    
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(53 + 10, 35, kScreenWidth - 53 - 20, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 35) collectionViewLayout:layout];
    self.collectionview.backgroundColor = [UIColor clearColor];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [self.collectionview registerClass:[HotSearchCategoryTableViewCell class] forCellWithReuseIdentifier:kHotSearchCategoryTableViewCellID];
    [self.collectionview registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headID"];
    [self.view addSubview:self.collectionview];
    
    //    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    //    self.collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
}

- (void)refreshUI_iPhone
{
    UIView * view = [self topView];
    [self.view addSubview:view];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(15, 35, kScreenWidth - 30, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 35) collectionViewLayout:layout];
    self.collectionview.backgroundColor = [UIColor clearColor];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [self.collectionview registerClass:[HotSearchCategoryTableViewCell class] forCellWithReuseIdentifier:kHotSearchCategoryTableViewCellID];
    [self.collectionview registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headID"];
    [self.view addSubview:self.collectionview];
    //    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    //    self.collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
}

#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    //    self.page_index = 1;
    //    [self startRequest];
}

- (void)doNextPageQuestionRequest
{
    //    self.page_index++;
    //    [self startRequest];
}

- (void)startRequest
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestSearchKeyWordListWithCourseInfo:@{@"command":@25} withNotifiedObject:self];
    //    [[UserManager sharedManager] didRequestGoodListWithInfo:@{@"command":@9,@"type":@1,@"categor_id":@0,@"plate":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":self.currentKey,@"sort":@"1",@"is_hot":@0,@"is_red":@0} withNotifiedObject:self];
}

- (void)pushFoodListVCWithCategoryID:(int)categoryId andPlate:(int )plate andIs_hot:(int)isHot andIs_red:(int)isred
{
    
    XishaSearchFisheryHarvestResultViewController * vc = [[XishaSearchFisheryHarvestResultViewController alloc]init];

    vc.key = self.currentKey;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)topView
{
    __weak typeof(self)weakSelf = self;
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    if (IS_PAD) {
        topView.frame = CGRectMake(53, 0, kScreenWidth - 53, 35);
    }else
    {
        topView.frame = CGRectMake(0, 0, kScreenWidth, 35);
    }
    
    self.searchHeaderView = [[SearchHeaderView alloc]initWithFrame:topView.bounds];
    [topView addSubview:self.searchHeaderView];
    self.searchHeaderView.searchBlock = ^(NSString * _Nonnull key) {
        NSLog(@"searchFood");
        weakSelf.currentKey = key;
        [[UserManager sharedManager] didRequestAddSearchKeyWordWithCourseInfo:@{@"command":@23,@"keyword":weakSelf.currentKey} withNotifiedObject:weakSelf];
        [weakSelf pushFoodListVCWithCategoryID:0 andPlate:0 andIs_hot:0 andIs_red:0];
    };
    self.searchHeaderView.cancelSearchBlock = ^(NSDictionary * _Nonnull info) {
        NSLog(@"cancel--serch");
        weakSelf.currentKey = @"";
        //        [weakSelf pushFoodListVCWithCategoryID:0 andPlate:0 andIs_hot:0 andIs_red:0];
    };
    return topView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    if (indexPath.section == 0) {
        HotSearchCategoryTableViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHotSearchCategoryTableViewCellID forIndexPath:indexPath];
        [cell refreshWith:@{@"dataArray":[[[UserManager sharedManager] getHotSearchKeyInfo] objectForKey:@"data"]}];
        cell.hotSearctBlock = ^(NSDictionary * _Nonnull info) {
            weakSelf.currentKey = [info objectForKey:@"keyword"];
            [weakSelf pushFoodListVCWithCategoryID:0 andPlate:0 andIs_hot:0 andIs_red:0];
        };
        return cell;
    }
    else
    {
        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
        [cell.contentView removeAllSubviews];
        
        UILabel * contentLB = [[UILabel alloc]initWithFrame:cell.contentView.bounds];
        contentLB.text = [NSString stringWithFormat:@"%@", [[self.dataArray objectAtIndex:indexPath.item] objectForKey:@"keyword"]];
        contentLB.textAlignment = NSTextAlignmentCenter;
        contentLB.font = kMainFont_12;
        contentLB.layer.cornerRadius = contentLB.hd_height / 2;
        contentLB.layer.masksToBounds = YES;
        contentLB.backgroundColor = UIColorFromRGB(0xf5f5f5);
        contentLB.textColor = UIColorFromRGB(0x333333);
        [cell.contentView addSubview:contentLB];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(collectionView.hd_width, 55);
    }
    NSString * str = [[self.dataArray objectAtIndex:indexPath.item] objectForKey:@"keyword"];
    float width = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, collectionView.hd_height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont_12} context:nil].size.width;
    return CGSizeMake(width + 30, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        self.currentKey = [[self.dataArray objectAtIndex:indexPath.item] objectForKey:@"keyword"];
        [self pushFoodListVCWithCategoryID:0 andPlate:0 andIs_hot:0 andIs_red:0];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    
    UICollectionViewCell *headview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headID" forIndexPath:indexPath];
    
    UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, collectionView.hd_width, 30)];
    titleLB.text = @"历史搜索";
    titleLB.textColor = UIColorFromRGB(0x666666);
    titleLB.font = kMainFont_12;
    [headview addSubview:titleLB];
    
    UIButton * cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cleanBtn.frame = CGRectMake(collectionView.hd_width - 20, 5, 20, 20);
    [cleanBtn setImage:[UIImage imageNamed:@"cleanSearchKey"] forState:UIControlStateNormal];
    [cleanBtn addTarget:self action:@selector(cleanSearchHistoryAction) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:cleanBtn];
    return headview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(collectionView.hd_width, 30);
}

- (void)cleanSearchHistoryAction
{
    [SVProgressHUD dismiss];
    [[UserManager sharedManager] didRequestCleanSearchKeyWordWithCourseInfo:@{@"command":@26} withNotifiedObject:self];
}

#pragma mark - goosList request
- (void)didRequestGetSearchKeyWordListSuccessed
{
    [SVProgressHUD dismiss];
    self.dataArray = [[[UserManager sharedManager] getSearchKeyWordList] mutableCopy];
    [self.collectionview reloadData];
}

- (void)didRequestGetSearchKeyWordListFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
}

- (void)didRequestAddSearchKeyWordSuccessed
{
    [SVProgressHUD dismiss];
    [self startRequest];
}

- (void)didRequestAddSearchKeyWordFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestCleanSearchKeyWordSuccessed
{
    [SVProgressHUD dismiss];
    [self startRequest];
}

- (void)didRequestCleanSearchKeyWordFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


- (void)didRequestHotSearchKeyListSuccessed
{
    [SVProgressHUD dismiss];
    [self.collectionview reloadData];
}

- (void)didRequestHotSearchKeyListFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
}


@end
