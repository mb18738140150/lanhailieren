//
//  SearchEntertainmentResultViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/5/6.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "SearchEntertainmentResultViewController.h"

#import "MyCollectionCollectionViewCell.h"
#define kMyCollectionCollectionViewCellID @"MyCollectionCollectionViewCellID"
#import "CLPlayerView.h"
#define kPageIndex @"pageIndex"
#define kPageSize @"pageSize"
#import "CLPlayerView.h"
#import "FoodMakeCommentDetailViewController.h"
#import "CustomView.h"
#import "NoDataCollectionViewCell.h"
#define kNoDataCellID @"NoDataCollectionViewCellID"
#import "bottomAlertView.h"
@interface SearchEntertainmentResultViewController ()<UserModule_ChannelListProtocol,UserModule_GoodProtocol,UserModule_CollectProtocol,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)NSMutableArray * dataSource;
@property(nonatomic,retain)UICollectionView *tableView;
@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;

@property (nonatomic, weak) CLPlayerView *playerView;
@property (nonatomic, assign)MyCollectionCollectionViewCell * cell;// 记录cell
@property (nonatomic,  strong)NSDictionary * currentSelectInfo;// 当前选中分类下具体item

@end

@implementation SearchEntertainmentResultViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.page_size = 10;
    self.page_index = 1;
    [self navigationViewSetup];
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBarItem];
}

- (void)backAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UICollectionView *)tableView{
    if (_tableView == nil) {
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
        
        _tableView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        [_tableView registerClass:[MyCollectionCollectionViewCell class] forCellWithReuseIdentifier:kMyCollectionCollectionViewCellID];
        [_tableView registerClass:[NoDataCollectionViewCell class] forCellWithReuseIdentifier:kNoDataCellID];

        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
        
        [self.view addSubview:_tableView];
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

- (void)foodOperation:(NSDictionary *)info1
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
            [[UserManager sharedManager] didRequestDianzanDetailWithInfo:@{@"command":@36,@"channel_name":self.channelName,@"article_id":[info objectForKey:@"id"],@"click_type":@2} withNotifiedObject:self];
        }
            break;
        case FoodOperationType_Comment:
        {
            [_playerView destroyPlayer];
            FoodMakeCommentDetailViewController * vc = [[FoodMakeCommentDetailViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.channel_name = self.channelName;
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
                [[UserManager sharedManager] didRequestCollectDetailWithInfo:@{@"command":@35,@"channel_name":self.channelName,@"article_id":[info objectForKey:@"id"]} withNotifiedObject:self];
            }else
            {
                [[UserManager sharedManager] didRequestCollectDetailWithInfo:@{@"command":@34,@"channel_name":self.channelName,@"article_id":[info objectForKey:@"id"]} withNotifiedObject:self];
            }
        }
            break;
        case FoodOperationType_share:
        {
            [_playerView pausePlay];
            
            bottomAlertView * alertV = [[bottomAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            [self.view.window addSubview:alertV];
            
            
            NSMutableDictionary * mShareInfo = [NSMutableDictionary dictionary];
            [mShareInfo setObject:self.channelName forKey:@"channel_name"];
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
            [self showCustomMadeView:info];
            [_playerView pausePlay];
        }
            break;
            
        default:
            break;
    }
}

- (void)showCustomMadeView:(NSDictionary *)info
{
    CustomView * customView = [[CustomView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:customView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [[UserManager sharedManager] didRequestFoodMakeListWithInfo:@{@"command":@30,@"channel_name":self.channelName,@"category_id":@(0),@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":self.key,@"sort":@"0",@"is_red":@0} withNotifiedObject:self];
}

- (void)didRequestChannelListSuccessed
{
    [SVProgressHUD dismiss];
    [self.tableView.mj_header endRefreshing];
    NSMutableArray * mArray = self.dataSource;
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
        self.dataSource = mArray;
        [self.tableView reloadData];
        self.currentSelectInfo = nil;
        return;
    }
    
    if (self.page_index == 1) {
        [mArray removeAllObjects];
    }
    
    for (NSDictionary * info in data) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [mInfo setObject:[info objectForKey:@"tags"] forKey:@"content"];
        [mArray addObject:mInfo];
        
    }
    
    self.dataSource = mArray;
    [self.tableView reloadData];
    
    if ([[UserManager sharedManager] getFoodMakeListTotalCount] <= self.dataSource.count) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }else
    {
        [self.tableView.mj_footer endRefreshing];
    }
    
}

- (void)didRequestChannelListFailed:(NSString *)failedInfo
{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
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
    NSMutableArray * mArray = self.dataSource;
    NSInteger index = [mArray indexOfObject:self.currentSelectInfo];
    
    int pageIndex = index / self.page_size + 1;
    
    [[UserManager sharedManager] didRequestFoodMakeListWithInfo:@{@"command":@30,@"channel_name":self.channelName,@"category_id":@(0),@"page_size":@(self.page_size),@"page_index":@(pageIndex),@"key":self.key,@"sort":@"0",@"is_red":@0} withNotifiedObject:self];
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
