//
//  StoreGoodFoodViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/5/8.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "StoreGoodFoodViewController.h"

#import "XishaFoodListCollectionViewCell.h"
#define kXishaFoodListCollectionViewCellID @"XishaFoodListCollectionViewCellID"
#import "ChooceStoreView.h"
#import "ContestDetailViewController.h"

#import "ClubActivityDetailViewController.h"
#import "StoreGoodFoodSearchViewController.h"
#import "CateDetailViewController.h"

#import "NoDataCollectionViewCell.h"
#define kNoDataCellID @"NoDataCollectionViewCellID"

//定义block
typedef BOOL(^RunloopBlock)(void);

@interface StoreGoodFoodViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UserModule_ChannelListProtocol,UserModule_ChannelDetailProtocol>

@property (nonatomic, strong)UICollectionView * collectionview;
@property (nonatomic, strong)UIButton * nomalBtn;
@property (nonatomic, strong)UIButton * saleCountBtn;
@property (nonatomic, strong)UIButton * priceBtn;
@property (nonatomic, assign)int sort;
@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;
@property (nonatomic, assign)int page_index_nomal;
@property (nonatomic, assign)int page_index_sale;
@property (nonatomic, assign)int page_index_price;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSMutableArray * dataArray_nomal;
@property (nonatomic, strong)NSMutableArray * dataArray_sale;
@property (nonatomic, strong)NSMutableArray * dataArray_price;
@property (nonatomic, strong)ChooceStoreView * chooceStoreView;

/** 数组  */
@property(nonatomic,strong)NSMutableArray * tasks;
/** 最大任务s */
@property(assign,nonatomic)NSUInteger maxQueueLength;

@end

@implementation StoreGoodFoodViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)dataArray_sale
{
    if (!_dataArray_sale) {
        _dataArray_sale = [NSMutableArray array];
    }
    return _dataArray_sale;
}

- (NSMutableArray *)dataArray_nomal
{
    if (!_dataArray_nomal) {
        _dataArray_nomal = [NSMutableArray array];
    }
    return _dataArray_nomal;
}
- (NSMutableArray *)dataArray_price
{
    if (!_dataArray_price) {
        _dataArray_price = [NSMutableArray array];
    }
    return _dataArray_price;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sort = 0;
    self.page_size = 10;
    self.page_index = 1;
    self.page_index_sale = 1;
    self.page_index_price = 1;
    self.page_index_nomal = 1;
//    [self addRunloopObserver];
//    self.maxQueueLength = 10;
//    _tasks = [NSMutableArray array];
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

- (void)navigationViewSetup
{
    self.navigationItem.title = @"店内美食";
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
}

- (void)refreshUI_iPhone
{
    UIView * view = [self topView];
    [self.view addSubview:view];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 70, kScreenWidth - 20, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 70) collectionViewLayout:layout];
    self.collectionview.backgroundColor = [UIColor clearColor];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    [self.collectionview registerClass:[XishaFoodListCollectionViewCell class] forCellWithReuseIdentifier:kXishaFoodListCollectionViewCellID];
    [self.collectionview registerClass:[NoDataCollectionViewCell class] forCellWithReuseIdentifier:kNoDataCellID];

    [self.view addSubview:self.collectionview];
    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    self.collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
}

- (UIView *)topView
{
    self.chooceStoreView = [[ChooceStoreView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , 34)];
    [self.view addSubview:self.chooceStoreView];
    [self.chooceStoreView hideStoreView];
    [self.chooceStoreView resetContent:@"搜索"];
    __weak typeof(self)weakSelf = self;
    
    self.chooceStoreView.searchFoodBlock = ^(NSDictionary *info) {
        NSLog(@"搜索");
        StoreGoodFoodSearchViewController * vc = [[StoreGoodFoodSearchViewController alloc]init];
        vc.channel_name = weakSelf.channel_name;
        vc.category_id = weakSelf.category_id;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    
    topView.frame = CGRectMake(0, 34, kScreenWidth, 35);
    
    float leftWidth = (topView.hd_width - 270) / 2;
    self.nomalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nomalBtn.frame = CGRectMake(leftWidth, 0, 90, topView.hd_height);
    self.nomalBtn.backgroundColor = [UIColor whiteColor];
    [self.nomalBtn setTitle:@"默认" forState:UIControlStateNormal];
    self.nomalBtn.titleLabel.font = kMainFont;
    [self.nomalBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [self.nomalBtn setTitleColor:kMainRedColor forState:UIControlStateSelected];
    [topView addSubview:self.nomalBtn];
    self.nomalBtn.selected = YES;
    
    self.saleCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saleCountBtn.frame = CGRectMake(CGRectGetMaxX(self.nomalBtn.frame), 0, 90, topView.hd_height);
    self.saleCountBtn.backgroundColor = [UIColor whiteColor];
    [self.saleCountBtn setTitle:@"最热" forState:UIControlStateNormal];
    self.saleCountBtn.titleLabel.font = kMainFont;
    [self.saleCountBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [self.saleCountBtn setTitleColor:kMainRedColor forState:UIControlStateSelected];
    [topView addSubview:self.saleCountBtn];
    
    self.priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.priceBtn.frame = CGRectMake(CGRectGetMaxX(self.saleCountBtn.frame), 0, 90, topView.hd_height);
    self.priceBtn.backgroundColor = [UIColor whiteColor];
    [self.priceBtn setTitle:@"最新" forState:UIControlStateNormal];
    self.priceBtn.titleLabel.font = kMainFont;
    [self.priceBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [self.priceBtn setTitleColor:kMainRedColor forState:UIControlStateSelected];
    
    [topView addSubview:self.priceBtn];
    
    [self.nomalBtn addTarget:self action:@selector(shaixuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.saleCountBtn addTarget:self action:@selector(shaixuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.priceBtn addTarget:self action:@selector(shaixuanAction:) forControlEvents:UIControlEventTouchUpInside];
    return topView;
}

- (void)shaixuanAction:(UIButton *)button
{
    if ([button isEqual:self.nomalBtn]) {
        self.sort = 0;
        self.nomalBtn.selected = YES;
        self.saleCountBtn.selected = NO;
        self.priceBtn.selected = NO;
        self.page_index = self.page_index_nomal;
    }else if ([button isEqual:self.saleCountBtn])
    {
        self.sort = 3;
        self.nomalBtn.selected = NO;
        self.saleCountBtn.selected = YES;
        self.priceBtn.selected = NO;
        self.page_index = self.page_index_sale;
    }else
    {
        self.sort = 2;
        self.nomalBtn.selected = NO;
        self.saleCountBtn.selected = NO;
        self.priceBtn.selected = YES;
        self.page_index = self.page_index_price;
    }
    [self startRequest];
}

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
    
    XishaFoodListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kXishaFoodListCollectionViewCellID forIndexPath:indexPath];
    [cell refreshUI:[self.dataArray objectAtIndex:indexPath.item]];
    NSDictionary * info = [self.dataArray objectAtIndex:indexPath.item];
    
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count == 0) {
        return CGSizeMake(collectionView.hd_width, collectionView.hd_height);
    }
    
    float width = (kScreenWidth - 30) / 2;
    if (IS_PAD) {
        width = (kScreenWidth - 50) / 4;
    }
    return CGSizeMake(width, width * 0.73 + 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count == 0) {
        return;
    }
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClubContestDetailWithInfo:@{@"command":@31,@"channel_name":self.channel_name,@"id":[self.dataArray[indexPath.row] objectForKey:@"id"]} withNotifiedObject:self];
}



+ (void)loadImage:(XishaFoodListCollectionViewCell *)cell andInfo:(NSDictionary *)info
{
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[info objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
}
#pragma mark - <关于RunLoop的方法>
//添加新的任务的方法!
-(void)addTask:(RunloopBlock)unit {
    
    [self.tasks addObject:unit];
    
    //判断一下 保证没有来得及显示的cell不会绘制图片!!
    if (self.tasks.count > self.maxQueueLength) {
        [self.tasks removeObjectAtIndex:0];
    }
    
    
}


//回调函数
static void Callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    //从数组里面取代码!! info 哥么就是 self
    StoreGoodFoodViewController * vc = (__bridge StoreGoodFoodViewController *)info;
    if (vc.tasks.count == 0) {
        return;
    }
    BOOL result = NO;
    while (result == NO && vc.tasks.count) {
        //取出任务
        RunloopBlock unit = vc.tasks.firstObject;
        //执行任务
        result = unit();
        //干掉第一个任务
        [vc.tasks removeObjectAtIndex:0];
    }
    
}

//这里面都是c语言的代码
-(void)addRunloopObserver{
    //获取当前RunLoop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    //定义一个上下文
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL,
    };
    //定义一个观察者
    static CFRunLoopObserverRef defaultModeObserver;
    //创建观察者
    defaultModeObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, NSIntegerMax - 999, &Callback, &context);
    //添加当前RunLoop的观察者
    CFRunLoopAddObserver(runloop, defaultModeObserver, kCFRunLoopDefaultMode);
    //C语言里面有Creat\new\copy 就需要 释放 ARC 管不了!!
    CFRelease(defaultModeObserver);
    
}



#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    switch (self.sort) {
        case 0:
        {
            self.page_index_nomal = 1;
            self.page_index = self.page_index_nomal;
        }
            break;
        case 3:
        {
            self.page_index_sale = 1;
            self.page_index = self.page_index_sale;
        }
            break;
        case 2:
        {
            self.page_index_price = 1;
            self.page_index = self.page_index_price;
        }
            break;
            
        default:
            break;
    }
    [self startRequest];
}

- (void)doNextPageQuestionRequest
{
    switch (self.sort) {
        case 0:
        {
            self.page_index_nomal++;
            self.page_index = self.page_index_nomal;
        }
            break;
        case 3:
        {
            self.page_index_sale++;
            self.page_index = self.page_index_sale;
        }
            break;
        case 2:
        {
            self.page_index_price++;
            self.page_index = self.page_index_price;
        }
            break;
            
        default:
            break;
    }
    [self startRequest];
}

- (void)startRequest
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClubContextListWithInfo:@{@"command":@30,@"channel_name":self.channel_name,@"category_id":@(self.category_id),@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@(self.sort),@"is_red":@0} withNotifiedObject:self];
}

- (void)loadData
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClubContextListWithInfo:@{@"command":@30,@"channel_name":self.channel_name,@"category_id":@(self.category_id),@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"0",@"is_red":@0} withNotifiedObject:self];
}

#pragma mark - goosList request


- (void)didRequestChannelListSuccessed
{
    [SVProgressHUD dismiss];
    [self.collectionview.mj_header endRefreshing];
    
    switch (self.sort) {
        case 0:
        {
            if (self.page_index_nomal == 1) {
                [self.dataArray_nomal removeAllObjects];
            }
            for (NSDictionary * info in [[UserManager sharedManager] getclubContextList]) {
                NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
                [self.dataArray_nomal addObject:mInfo];
            }
            if ([[UserManager sharedManager] getClubContextListTotalCount] <= self.dataArray_nomal.count) {
                [self.collectionview.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.collectionview.mj_footer endRefreshing];
            }
            
            self.dataArray = self.dataArray_nomal;
        }
            break;
        case 3:
        {
            if (self.page_index_nomal == 1) {
                [self.dataArray_sale removeAllObjects];
            }
            for (NSDictionary * info in [[UserManager sharedManager] getclubContextList]) {
                NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
                [self.dataArray_sale addObject:mInfo];
            }
            
            if ([[UserManager sharedManager] getClubContextListTotalCount] <= self.dataArray_sale.count) {
                [self.collectionview.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.collectionview.mj_footer endRefreshing];
            }
            self.dataArray = self.dataArray_sale;
        }
            break;
        case 2:
        {
            if (self.page_index_nomal == 1) {
                [self.dataArray_price removeAllObjects];
            }
            for (NSDictionary * info in [[UserManager sharedManager] getclubContextList]) {
                NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
                [self.dataArray_price addObject:mInfo];
            }
            if ([[UserManager sharedManager] getClubContextListTotalCount] <= self.dataArray_price.count) {
                [self.collectionview.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.collectionview.mj_footer endRefreshing];
            }
            self.dataArray = self.dataArray_price;
        }
            break;
            
        default:
            break;
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
    CateDetailViewController * vc = [[CateDetailViewController alloc]init];
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
