//
//  StoreListViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/15.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "StoreListViewController.h"
#import "StoreListTableViewCell.h"
#define kStoreListTableViewCellID @"StoreListTableViewCellID"
#import "StoreAddressChoseCollectionViewCell.h"
#define kStoreAddressChoseCollectionViewCellID @"StoreAddressChoseCollectionViewCellID"
#import "ProvinceModel.h"
#import "CityModel.h"
#define kTime 0.3
#import "VRImageViewController.h"
#import "ScanSuccessJumpVC.h"

#import "NoDataTableViewCell.h"
#define kNoDataCellID @"NoDataTableViewCellID"

@interface StoreListViewController ()<UITableViewDelegate,UITableViewDataSource,UserModule_StoreListProtocol,UICollectionViewDelegate,UICollectionViewDataSource,UserModule_StoreListProtocol>

@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)NSString * currentKey;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong) UITableView * addressTableView;
@property (nonatomic, strong) UIView        *livingBackView;
@property (nonatomic, assign)CGFloat teachertableviewheight;
@property (nonatomic, strong)NSMutableArray * addressArray;
@property (nonatomic, strong)NSIndexPath * currentCollectionIndexPath;
@property (nonatomic, strong)NSString * currentProvince;
@property (nonatomic, strong)NSString * currentCity;
@property (nonatomic, strong)NSString * currentArea;

@property (nonatomic, strong)NSIndexPath * currentProvinceIndexPath;
@property (nonatomic, strong)NSIndexPath * currentCityIndexPath;
@property (nonatomic, strong)NSIndexPath * currentAreaIndexPath;
@property (nonatomic, strong) NSMutableArray *provinceArray;//全国地市数据源（全局）
@end

@implementation StoreListViewController

- (NSMutableArray *)addressArray
{
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

- (NSMutableArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray  = [NSMutableArray array];
    }
    return _provinceArray;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRequestData];
    self.view.backgroundColor = [UIColor clearColor];
    [self loadData];
    [self navigationViewSetup];
//    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.hd_width, 5)];
//    seperateView.backgroundColor = UIColorFromRGB(0xf5f5f5);
//    [self.view addSubview:seperateView];
    
    [self refreshUI_iPhone];
}
- (void)navigationViewSetup
{
    self.navigationItem.title = @"门店列表";
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
- (void)loadData
{
    self.currentProvince = @"";
    self.currentCity = @"";
    self.currentArea = @"";
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestStoreListWith:@{@"command":@13,@"key":@""} withNotifiedObject:self];
    
}

- (void)refreshUI_iPhone
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreenWidth / 3, 44);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[StoreAddressChoseCollectionViewCell class] forCellWithReuseIdentifier:kStoreAddressChoseCollectionViewCellID];
//    [self.view addSubview:self.collectionView];
    
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, 3)];
    seperateView.backgroundColor = UIColorFromRGB(0xe4e5e1);
//    [self.view addSubview:seperateView];
    
    self.livingBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 47, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - 47)];
    self.livingBackView.backgroundColor = [UIColor colorWithWhite:.4 alpha:.1];
    
    UITapGestureRecognizer * livingTip = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideLiving)];
    [self.livingBackView addGestureRecognizer:livingTip];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 0) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[StoreListTableViewCell class] forCellReuseIdentifier:kStoreListTableViewCellID];
    [self.tableview registerClass:[NoDataTableViewCell class] forCellReuseIdentifier:kNoDataCellID];

    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = [UIColor clearColor];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    
//    [self.view addSubview:self.livingBackView];
//    [self.view addSubview:self.addressTableView];
}

#pragma mark - 解析json
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData  * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    if(error) {
        return nil;
    }
    return dic;
}
// 获取地址信息
- (void)loadRequestData{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    NSError *error;
    NSString *fileString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        return;
    }
    NSDictionary *dicData = [self dictionaryWithJsonString:fileString];
    if (!dicData) {
        return;
    }
    //    省级数组
    NSArray *arrayCityList = [dicData objectForKey:@"citylist"];
    
    for (NSDictionary *provinceDic in arrayCityList) {
        ProvinceModel *provinceModel = [[ProvinceModel alloc]initWithDictionary:provinceDic];
        [self.provinceArray addObject:provinceModel];
    }
}

#pragma mark - collection delegate & datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoreAddressChoseCollectionViewCell * storeCell = [collectionView dequeueReusableCellWithReuseIdentifier:kStoreAddressChoseCollectionViewCellID forIndexPath:indexPath];
    if (indexPath.row == 0) {
        if (self.currentProvinceIndexPath == nil || self.currentProvince.length == 0) {
            [storeCell refreshUIWith:@{@"title":@"省份"}];
        }else
        {
            [storeCell refreshUIWith:@{@"title":self.currentProvince}];
        }
    }
    if (indexPath.row == 1) {
        if (self.currentCityIndexPath == nil || self.currentCity.length == 0) {
            [storeCell refreshUIWith:@{@"title":@"城市"}];
        }else
        {
            [storeCell refreshUIWith:@{@"title":self.currentCity}];
        }
    }
    if (indexPath.row == 2) {
        if (self.currentAreaIndexPath == nil || self.currentArea.length == 0) {
            [storeCell refreshUIWith:@{@"title":@"区"}];
        }else
        {
            [storeCell refreshUIWith:@{@"title":self.currentArea}];
        }
    }
    if (self.currentCollectionIndexPath.row == indexPath.row) {
        [storeCell resetState:YES];
    }
    return storeCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.addressArray removeAllObjects];
    if (indexPath.row == 0) {
        for (ProvinceModel * p in self.provinceArray) {
            [self.addressArray addObject:p.province];
        }
    }else if (indexPath.row == 1)
    {
        ProvinceModel * p = self.provinceArray[self.currentProvinceIndexPath.row];
        CityArrayModel * cArrayModel = p.citiesListModel;
        for (CityModel * cModel in cArrayModel.citiesArray) {
            [self.addressArray addObject:cModel.city];
        }
        
    }else if (indexPath.row == 2)
    {
        ProvinceModel * p = self.provinceArray[self.currentProvinceIndexPath.row];
        CityArrayModel * cArrayModel = p.citiesListModel;
        CityModel * cModel = cArrayModel.citiesArray[self.currentCityIndexPath.row];
        for (NSString * area in cModel.areaListArray) {
            [self.addressArray addObject:area];
        }
    }
    
    self.addressTableView.frame = CGRectMake(kScreenWidth / 3, 47, kScreenWidth / 3 , (self.addressArray.count + 1) * 40.0) ;
    self.teachertableviewheight = (self.addressArray.count) * 40.0;
    self.teachertableviewheight = self.teachertableviewheight > (kScreenHeight - kNavigationBarHeight - kTabBarHeight - 47) ? (kScreenHeight - kNavigationBarHeight - kTabBarHeight - 50) : self.teachertableviewheight;
    
    [self.addressTableView reloadData];
    
    if (indexPath.row == self.currentCollectionIndexPath.row) {
        if (self.addressTableView.hidden) {
            [self showTeacherTableview:YES];
        }else
        {
            [self showTeacherTableview:NO];
        }
        return;
    }
    [self showTeacherTableview:NO];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.currentCollectionIndexPath = indexPath;
        
        if (self.addressTableView.hidden) {
            
            [self showTeacherTableview:YES];
        }else
        {
            [self showTeacherTableview:NO];
        }
    });
    
}
- (void)showTeacherTableview:(BOOL)isShow
{
    CGFloat tableX = kScreenWidth / 3 * self.currentCollectionIndexPath.row;
    if (isShow) {
        [self.livingBackView setHidden:NO];
        [self.addressTableView setHidden:NO];
        self.addressTableView.frame = CGRectMake(tableX , 47, kScreenWidth / 3 , 0);
        
        [UIView animateWithDuration:kTime animations:^{
            self.addressTableView.frame = CGRectMake(tableX, 47, kScreenWidth / 3 , self.teachertableviewheight);
        } completion:^(BOOL finished) {
            
        }];
        
    }else
    {
        [self.livingBackView setHidden:NO];
        self.addressTableView.frame = CGRectMake(tableX, 47, kScreenWidth /3 , self.teachertableviewheight);
        
        [UIView animateWithDuration:kTime animations:^{
            self.addressTableView.frame = CGRectMake(tableX,47, kScreenWidth / 3 , 0);
        } completion:^(BOOL finished) {
            [self.addressTableView setHidden:YES];
            [self.livingBackView setHidden:YES];
        }];
    }
}
- (void)hideLiving
{
    [self hideLivingWithHide:YES];
}
- (void)hideLivingWithHide:(BOOL)isHide
{
    if (isHide) {
        self.addressTableView.hidden = YES;
        self.livingBackView.hidden = YES;
        return;
    }
    if (self.addressTableView.hidden) {
        return;
    }
}
#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestStoreListWith:@{@"command":@13,@"key":@""} withNotifiedObject:self];
}
#pragma mark - tableview delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource.count == 0) {
        return 1;
    }
    
    if ([tableView isEqual:self.addressTableView]) {
        return self.addressArray.count ;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if ([tableView isEqual:self.addressTableView]) {
//        UITableViewCell * cell = [UIUtility getCellWithCellName:@"cellID" inTableView:tableView andCellClass:[UITableViewCell class]];
//        cell.backgroundColor = [UIColor whiteColor];
//
//        if (![cell viewWithTag:1000]) {
//            UIView * lineVlew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth / 2, 1)];
//            lineVlew.backgroundColor = kTableViewCellSeparatorColor;
//            lineVlew.tag = 1000;
//            [cell addSubview:lineVlew];
//        }
//
//        cell.textLabel.text = [self.addressArray objectAtIndex:indexPath.row];
//
//        cell.textLabel.textAlignment = 1;
//        return cell;
//    }
    
    if (self.dataSource.count == 0) {
        NoDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kNoDataCellID forIndexPath:indexPath];
        [cell refreshUI];
        
        return cell;
    }
    
    StoreListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kStoreListTableViewCellID forIndexPath:indexPath];
    [cell refreshUIWithInfo:[self.dataSource objectAtIndex:indexPath.row]];
    __weak typeof(self)weakSelf = self;
    cell.checkVRBlock = ^(NSDictionary * _Nonnull info) {
        if ([info objectForKey:@"vr_url"] == nil || [[info objectForKey:@"vr_url"] length] == 0) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"暂无VR图片"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
        jumpVC.comeFromVC = ScanSuccessJumpComeFromWB;
        jumpVC.jump_URL = [info objectForKey:@"vr_url"];
        jumpVC.progressViewColor = kMainRedColor;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.navigationController pushViewController:jumpVC animated:YES];
        });
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == 0) {
           return tableView.hd_height;
       }
    
    if ([tableView isEqual:self.addressTableView]) {
        return 40;
    }
    return 87;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == 0) {
           return ;
       }
    
    if ([tableView isEqual:self.addressTableView]) {
        
        if (self.currentCollectionIndexPath.row == 0) {
            if (![self.currentProvince isEqualToString:self.addressArray[indexPath.row]]) {
                self.currentProvince = self.addressArray[indexPath.row];
                self.currentProvinceIndexPath = indexPath;
                
                self.currentCity = @"";
                self.currentArea = @"";
                self.currentCityIndexPath = nil;
                self.currentAreaIndexPath = nil;
            }
        }else if (self.currentCollectionIndexPath.row == 1)
        {
            if (![self.currentCity isEqualToString:self.addressArray[indexPath.row]]) {
                self.currentCity = self.addressArray[indexPath.row];
                self.currentCityIndexPath = indexPath;
                self.currentArea = @"";
                self.currentAreaIndexPath = nil;
            }
        }else if (self.currentCollectionIndexPath.row == 2)
        {
            self.currentArea = self.addressArray[indexPath.row];
            self.currentAreaIndexPath = indexPath;
        }
        
        [self hideLivingWithHide:YES];
        [self.collectionView reloadData];
        return;
    }
}

#pragma mark - storeList request
- (void)didRequestStoreListKeyListSuccessed
{
    [self.tableview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [self.dataSource removeAllObjects];
    for (NSDictionary * info in [[UserManager sharedManager] getStoreList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [mInfo setObject:[info objectForKey:@"address"] forKey:@"content"];
        [self.dataSource addObject:mInfo];
    }
    [self.tableview reloadData];
}

- (void)didRequestStoreListKeyListFailed:(NSString *)failedInfo
{
    [self.tableview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestChannelListSuccessed
{
    [SVProgressHUD dismiss];
    [self.tableview.mj_header endRefreshing];
    [self.dataSource removeAllObjects];
    for (NSDictionary * info in [[UserManager sharedManager] getStoreVRList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [mInfo setObject:[info objectForKey:@"address"] forKey:@"content"];
        [self.dataSource addObject:mInfo];
    }
    
    [self.tableview reloadData];
    
}

- (void)didRequestChannelListFailed:(NSString *)failedInfo
{
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}



@end
