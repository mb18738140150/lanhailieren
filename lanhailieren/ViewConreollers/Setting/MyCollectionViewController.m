//
//  MyCollectionViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/16.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionCollectionViewCell.h"
#define kMyCollectionCollectionViewCellID @"MyCollectionCollectionViewCellID"
#import "CLPlayerView.h"
#define kHYSegmentedControlHeight 45
#import "FoodMakeCommentDetailViewController.h"

#import "NoDataCollectionViewCell.h"
#define kNoDataCellID @"NoDataCollectionViewCellID"
#import "bottomAlertView.h"

@interface MyCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,HYSegmentedControlDelegate,UserModule_ChannelListProtocol,UserModule_GoodProtocol,UserModule_CollectProtocol>
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSMutableArray * foodDoArray;
@property (nonatomic, strong)NSMutableArray * arderArray;
@property (nonatomic, weak) CLPlayerView *playerView;
@property (nonatomic, assign)MyCollectionCollectionViewCell * cell;// 记录cell

@property (nonatomic, assign)int currentSegmentSelectIndex;

@property (nonatomic, assign)int pageSize;
@property (nonatomic, assign)int pageIndex;
@property (nonatomic, assign)int pageIndex_arder;
@property (nonatomic, assign)int pageIndex_foodMake;

@property (nonatomic, strong)HYSegmentedControl * segmentC;
@property (nonatomic,  strong)NSDictionary * currentSelectInfo;// 当前选中分类下具体item
@property (nonatomic, strong)NSString * channel_name;

@end

@implementation MyCollectionViewController

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

- (NSMutableArray *)arderArray
{
    if (!_arderArray) {
        _arderArray = [NSMutableArray array];
    }
    return _arderArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationViewSetup];
    self.pageSize = 10;
    self.pageIndex = 1;
    self.pageIndex_foodMake = 1;
    self.pageIndex_arder = 1;
    
    [self loadData];
    
    [self refreshUI];
}

- (void)loadData
{
    self.dataArray = self.foodDoArray;
    self.channel_name = @"food";
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestFoodMakeListWithInfo:@{@"command":@39,@"channel_name":@"food",@"page_size":@(self.pageSize),@"page_index":@(self.pageIndex)} withNotifiedObject:self];
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"我的收藏";
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
    
    self.segmentC = [[HYSegmentedControl alloc] initWithOriginX:(kScreenWidth / 2 - 100) OriginY:0 Titles:@[@"美食制作", @"休闲娱乐"] delegate:self drop:NO color:kMainRedColor];
    [self.segmentC hideBottomBackLine];
    [self.view addSubview:self.segmentC];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    if (IS_PAD) {
        CGFloat itemWidth = kScreenWidth / 2 - 1;
        CGFloat imageWidth = (itemWidth - 15);
        layout.itemSize = CGSizeMake(itemWidth, imageWidth * 0.48 + 50);
    }else
    {
        CGFloat imageWidth = (kScreenWidth - 20);
        layout.itemSize = CGSizeMake(kScreenWidth, imageWidth * 0.41 + 40);
    }
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kHYSegmentedControlHeight, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kHYSegmentedControlHeight) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[MyCollectionCollectionViewCell class] forCellWithReuseIdentifier:kMyCollectionCollectionViewCellID];
    [self.collectionView registerClass:[NoDataCollectionViewCell class] forCellWithReuseIdentifier:kNoDataCellID];

    [self.view addSubview:self.collectionView];
    
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
    
}
#pragma mark - HYSegmentedControlDelegate
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    self.currentSelectInfo = nil;
    
    if (self.currentSegmentSelectIndex == index) {
        return;
    }
    [_playerView destroyPlayer];
    if (index == 0) {
        self.dataArray = self.foodDoArray;
        self.channel_name = @"food";
    }else
    {
        self.channel_name = @"arder";
        self.dataArray = self.arderArray;
        if (self.dataArray.count == 0) {
            [[UserManager sharedManager] didRequestFoodMakeListWithInfo:@{@"command":@39,@"channel_name":@"arder",@"page_size":@(self.pageSize),@"page_index":@(1)} withNotifiedObject:self];
        }
    }
    [self.collectionView reloadData];
    self.currentSegmentSelectIndex = index;
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
    
    MyCollectionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyCollectionCollectionViewCellID forIndexPath:indexPath];
    __weak typeof(self)weakSelf = self;
    __weak typeof(cell)wealCell = cell;
    
    [cell refreshUI:self.dataArray[indexPath.row]];
    cell.playBlock = ^(NSDictionary * _Nonnull info) {
        [weakSelf cl_tableViewCellPlayVideoWithCell:wealCell];
    };
    
    cell.goodBlock = ^(NSDictionary * _Nonnull info) {
        NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
        [mInfo setObject:info forKey:@"info"];
        [mInfo setObject:@(FoodOperationType_good) forKey:@"type"];
        [self foodOperation:mInfo];
        NSLog(@"good");
    };
    cell.commentBlock = ^(NSDictionary * _Nonnull info) {
        NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
        [mInfo setObject:info forKey:@"info"];
        [mInfo setObject:@(FoodOperationType_Comment) forKey:@"type"];
        [self foodOperation:mInfo];
        NSLog(@"good");
    };
    cell.collectBlock = ^(NSDictionary * _Nonnull info) {
        NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
        [mInfo setObject:info forKey:@"info"];
        [mInfo setObject:@(FoodOperationType_collection) forKey:@"type"];
        [self foodOperation:mInfo];
        NSLog(@"good");
    };
    cell.shareBlock = ^(NSDictionary * _Nonnull info) {
        NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
        [mInfo setObject:info forKey:@"info"];
        [mInfo setObject:@(FoodOperationType_share) forKey:@"type"];
        [self foodOperation:mInfo];
        NSLog(@"good");
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
           return  CGSizeMake(itemWidth, imageWidth * 0.48 + 55);
       }else
       {
           CGFloat imageWidth = (kScreenWidth - 20);
           return CGSizeMake(kScreenWidth, imageWidth * 0.41 + 40);
       }
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

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 因为复用，同一个cell可能会走多次
    if ([_cell isEqual:cell]) {
        // 区分是否是播放器所在的cell，销毁时将指针置空
        [_playerView destroyPlayer];
        _cell = nil;
    }
    
}


- (void)foodOperation:(NSDictionary *)info1
{
    NSDictionary * info = [info1 objectForKey:@"info"];
    self.currentSelectInfo = info;
    switch ([[info1 objectForKey:@"type"] intValue]) {
        case FoodOperationType_good:
        {
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestDianzanDetailWithInfo:@{@"command":@36,@"channel_name":self.channel_name,@"article_id":[info objectForKey:@"id"],@"click_type":@2} withNotifiedObject:self];
        }
            break;
        case FoodOperationType_Comment:
        {
            [_playerView destroyPlayer];
            FoodMakeCommentDetailViewController * vc = [[FoodMakeCommentDetailViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.channel_name = self.channel_name;
            vc.infoDic = info;
            [self.navigationController pushViewController:vc animated:YES];
            __weak typeof(self)weakSelf = self;
            vc.refreshBlock = ^(BOOL refresh) {
                [weakSelf startRequest];
            };
        }
            break;
        case FoodOperationType_collection:
        {
            [SVProgressHUD show];
            if ([[info objectForKey:@"is_collect"] intValue]) {
                // 已收藏，取消收藏
                [[UserManager sharedManager] didRequestCollectDetailWithInfo:@{@"command":@35,@"channel_name":self.channel_name,@"article_id":[info objectForKey:@"id"]} withNotifiedObject:self];
            }else
            {
                [[UserManager sharedManager] didRequestCollectDetailWithInfo:@{@"command":@34,@"channel_name":self.channel_name,@"article_id":[info objectForKey:@"id"]} withNotifiedObject:self];
            }
        }
            break;
        case FoodOperationType_share:
        {
            [_playerView pausePlay];
            
            bottomAlertView * alertV = [[bottomAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            [self.view.window addSubview:alertV];
            
            
            NSMutableDictionary * mShareInfo = [NSMutableDictionary dictionary];
            [mShareInfo setObject:self.channel_name forKey:@"channel_name"];
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
            
        default:
            break;
    }
}

#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    if (self.segmentC.selectIndex == 0) {
        self.pageIndex_foodMake = 1;
        self.pageIndex = 1;
    }else
    {
        self.pageIndex_arder = 1;
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
        self.pageIndex_arder++;
        self.pageIndex = self.pageIndex_arder;
    }
    [self startRequest];
}

- (void)startRequest
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestFoodMakeListWithInfo:@{@"command":@39,@"channel_name":self.channel_name,@"page_size":@(self.pageSize),@"page_index":@(self.pageIndex)} withNotifiedObject:self];
}

- (void)didRequestChannelListSuccessed
{
    [SVProgressHUD dismiss];
    [self.collectionView.mj_header endRefreshing];
    
    NSMutableArray * mArray = self.dataArray;
    NSArray * data = [[UserManager sharedManager] getFoodMakeList];
    
    // 点赞等操作
    if (self.currentSelectInfo) {
        if (data.count == 0) {
            [mArray removeObject:self.currentSelectInfo];
        }
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
        [mInfo setObject:[info objectForKey:@"tags"] forKey:@"content"];
        [mArray addObject:mInfo];
        
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

- (void)didRequestChannelListFailed:(NSString *)failedInfo
{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    self.currentSelectInfo = nil;
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


- (void)getCurrentpage_indexInfo{
    NSMutableArray * mArray = self.dataArray;
    NSInteger index = [mArray indexOfObject:self.currentSelectInfo];
    
    int pageIndex = index / self.pageSize + 1;
    
    [[UserManager sharedManager] didRequestFoodMakeListWithInfo:@{@"command":@39,@"channel_name":self.channel_name,@"page_size":@(self.pageSize),@"page_index":@(pageIndex)} withNotifiedObject:self];
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

@end
