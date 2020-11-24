//
//  MyCustomViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/15.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "MyCustomViewController.h"
#import "MyCustomCollectionViewCell.h"
#define kMyCustomCollectionViewCellID @"MyCustomCollectionViewCellID"
#import "CLPlayerView.h"
#define kHYSegmentedControlHeight 45
#import "ClubActivityDetailViewController.h"
#import "VipCustomDetailViewController.h"
#import "FoodMakeCommentDetailViewController.h"
#import "NoDataCollectionViewCell.h"
#define kNoDataCellID @"NoDataCollectionViewCellID"

@interface MyCustomViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,HYSegmentedControlDelegate,UserModule_ChannelListProtocol,UserModule_GoodProtocol,UserModule_CollectProtocol,UICollectionViewDelegateFlowLayout,UserModule_XishameishiDetailProtocol,UserModule_ChannelDetailProtocol>

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, weak) CLPlayerView *playerView;
@property (nonatomic, assign)MyCustomCollectionViewCell * cell;// 记录cell

@property (nonatomic, strong)NSMutableArray * foodDoArray;
@property (nonatomic, strong)NSMutableArray * serverArray;
@property (nonatomic, assign)int pageSize;
@property (nonatomic, assign)int pageIndex;
@property (nonatomic, assign)int pageIndex_server;
@property (nonatomic, assign)int pageIndex_foodMake;

@property (nonatomic, strong)HYSegmentedControl * segmentC;
@property (nonatomic,  strong)NSDictionary * currentSelectInfo;// 当前选中分类下具体item
@property (nonatomic, strong)NSString * channel_name;

@end

@implementation MyCustomViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)serverArray
{
    if (!_serverArray) {
        _serverArray = [NSMutableArray array];
    }
    return _serverArray;
}

- (NSMutableArray *)foodDoArray
{
    if (!_foodDoArray) {
        _foodDoArray = [NSMutableArray array];
    }
    return _foodDoArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationViewSetup];
    self.dataArray = self.foodDoArray;
    self.channel_name = @"food";
    [self loadData];
    
    [self refreshUI];
}

- (void)loadData
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestVIPCustomListWithInfo:@{@"command":@38,@"channel_name":@"food"} withNotifiedObject:self];
    
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"我的定制";
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
    [self->_playerView destroyPlayer];
    self->_playerView = nil;
    self->_cell = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshUI
{
    self.view.backgroundColor = [UIColor clearColor];
    
    self.segmentC = [[HYSegmentedControl alloc] initWithOriginX:(kScreenWidth / 2 - 100) OriginY:0 Titles:@[@"美食制作", @"会员定制"] delegate:self drop:NO color:kMainRedColor];
    [self.segmentC hideBottomBackLine];
    [self.view addSubview:self.segmentC];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    if (IS_PAD) {
        CGFloat itemWidth = kScreenWidth / 2 - 1;
        CGFloat imageWidth = (itemWidth - 15);
        layout.itemSize = CGSizeMake(itemWidth, imageWidth * 0.48 + 30);
    }else
    {
        CGFloat imageWidth = (kScreenWidth - 20);
        layout.itemSize = CGSizeMake(kScreenWidth, imageWidth * 0.41 + 30);
    }
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kHYSegmentedControlHeight, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kHYSegmentedControlHeight) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[MyCustomCollectionViewCell class] forCellWithReuseIdentifier:kMyCustomCollectionViewCellID];
    [self.collectionView registerClass:[NoDataCollectionViewCell class] forCellWithReuseIdentifier:kNoDataCellID];

    [self.view addSubview:self.collectionView];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];

}

#pragma mark - HYSegmentedControlDelegate
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    self.currentSelectInfo = nil;
    if (index == 0) {
        self.dataArray = self.foodDoArray;
        self.channel_name = @"food";
    }else
    {
        self.channel_name = @"service";
        self.dataArray = self.serverArray;
        if (self.dataArray.count == 0) {
            [[UserManager sharedManager] didRequestVIPCustomListWithInfo:@{@"command":@38,@"channel_name":self.channel_name} withNotifiedObject:self];
        }
    }
    [self.collectionView reloadData];
}

#pragma mark - collectionView delegate & datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArray.count == 0) {
        return 1;;
    }
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count == 0) {
        NoDataCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNoDataCellID forIndexPath:indexPath];
        [cell refreshUI];
        
        return cell;
    }
    
    MyCustomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyCustomCollectionViewCellID forIndexPath:indexPath];
    __weak typeof(self)weakSelf = self;
    __weak typeof(cell)wealCell = cell;
    
    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:[self.dataArray[indexPath.row] objectForKey:@"article"]];
    [mInfo setObject:[self.dataArray[indexPath.row] objectForKey:@"add_time"] forKey:@"add_time"];
    
    [cell refreshUI:mInfo];
    cell.playBlock = ^(NSDictionary * _Nonnull info) {
        [weakSelf cl_tableViewCellPlayVideoWithCell:wealCell];
    };
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count == 0) {
        return CGSizeMake(collectionView.hd_width, collectionView.hd_height);
    }
    else
    {
        if (IS_PAD) {
              CGFloat itemWidth = kScreenWidth / 2 - 1;
              CGFloat imageWidth = (itemWidth - 15);
              return  CGSizeMake(itemWidth, imageWidth * 0.48 + 30);
          }else
          {
              CGFloat imageWidth = (kScreenWidth - 20);
              return CGSizeMake(kScreenWidth, imageWidth * 0.41 + 30);
          }
    }
}

- (void)cl_tableViewCellPlayVideoWithCell:(MyCustomCollectionViewCell *)cell
{
    // 记录被点击的cell
    _cell = cell;
    // 销毁播放器
    [_playerView destroyPlayer];
    CLPlayerView * playerView = [[CLPlayerView alloc]initWithFrame:cell.iconImageView.frame];
    _playerView = playerView;
    [cell.contentView addSubview:playerView];
    
    // 视频地址
    _playerView.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[[cell.infoDic objectForKey:@"fields"] objectForKey:@"video_src"]]];
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

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 因为复用，同一个cell可能会走多次
    if ([_cell isEqual:cell]) {
        // 区分是否是播放器所在的cell，销毁时将指针置空
        [_playerView destroyPlayer];
        _cell = nil;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_playerView destroyPlayer];
    if ([self.dataArray[indexPath.row] objectForKey:@"article"]) {
        if (self.segmentC.selectIndex == 1) {
//            VipCustomDetailViewController * vc = [[VipCustomDetailViewController alloc]init];
//            vc.info = [self.dataArray[indexPath.row] objectForKey:@"article"];
//            [self.navigationController pushViewController:vc  animated:YES];
//            return;
            
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestClubServerDetailWithInfo:@{@"command":@31,@"channel_name":@"service",@"id":[[self.dataArray[indexPath.row] objectForKey:@"article"] objectForKey:@"id"]} withNotifiedObject:self];
            return;
        }
//        ClubActivityDetailViewController * vc = [[ClubActivityDetailViewController alloc]init];
//        vc.info = [self.dataArray[indexPath.row] objectForKey:@"article"];
//        [self.navigationController pushViewController:vc  animated:YES];
        
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestXiShaMeiShiDetailWithInfo:@{@"command":@31,@"channel_name":@"food",@"id":[[self.dataArray[indexPath.row] objectForKey:@"article"] objectForKey:@"id"]} withNotifiedObject:self];
        
    }
}

#pragma mark - request
- (void)doResetQuestionRequest
{
    if (self.segmentC.selectIndex == 0) {
        self.pageIndex_foodMake = 1;
        self.pageIndex = 1;
    }else
    {
        self.pageIndex_server = 1;
        self.pageIndex = 1;
    }
    [self startRequest];
}

- (void)doNextPageQuestionRequest
{
    if (self.segmentC.selectIndex == 0) {
        self.pageIndex_foodMake++;
        self.pageIndex = self.pageIndex_foodMake;
    }else
    {
        self.pageIndex_server++;
        self.pageIndex = self.pageIndex_server;
    }
    [self startRequest];
}

- (void)startRequest
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestVIPCustomListWithInfo:@{@"command":@38,@"channel_name":self.channel_name} withNotifiedObject:self];
}


- (void)didRequestChannelListFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestChannelListSuccessed
{
    [SVProgressHUD dismiss];
    [self.collectionView.mj_header endRefreshing];
    
    NSMutableArray * mArray = self.dataArray;
    NSArray * data = [[UserManager sharedManager] getVIPCustomList];
    
    // 点赞等操作
       if (self.currentSelectInfo) {
           for (NSDictionary * info in data) {
               NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
               
               if ([[mInfo objectForKey:@"id"] isEqual:[self.currentSelectInfo objectForKey:@"id"]]) {
                   NSInteger index = [mArray indexOfObject:self.currentSelectInfo];
                   [mArray removeObject:self.currentSelectInfo];
                   [mInfo setObject:[info objectForKey:@"tags"] forKey:@"content"];
                   [mArray insertObject:mInfo atIndex:index];
                   break;
               }
               
           }
           self.dataArray = mArray;
           [self.collectionView reloadData];
           self.currentSelectInfo = nil;
           return;
       }
    
    if (self.pageIndex == 1) {
        [self.dataArray removeAllObjects];
    }
    
    for (NSDictionary * info in data) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        if (![[[info objectForKey:@"article"]  class] isEqual:[NSNull class]]) {
            [mArray addObject:mInfo];
        }
    }
    
    self.dataArray = mArray;
    [self.collectionView reloadData];
    
    if ([[UserManager sharedManager] getFoodMakeListTotalCount] <= self.dataArray.count) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        return;
    }else
    {
        [self.collectionView.mj_footer endRefreshing];
    }
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
    
    FoodMakeCommentDetailViewController * vc = [[FoodMakeCommentDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.channel_name = @"food";
    vc.infoDic = [[UserManager sharedManager] getXiShaMeiShiDetailInfo];
    [self.navigationController pushViewController:vc animated:YES];
    
    __weak typeof(self)weakSelf = self;
    vc.refreshBlock = ^(BOOL refresh) {
//        [weakSelf startRequest];
    };
}


- (void)didRequestChannelDetailSuccessed
{
    [SVProgressHUD dismiss];
    VipCustomDetailViewController * vc = [[VipCustomDetailViewController alloc]init];
    vc.info = [[UserManager sharedManager] getClubServerDetail];
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
