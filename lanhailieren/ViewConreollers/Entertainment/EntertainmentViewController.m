//
//  EntertainmentViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/16.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "EntertainmentViewController.h"
#import "MyCollectionCollectionViewCell.h"
#define kMyCollectionCollectionViewCellID @"MyCollectionCollectionViewCellID"
#import "CLPlayerView.h"
#define kPageIndex @"pageIndex"
#define kPageSize @"pageSize"
#import "CLPlayerView.h"
#import "ChooceStoreView.h"
#define kEntertainmentOperationNotify @"entertainmentOperationNotify"
#import "SearchEntertainmentViewController.h"
#import "FoodMakeCommentDetailViewController.h"
#import "bottomAlertView.h"
#import "Constant.h"

#import "NoDataCollectionViewCell.h"
#define kNoDataCellID @"NoDataCollectionViewCellID"

@interface EntertainmentViewController ()<UserModule_OrderListProtocol,UserModule_ChannelListProtocol,UserModule_GoodProtocol,UserModule_CollectProtocol>

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

@property (nonatomic,  strong)NSDictionary * currentSelectInfo;// 当前选中分类下具体item

@end

@implementation EntertainmentViewController
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

- (void)showCategory
{
    if (_pageView == nil) {
        [self pageView];
        for (int i = 0; i < self.viewArray.count; i++) {
            EntertainmentItemView * view = [self.viewArray objectAtIndex:i];
            view.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
            view.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
            
        }
        
        __weak typeof(self)weakSelf = self;
           self.pageView.currentIndexBlock = ^(NSInteger index) {
               [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfAederVideoStopPlay object:nil];
               weakSelf.currentIndex = index;
               NSArray * categoryArray = [[UserManager sharedManager] getArderCategoryList];
               if (categoryArray.count > index) {
                   weakSelf.categoryID = [[categoryArray[index] objectForKey:@"id"] intValue];
               }
               EntertainmentItemView * view = [weakSelf.viewArray objectAtIndex:weakSelf.currentIndex];
               if (view.dataSource.count == 0) {
                   [weakSelf startRequest];
               }
           };
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(entertainmentOperation:) name:kEntertainmentOperationNotify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlay:) name:kNotificationOfAederVideoStopPlay object:nil];
    
    self.haveLoad = YES;
    
    [self navigationViewSetup];
//    self.view.backgroundColor = [UIColor redColor];
    
    [self refreshUI_iPhone];
    [self loadData];
    for (int i = 0; i < self.viewArray.count; i++) {
        EntertainmentItemView * view = [self.viewArray objectAtIndex:i];
        view.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
        view.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
        
    }
    
    __weak typeof(self)weakSelf = self;
    self.pageView.currentIndexBlock = ^(NSInteger index) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfAederVideoStopPlay object:nil];
        weakSelf.currentIndex = index;
        NSArray * categoryArray = [[UserManager sharedManager] getArderCategoryList];
        if (categoryArray.count > index) {
            weakSelf.categoryID = [[categoryArray[index] objectForKey:@"id"] intValue];
        }
        EntertainmentItemView * view = [weakSelf.viewArray objectAtIndex:weakSelf.currentIndex];
        if (view.dataSource.count == 0) {
            [weakSelf startRequest];
        }
    };
}

- (void)loadData
{
    [self startRequest];
}


- (void)navigationViewSetup
{
    self.navigationItem.title = @"休闲娱乐";
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kCommonMainTextColor_50};
    TeamHitBarButtonItem * leftBarItem = [TeamHitBarButtonItem leftButtonWithImage:[UIImage imageNamed:@"public-返回"] title:@""];
    [leftBarItem addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBarItem];
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
        SearchEntertainmentViewController * vc = [[SearchEntertainmentViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    [self pageView];
    
}

- (EScrollPageView *)pageView{
    if (_pageView == nil) {
        CGFloat statusBarH = ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0);
        //每一项的view子类需要继承EScrollPageItemBaseView实现相关界面
//        NSArray * categoryArray = [[UserManager sharedManager] getArderCategoryList];
//        NSMutableArray * vs = [NSMutableArray array];
//        [self.pageIndexArray removeAllObjects];
//        for (NSDictionary * info in categoryArray) {
//            EScrollPageItemBaseView *v1 = [[EntertainmentItemView alloc] initWithPageTitle:[info objectForKey:@"title"]];
//            [vs addObject:v1];
//            NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
//            [mInfo setObject:kPageSize forKey:@10];
//            [mInfo setObject:kPageIndex forKey:@1];
//            [self.pageIndexArray addObject:mInfo];
//        }

        NSArray * categoryArray = [[UserManager sharedManager] getArderCategoryList];
        if (categoryArray.count > 0) {
            self.categoryID = [[categoryArray[0] objectForKey:@"id"] intValue];
            self.page_size = 10;
            self.page_index = 1;
        }
        
        NSMutableArray * vs = [NSMutableArray array];
        [self.pageIndexArray removeAllObjects];
        [self.dataSource removeAllObjects];
        for (NSDictionary * info in categoryArray) {
            EScrollPageItemBaseView *v1 = [[EntertainmentItemView alloc] initWithPageTitle:[info objectForKey:@"title"]];
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
        param.segmentParam.type = EPageContentLeft;
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

- (void)stopPlay:(NSNotification *)nitification
{
    if(self.viewArray.count == 0)
    {
        return;
    }
    EntertainmentItemView * view = [self.viewArray objectAtIndex:self.currentIndex];
    [view stopPlay];
}

- (void)entertainmentOperation:(NSNotification *)notification
{
    NSDictionary * info1 = notification.object;
    NSDictionary * info = [info1 objectForKey:@"info"];
    self.currentSelectInfo = info;
    switch ([[info1 objectForKey:@"type"] intValue]) {
        case FoodOperationType_good:
        {
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestDianzanDetailWithInfo:@{@"command":@36,@"channel_name":@"arder",@"article_id":[info objectForKey:@"id"],@"click_type":@2} withNotifiedObject:self];
        }
            break;
        case FoodOperationType_Comment:
        {
            FoodMakeCommentDetailViewController * vc = [[FoodMakeCommentDetailViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.channel_name = @"arder";
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
                [[UserManager sharedManager] didRequestCollectDetailWithInfo:@{@"command":@35,@"channel_name":@"arder",@"article_id":[info objectForKey:@"id"]} withNotifiedObject:self];
            }else
            {
                [[UserManager sharedManager] didRequestCollectDetailWithInfo:@{@"command":@34,@"channel_name":@"arder",@"article_id":[info objectForKey:@"id"]} withNotifiedObject:self];
            }
            
        }
            break;
        case FoodOperationType_share:
        {
            bottomAlertView * alertV = [[bottomAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            [self.view.window addSubview:alertV];
            
            
            NSMutableDictionary * mShareInfo = [NSMutableDictionary dictionary];
            [mShareInfo setObject:@"arder" forKey:@"channel_name"];
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
//            [self showCustomMadeView:info];
        }
            break;
            
        default:
            break;
    }
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
    [[UserManager sharedManager] didRequestFoodMakeListWithInfo:@{@"command":@30,@"channel_name":@"arder",@"category_id":@(self.categoryID),@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"0",@"is_red":@0} withNotifiedObject:self];
}

- (void)didRequestChannelListSuccessed
{
    [SVProgressHUD dismiss];
    EntertainmentItemView * view = [self.viewArray objectAtIndex:self.currentIndex];
    [view.tableView.mj_header endRefreshing];
    
    NSMutableArray * mArray = [self.dataSource objectAtIndex:self.currentIndex];
    NSArray * data = [[UserManager sharedManager] getFoodMakeList];
    
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
        view.dataSource = mArray;
        [view.tableView reloadData];
        self.currentSelectInfo = nil;
        return;
    }
    
    NSMutableDictionary * mInfo = [self.pageIndexArray objectAtIndex:self.currentIndex];
    int pageIndex = [[mInfo objectForKey:kPageIndex] intValue];
    if (pageIndex == 1) {
        [mArray removeAllObjects];
    }
    
    for (NSDictionary * info in data) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [mInfo setObject:[info objectForKey:@"tags"] forKey:@"content"];
        [mArray addObject:mInfo];
        
    }
    
    view.dataSource = mArray;
    [view.tableView reloadData];
    
    if ([[UserManager sharedManager] getFoodMakeListTotalCount] <= view.dataSource.count) {
        [view.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }else
    {
        [view.tableView.mj_footer endRefreshing];
    }
    
    
}

- (void)didRequestChannelListFailed:(NSString *)failedInfo
{
    if(self.viewArray.count == 0)
    {
        return;
    }
    EntertainmentItemView * view = [self.viewArray objectAtIndex:self.currentIndex];
    [view.tableView.mj_header endRefreshing];
    [view.tableView.mj_footer endRefreshing];
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
    NSMutableArray * mArray = [self.dataSource objectAtIndex:self.currentIndex];
    NSInteger index = [mArray indexOfObject:self.currentSelectInfo];
    
    int pageIndex = index / self.page_size + 1;
    
    [[UserManager sharedManager] didRequestFoodMakeListWithInfo:@{@"command":@30,@"channel_name":@"arder",@"category_id":@(self.categoryID),@"page_size":@(self.page_size),@"page_index":@(pageIndex),@"key":@"",@"sort":@"0",@"is_red":@0} withNotifiedObject:self];
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


@interface EntertainmentItemView()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) CLPlayerView *playerView;
@property (nonatomic, assign)MyCollectionCollectionViewCell * cell;// 记录cell

@end

@implementation EntertainmentItemView

- (void)stopPlay
{
    [_playerView destroyPlayer];
}

- (void)didAppeared{
    [self tableView];
}
- (UICollectionView *)tableView{
    if (_tableView == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        if (IS_PAD) {
            CGFloat itemWidth = kScreenWidth / 2 - 1;
            CGFloat imageWidth = (itemWidth - 15);
            layout.itemSize = CGSizeMake(itemWidth, imageWidth * 0.48 + 55);
        }else
        {
            CGFloat imageWidth = (kScreenWidth - 20);
            layout.itemSize = CGSizeMake(kScreenWidth, imageWidth * 0.41 + 40);
        }
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _tableView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        [_tableView registerClass:[MyCollectionCollectionViewCell class] forCellWithReuseIdentifier:kMyCollectionCollectionViewCellID];
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
    
    MyCollectionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyCollectionCollectionViewCellID forIndexPath:indexPath];
    NSDictionary * info = [self.dataSource objectAtIndex:indexPath.row] ;
    __weak typeof(self)weakSelf = self;
    __weak typeof(cell)wealCell = cell;
    
    [cell refreshUI:info];
    cell.playBlock = ^(NSDictionary * _Nonnull info) {
        [weakSelf cl_tableViewCellPlayVideoWithCell:wealCell];
    };
    
    cell.goodBlock = ^(NSDictionary * _Nonnull info) {
        NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
        [mInfo setObject:info forKey:@"info"];
        [mInfo setObject:@(FoodOperationType_good) forKey:@"type"];
        [weakSelf postNotification:mInfo];
        NSLog(@"good");
    };
    cell.commentBlock = ^(NSDictionary * _Nonnull info) {
        NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
        [mInfo setObject:info forKey:@"info"];
        [mInfo setObject:@(FoodOperationType_Comment) forKey:@"type"];
        [weakSelf postNotification:mInfo];
        [weakSelf.playerView destroyPlayer];
        NSLog(@"good");
    };
    cell.collectBlock = ^(NSDictionary * _Nonnull info) {
        NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
        [mInfo setObject:info forKey:@"info"];
        [mInfo setObject:@(FoodOperationType_collection) forKey:@"type"];
        [weakSelf postNotification:mInfo];
        NSLog(@"good");
    };
    cell.shareBlock = ^(NSDictionary * _Nonnull info) {
        NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
        [mInfo setObject:info forKey:@"info"];
        [mInfo setObject:@(FoodOperationType_share) forKey:@"type"];
        [weakSelf postNotification:mInfo];
        [weakSelf.playerView pausePlay];
        NSLog(@"good");
    };
    
    return cell;
}

- (void)postNotification:(NSDictionary *)info
{
    if (![[UserManager sharedManager] isUserLogin]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfLoginClick object:nil];
        return;
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:kEntertainmentOperationNotify object:info];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == 0) {
        return CGSizeMake(collectionView.hd_width, collectionView.hd_height);
    }
    else
    {
        if (IS_PAD) {
            CGFloat itemWidth = kScreenWidth / 2 - 1;
            CGFloat imageWidth = (itemWidth - 15);
            return CGSizeMake(itemWidth, imageWidth * 0.48 + 55);
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


@end
