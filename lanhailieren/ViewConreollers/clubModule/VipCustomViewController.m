//
//  VipCustomViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/22.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "VipCustomViewController.h"
#import "VipCustomCollectionViewCell.h"
#define kVipCustomCollectionViewCellID @"VipCustomCollectionViewCellID"
#import "CLPlayerView.h"
#import "CustomView.h"
#import "VipCustomDetailViewController.h"
#import "ClubActivityDetailViewController.h"
#import "NoDataCollectionViewCell.h"
#define kNoDataCellID @"NoDataCollectionViewCellID"

@interface VipCustomViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDataSource,UIScrollViewDelegate,HYSegmentedControlDelegate,UserModule_ChannelListProtocol,UserModule_ChannelDetailProtocol,UserModule_VIPCustomProtocol,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSMutableArray * foodDoArray;
@property (nonatomic, strong)NSMutableArray * foodIntroArray;
@property (nonatomic, weak) CLPlayerView *playerView;
@property (nonatomic, assign)VipCustomCollectionViewCell * cell;// 记录cell
@property (nonatomic, assign)int sort;
@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;

@end

@implementation VipCustomViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)foodDoArray
{
    if (!_foodDoArray) {
        _foodDoArray = [NSMutableArray array];
    }
    return _foodDoArray;
}

- (NSMutableArray *)foodIntroArray
{
    if (!_foodIntroArray) {
        _foodIntroArray = [NSMutableArray array];
    }
    return _foodIntroArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationViewSetup];
    self.page_size = 10;
    self.page_index = 1;
    [self loadData];
    
    [self refreshUI];
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"会员定制";
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
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    if (IS_PAD) {
        CGFloat itemWidth = kScreenWidth / 2 - 1;
        CGFloat imageWidth = (itemWidth - 15);
        layout.itemSize = CGSizeMake(itemWidth, imageWidth * 0.48 + 45);
    }else
    {
        CGFloat imageWidth = (kScreenWidth - 20);
        layout.itemSize = CGSizeMake(kScreenWidth, imageWidth * 0.48 + 45);
    }
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight ) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[VipCustomCollectionViewCell class] forCellWithReuseIdentifier:kVipCustomCollectionViewCellID];
    [self.collectionView registerClass:[NoDataCollectionViewCell class] forCellWithReuseIdentifier:kNoDataCellID];

    [self.view addSubview:self.collectionView];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
    
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
    
    VipCustomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kVipCustomCollectionViewCellID forIndexPath:indexPath];
    __weak typeof(self)weakSelf = self;
    __weak typeof(cell)wealCell = cell;
    
    [cell refreshUI:self.dataArray[indexPath.row]];
    cell.playBlock = ^(NSDictionary * _Nonnull info) {
        [weakSelf cl_tableViewCellPlayVideoWithCell:wealCell];
    };
    cell.customMadeBlock = ^(NSDictionary * _Nonnull info) {
        [weakSelf showCustomMadeView:info];
        NSLog(@"custom made");
    };
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count == 0) {
        return CGSizeMake(collectionView.hd_width, collectionView.hd_height);
    }else
    {
        
        if (IS_PAD) {
            CGFloat itemWidth = kScreenWidth / 2 - 1;
            CGFloat imageWidth = (itemWidth - 15);
            return  CGSizeMake(itemWidth, imageWidth * 0.48 + 45);
        }else
        {
            CGFloat imageWidth = (kScreenWidth - 20);
            return CGSizeMake(kScreenWidth, imageWidth * 0.48 + 45);
        }
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count == 0) {
        return;
    }
    
    [_playerView destroyPlayer];
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClubServerDetailWithInfo:@{@"command":@31,@"channel_name":@"service",@"id":[self.dataArray[indexPath.row] objectForKey:@"id"]} withNotifiedObject:self];
//    VipCustomDetailViewController * vc = [[VipCustomDetailViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showCustomMadeView:(NSDictionary *)infoDic
{
    if ([[infoDic objectForKey:kGroup_id] intValue] > [[[[UserManager sharedManager] getUserInfos] objectForKey:kGroup_id] intValue]) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"由于您的等级不够，暂时不能定制，请联系门店升级" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
        return;
    }
    
    
    [_playerView pausePlay];
    CustomView * customView = [[CustomView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    
    __weak typeof(self)weakSelf = self;
    customView.customMakeCommitBlock = ^(NSDictionary *info) {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestVIPCustomWithInfo:@{@"command":@37,@"channel_name":@"service",@"article_id":[infoDic objectForKey:@"id"],@"shop_id":@(0),@"name":[info objectForKey:@"name"],@"phone":[info objectForKey:@"phone"],@"address":[info objectForKey:@"address"],@"webchat":@"",@"birthday":@""} withNotifiedObject:weakSelf];
    };
    
    [window addSubview:customView];
}


- (void)cl_tableViewCellPlayVideoWithCell:(VipCustomCollectionViewCell *)cell
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


#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    self.page_index = 1;
    [self startRequest];
}

- (void)doNextPageQuestionRequest
{
    self.page_index++;
    [self startRequest];
}

- (void)startRequest
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClubServerListWithInfo:@{@"command":@30,@"channel_name":@"service",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@(self.sort),@"is_red":@0} withNotifiedObject:self];
}

- (void)loadData
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClubServerListWithInfo:@{@"command":@30,@"channel_name":@"service",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"0",@"is_red":@0} withNotifiedObject:self];
}

#pragma mark - goosList request

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
    [SVProgressHUD showSuccessWithStatus:@"提交成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestChannelListSuccessed
{
    [SVProgressHUD dismiss];
    [self.collectionView.mj_header endRefreshing];
    
    if (self.page_index == 1) {
        [self.dataArray removeAllObjects];
    }
    for (NSDictionary * info in [[UserManager sharedManager] getClubServerList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [self.dataArray addObject:mInfo];
    }
    if ([[UserManager sharedManager] getClubServerListTotalCount] <= self.dataArray.count) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        self.page_index = 1;
    }else
    {
        [self.collectionView.mj_footer endRefreshing];
    }
    
    [self.collectionView reloadData];
    
}

- (void)didRequestChannelListFailed:(NSString *)failedInfo
{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
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
