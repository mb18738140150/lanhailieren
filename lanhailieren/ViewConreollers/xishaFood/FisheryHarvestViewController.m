//
//  FisheryHarvestViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/20.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "FisheryHarvestViewController.h"
#import "FisheryHarvestTableViewCell.h"
#define kFisheryHarvestTableViewCellID @"FisheryHarvestTableViewCellID"
#define kPageIndex @"pageIndex"
#define kPageSize @"pageSize"
#define kFisheryHarvestNotify @"FisheryHarvestNotify"
#import "FisheryHarvestDetailViewController.h"
#import "XishaSearchFisheryHarvestViewController.h"

#import "NoDataTableViewCell.h"
#define kNoDataCellID @"NoDataTableViewCellID"

//定义block
typedef BOOL(^RunloopBlock)(void);

@interface FisheryHarvestViewController ()<UserModule_OrderListProtocol,UserModule_ChannelListProtocol,UserModule_ChannelDetailProtocol>

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

@implementation FisheryHarvestViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(entertainmentOperation:) name:kFisheryHarvestNotify object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderStateSelect:) name:kNotificationOfOrderStateSelect object:nil];
    
    
    [self navigationViewSetup];
//    self.view.backgroundColor = [UIColor redColor];
    
    [self refreshUI_iPhone];
    [self loadData];
    for (int i = 0; i < self.viewArray.count; i++) {
        FisheryHarvestItemView * view = [self.viewArray objectAtIndex:i];
        view.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
        view.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
    }
    
    __weak typeof(self)weakSelf = self;
    self.pageView.currentIndexBlock = ^(NSInteger index) {
        weakSelf.currentIndex = index;
        
        NSArray * categoryArray = [[UserManager sharedManager] getFisheryHarvestCategoryList];
        if (categoryArray.count > index) {
            weakSelf.categoryID = [[categoryArray[index] objectForKey:@"id"] intValue];
        }
        FisheryHarvestItemView * view = [weakSelf.viewArray objectAtIndex:weakSelf.currentIndex];
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
    [[UserManager sharedManager] didRequestFisheryHarvestListWithInfo:@{@"command":@30,@"channel_name":@"fish",@"category_id":@(self.categoryID),@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@"0",@"is_red":@0} withNotifiedObject:self];
}

- (void)didRequestChannelListSuccessed
{
    [SVProgressHUD dismiss];
    FisheryHarvestItemView * view = [self.viewArray objectAtIndex:self.currentIndex];
    [view.tableView.mj_header endRefreshing];
    
    NSMutableArray * mArray = [self.dataSource objectAtIndex:self.currentIndex];
    NSMutableDictionary * mInfo = [self.pageIndexArray objectAtIndex:self.currentIndex];
    int pageIndex = [[mInfo objectForKey:kPageIndex] intValue];
    if (pageIndex == 1) {
        [mArray removeAllObjects];
    }
    
    if ([[UserManager sharedManager] getFisheryHarvestListTotalCount] <= view.dataSource.count) {
        [view.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }else
    {
        [view.tableView.mj_footer endRefreshing];
    }
    
    
    NSArray * data = [[UserManager sharedManager] getFisheryHarvestList];
    for (NSDictionary * info in data) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [mInfo setObject:[info objectForKey:@"tags"] forKey:@"content"];
        [mInfo setObject:[info objectForKey:@"title"] forKey:@"content"];
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
    FisheryHarvestItemView * view = [self.viewArray objectAtIndex:self.currentIndex];
    [view.tableView.mj_header endRefreshing];
    [view.tableView.mj_footer endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
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
        XishaSearchFisheryHarvestViewController * vc = [[XishaSearchFisheryHarvestViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    [self pageView];
    
}

- (EScrollPageView *)pageView{
    if (_pageView == nil) {
        CGFloat statusBarH = ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0);
        //每一项的view子类需要继承EScrollPageItemBaseView实现相关界面
//        NSArray * categoryArray = [[UserManager sharedManager] getXishaFoodCategoryList];
//        NSMutableArray * vs = [NSMutableArray array];
//        [self.pageIndexArray removeAllObjects];
//        for (NSDictionary * info in categoryArray) {
//            EScrollPageItemBaseView *v1 = [[FisheryHarvestItemView alloc] initWithPageTitle:[info objectForKey:@"title"]];
//            [vs addObject:v1];
//            NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
//            [mInfo setObject:kPageSize forKey:@10];
//            [mInfo setObject:kPageIndex forKey:@1];
//            [self.pageIndexArray addObject:mInfo];
//        }
        
        NSArray * categoryArray = [[UserManager sharedManager] getFisheryHarvestCategoryList];
        if (categoryArray.count > 0) {
            self.categoryID = [[categoryArray[0] objectForKey:@"id"] intValue];
            self.page_size = 15;
            self.page_index = 1;
        }
        
        NSMutableArray * vs = [NSMutableArray array];
        [self.pageIndexArray removeAllObjects];
        [self.dataSource removeAllObjects];
        for (NSDictionary * info in categoryArray) {
            EScrollPageItemBaseView *v1 = [[FisheryHarvestItemView alloc] initWithPageTitle:[info objectForKey:@"title"]];
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
        param.segmentParam.itemWidth = 60;
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
    [[UserManager sharedManager] didRequestClubContestDetailWithInfo:@{@"command":@31,@"channel_name":@"fish",@"id":[info objectForKey:@"id"]} withNotifiedObject:self];
    
}

- (void)didRequestChannelDetailSuccessed
{
    [SVProgressHUD dismiss];
    
    NSDictionary * info = [[UserManager sharedManager] getClubContestDetail];
    
    NSMutableArray * speciArray = [NSMutableArray array];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0x000000)};
    for (NSString * key in [info allKeys]) {
        if ([key isEqualToString:@"category_name"]) {
            
            NSString * str = [NSString stringWithFormat:@"%@：%@", @"分类名称",[info objectForKey:key]];
            
            NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
            [mStr addAttributes:attribute range:NSMakeRange(4, str.length - 4)];
            
            [speciArray addObject:mStr];
            break;
        }
    }
    
    for (NSString * key in [info allKeys]) {
        if ([key isEqualToString:@"place"]) {
            
            NSString * str = [NSString stringWithFormat:@"%@：%@", @"产地",[info objectForKey:key]];
            NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
            [mStr addAttributes:attribute range:NSMakeRange(2, str.length - 2)];
            
            [speciArray addObject:mStr];
            break;
        }
    }
    
    for (NSString * key in [info allKeys]) {
        
        if ([key isEqualToString:@"eat_way"]) {
            
            NSString * str = [NSString stringWithFormat:@"%@：%@", @"食用方式",[info objectForKey:key]];
            NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
            [mStr addAttributes:attribute range:NSMakeRange(4, str.length - 4)];
            
            [speciArray addObject:mStr];
            break;
        }
        
    }
    
    NSMutableDictionary * mInfo = [NSMutableDictionary dictionaryWithDictionary:info];
    [mInfo setObject:speciArray forKey:@"speciArray"];
    
    FisheryHarvestDetailViewController * vc = [[FisheryHarvestDetailViewController alloc]init];
    vc.infoDic = mInfo;
    [self.navigationController pushViewController:vc animated:YES];
    
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

@interface FisheryHarvestItemView()

/** 数组  */
@property(nonatomic,strong)NSMutableArray * tasks;
/** 最大任务s */
@property(assign,nonatomic)NSUInteger maxQueueLength;

@end

@implementation FisheryHarvestItemView

- (void)didAppeared{
    
    self.maxQueueLength = 5;
    [self addRunloopObserver];
    [self tableView];
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        
        
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        [_tableView registerClass:[FisheryHarvestTableViewCell class] forCellReuseIdentifier:kFisheryHarvestTableViewCellID];
        [_tableView registerClass:[NoDataTableViewCell class] forCellReuseIdentifier:kNoDataCellID];

        [self addSubview:_tableView];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.dataSource.count == 0) {
        return 1;;
    }
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == 0) {
        NoDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kNoDataCellID forIndexPath:indexPath];
        [cell refreshUI];
        
        return cell;
    }
    
    FisheryHarvestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kFisheryHarvestTableViewCellID forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary * info = [self.dataSource objectAtIndex:indexPath.row] ;
    __weak typeof(self)weakSelf = self;
    __weak typeof(cell)wealCell = cell;
    
    [cell refreshUIWithInfo:info];
    
//    [self addTask:^BOOL{
//
//        [FisheryHarvestItemView loadImage:cell andInfo:info];
//        return YES;
//    }];
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == 0) {
        return tableView.hd_height;
    }
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == 0) {
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kFisheryHarvestNotify object:self.dataSource[indexPath.row]];
}


+ (void)loadImage:(FisheryHarvestTableViewCell *)cell andInfo:(NSDictionary *)info
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
    FisheryHarvestItemView * vc = (__bridge FisheryHarvestItemView *)info;
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



@end
