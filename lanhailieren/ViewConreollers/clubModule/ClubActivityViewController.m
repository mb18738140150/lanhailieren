//
//  ClubActivityViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/22.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ClubActivityViewController.h"
#import "ChooceStoreView.h"
#import "XishaFoodListCollectionViewCell.h"
#define kXishaFoodListCollectionViewCellID @"XishaFoodListCollectionViewCellID"
#import "ClubSearchActivityViewController.h"
#define kPageIndex @"pageIndex"
#define kPageSize @"pageSize"
#import "CLPlayerView.h"
#import "ClubActivityDetailViewController.h"

#define kClubActivityOperationNotify @"ClubActivityOperationNotify"

#import "NoDataCollectionViewCell.h"
#define kNoDataCellID @"NoDataCollectionViewCellID"

@interface ClubActivityViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UserModule_ChannelListProtocol,UserModule_ChannelDetailProtocol,UICollectionViewDelegateFlowLayout>

@property(nonatomic,retain)EScrollPageView *pageView;
@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, assign)float leftBarWidth;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, assign)NSInteger currentIndex;// 当前选中分类
@property (nonatomic, strong)NSArray * viewArray;
@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;
@property (nonatomic, strong)NSMutableArray * pageIndexArray;
@property (nonatomic, strong)ChooceStoreView * chooceStoreView;
@property (nonatomic, assign)int categoryID;

@end

@implementation ClubActivityViewController

- (NSMutableArray *)pageIndexArray
{
    if (!_pageIndexArray) {
        _pageIndexArray = [NSMutableArray array];
    }
    return _pageIndexArray;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(entertainmentOperation:) name:kClubActivityOperationNotify object:nil];
    
    
    
    [self navigationViewSetup];
//    self.view.backgroundColor = [UIColor redColor];
    
    [self refreshUI_iPhone];
    [self loadData];
    for (int i = 0; i < self.viewArray.count; i++) {
        ClubActivityItemView * view = [self.viewArray objectAtIndex:i];
        view.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
        view.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
    }
    
    __weak typeof(self)weakSelf = self;
    self.pageView.currentIndexBlock = ^(NSInteger index) {
        weakSelf.currentIndex = index;
        
        NSArray * categoryArray = [[UserManager sharedManager] getClubActivityCategoryList];
        if (categoryArray.count > index) {
            weakSelf.categoryID = [[categoryArray[index] objectForKey:@"id"] intValue];
        }
        ClubActivityItemView * view = [weakSelf.viewArray objectAtIndex:weakSelf.currentIndex];
        if (view.dataSource.count == 0) {
            [weakSelf startRequest];
        }
    };
}

- (void)loadData
{
    
    [self startRequest];
}

#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    NSMutableDictionary * mInfo = [self.pageIndexArray objectAtIndex:self.currentIndex];
    [mInfo setObject:@1 forKey:kPageIndex];
    self.page_index = 1;
    [self startRequest];
}

- (void)doNextPageQuestionRequest
{
    NSMutableDictionary * mInfo = [self.pageIndexArray objectAtIndex:self.currentIndex];
    int pageIndex = [[mInfo objectForKey:kPageIndex] intValue];
    pageIndex++;
    [mInfo setObject:@(pageIndex) forKey:kPageIndex];
    self.page_index = pageIndex;
    [self startRequest];
}

- (void)startRequest
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClubActivityListWithInfo:@{@"command":@30,@"channel_name":@"activity",@"category_id":@(self.categoryID),@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"0",@"is_red":@0} withNotifiedObject:self];
}



- (void)navigationViewSetup
{
    self.navigationItem.title = @"俱乐部活动";
    self.edgesForExtendedLayout = UIRectEdgeBottom;
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
    self.leftBar = [[LeftBar alloc]initWithFrame:CGRectMake(0, 0, 53, kScreenHeight - 64)];
    [self.view addSubview:self.leftBar];
    self.leftBarWidth = 53;
    [self pageView];
}

- (void)refreshUI_iPhone
{
    self.leftBarWidth = 0;
    self.chooceStoreView = [[ChooceStoreView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , 34)];
    [self.view addSubview:self.chooceStoreView];
    [self.chooceStoreView hideStoreView];
    __weak typeof(self)weakSelf = self;
    
    self.chooceStoreView.searchFoodBlock = ^(NSDictionary *info) {
        // search entertainmentVideo
        ClubSearchActivityViewController * vc = [[ClubSearchActivityViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    [self pageView];
}

- (EScrollPageView *)pageView{
    if (_pageView == nil) {
        CGFloat statusBarH = ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0);
        //每一项的view子类需要继承EScrollPageItemBaseView实现相关界面
        NSArray * categoryArray = [[UserManager sharedManager] getClubActivityCategoryList];
        if (categoryArray.count > 0) {
            self.categoryID = [[categoryArray[0] objectForKey:@"id"] intValue];
            self.page_size = 10;
            self.page_index = 1;
        }
        
        NSMutableArray * vs = [NSMutableArray array];
        [self.pageIndexArray removeAllObjects];
        [self.dataSource removeAllObjects];
        for (NSDictionary * info in categoryArray) {
            EScrollPageItemBaseView *v1 = [[ClubActivityItemView alloc] initWithPageTitle:[info objectForKey:@"title"]];
            [vs addObject:v1];
            NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
            [mInfo setObject:kPageSize forKey:@10];
            [mInfo setObject:kPageIndex forKey:@1];
            [self.pageIndexArray addObject:mInfo];
            NSMutableArray * array = [NSMutableArray array];
            [self.dataSource addObject:array];
        }
        
        EScrollPageParam *param = [[EScrollPageParam alloc] init];
        self.viewArray = vs;
        if(vs.count == 0)
        {
            return nil;
        }
        //头部高度
        param.headerHeight = 50;
        //默认第3个
        param.segmentParam.startIndex = 0;
        //排列类型
        param.segmentParam.type = EPageContentBetween;
        //每个宽度，在type == EPageContentLeft，生效
        param.segmentParam.itemWidth = 80;
        //底部线颜色
        param.segmentParam.lineColor = kMainRedColor;
        //背景颜色
        param.segmentParam.bgColor = 0xffffff;
        //正常字体颜色
        param.segmentParam.textColor = 0x000000;
        //选中的颜色
        param.segmentParam.textSelectedColor = 0x37a2f5;
        param.segmentParam.botLineColor = 0xffffff;
        param.segmentParam.topLineColor = 0xffffff;
        
        _pageView = [[EScrollPageView alloc] initWithFrame:CGRectMake(self.leftBarWidth, 34, self.view.frame.size.width - self.leftBarWidth, [UIScreen mainScreen].bounds.size.height-statusBarH) dataViews:vs setParam:param];
        [self.view addSubview:_pageView];
    }
    return _pageView;
}

- (void)entertainmentOperation:(NSNotification *)notification
{
    NSDictionary * info = notification.object;
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClubActivityDetailWithInfo:@{@"command":@31,@"channel_name":@"activity",@"id":[info objectForKey:@"id"]} withNotifiedObject:self];
}

#pragma mark - request

- (void)didRequestChannelListSuccessed
{
    [SVProgressHUD dismiss];
    ClubActivityItemView * view = [self.viewArray objectAtIndex:self.currentIndex];
    [view.tableView.mj_header endRefreshing];
    
    NSMutableArray * mArray = [self.dataSource objectAtIndex:self.currentIndex];
    NSMutableDictionary * mInfo = [self.pageIndexArray objectAtIndex:self.currentIndex];
    int pageIndex = [[mInfo objectForKey:kPageIndex] intValue];
    if (pageIndex == 1) {
        [mArray removeAllObjects];
    }
    
    if ([[UserManager sharedManager] getClubActivityListTotalCount] <= view.dataSource.count) {
        [view.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }else
    {
        [view.tableView.mj_footer endRefreshing];
    }
    
    NSArray * data = [[UserManager sharedManager] getclubActivityList];
    for (NSDictionary * info in data) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [mInfo setObject:[info objectForKey:@"zhaiyao"] forKey:@"content"];
        [mArray addObject:mInfo];
        
    }
    
    view.dataSource = mArray;
    [view.tableView reloadData];
}

- (void)didRequestChannelListFailed:(NSString *)failedInfo
{
    if(self.viewArray.count == 0)
    {
        return;
    }
    ClubActivityItemView * view = [self.viewArray objectAtIndex:self.currentIndex];
    [view.tableView.mj_header endRefreshing];
    [view.tableView.mj_footer endRefreshing];
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


- (void)orderStateSelect:(NSNotification *)notification
{
    NSDictionary * info = notification.object;
    int index = [[info objectForKey:@"orderState"] intValue];
    [self.pageView scrollToIndex:index];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
@interface ClubActivityItemView()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) CLPlayerView *playerView;
@property (nonatomic, assign)XishaFoodListCollectionViewCell * cell;// 记录cell

@end

@implementation ClubActivityItemView

- (void)didAppeared{
    [self tableView];
}
- (UICollectionView *)tableView{
    if (_tableView == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;

        CGFloat itemWidth = (kScreenWidth - 20) ;
        if (IS_PAD) {
            itemWidth = (kScreenWidth - 30) / 2;
        }
        layout.itemSize = CGSizeMake(itemWidth, itemWidth * 0.4 + 72);
        
        
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _tableView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        [_tableView registerClass:[XishaFoodListCollectionViewCell class] forCellWithReuseIdentifier:kXishaFoodListCollectionViewCellID];
        [_tableView registerClass:[NoDataCollectionViewCell class] forCellWithReuseIdentifier:kNoDataCellID];
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataSource.count == 0) {
        return 1;;
    }
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == 0) {
        NoDataCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNoDataCellID forIndexPath:indexPath];
        [cell refreshUI];
        
        return cell;
    }
    
    XishaFoodListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kXishaFoodListCollectionViewCellID forIndexPath:indexPath];
    NSDictionary * info = [self.dataSource objectAtIndex:indexPath.row] ;
    __weak typeof(self)weakSelf = self;
    __weak typeof(cell)wealCell = cell;
    
    [cell refreshClubUI:info];
    cell.playBlock = ^(NSDictionary * _Nonnull info) {
        [weakSelf cl_tableViewCellPlayVideoWithCell:wealCell];
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == 0) {
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kClubActivityOperationNotify object:[self.dataSource objectAtIndex:indexPath.row]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == 0) {
        return CGSizeMake(collectionView.hd_width, collectionView.hd_height);
    }else
    {
        CGFloat itemWidth = (kScreenWidth - 20) ;
        if (IS_PAD) {
            itemWidth = (kScreenWidth - 30) / 2;
        }
        return  CGSizeMake(itemWidth, itemWidth * 0.4 + 72);
    }
}

- (void)cl_tableViewCellPlayVideoWithCell:(XishaFoodListCollectionViewCell *)cell
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

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 因为复用，同一个cell可能会走多次
    if ([_cell isEqual:cell]) {
        // 区分是否是播放器所在的cell，销毁时将指针置空
        [_playerView destroyPlayer];
        _cell = nil;
    }
    
}
@end
