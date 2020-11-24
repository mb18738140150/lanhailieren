//
//  CommodityDetailViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "CommodityDetailViewController.h"
#import "CommodityBannerTableViewCell.h"
#define kCommodityBannerTableViewCellID @"CommodityBannerTableViewCellID"
#import "CommodityInfoTableViewCell.h"
#define kCommodityInfoTableViewCellID @"CommodityInfoTableViewCellID"
#import "ConvertCommodityViewController.h"

@interface CommodityDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UserModule_GoodDetailProtocol>

@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSDictionary * commodityInfo;
@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)NSDictionary * goodInfo;// 商品info
@property (nonatomic, assign)int count;
@property (nonatomic, strong)UILabel * totalPointLB;
@property (nonatomic, strong)NSMutableArray * bannerImageUrlArray;

@end

@implementation CommodityDetailViewController

- (NSMutableArray *)bannerImageUrlArray
{
    if (!_bannerImageUrlArray) {
        _bannerImageUrlArray = [NSMutableArray array];
    }
    return _bannerImageUrlArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    if (IS_PAD) {
        [self refreshUI_iPad];
    }else
    {
        [self refreshUI_iPhone];
    }
}
- (void)loadData
{
    self.count = 1;
    
    [SVProgressHUD dismiss];
    [[UserManager sharedManager] didRequestGoodDetailWithInfo:@{@"command":@10,@"good_id":@([[self.info objectForKey:@"id"] intValue])} withNotifiedObject:self];
    
}
- (void)refreshUI_iPad
{
    self.leftBar = [[LeftBar alloc]initWithFrame:CGRectMake(0, 0, 53, kScreenHeight - 64 - 50)];
    [self.view addSubview:self.leftBar];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(53, 5, kScreenWidth - 53, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.tableview registerClass:[CommodityInfoTableViewCell class] forCellReuseIdentifier:kCommodityInfoTableViewCellID];
    [self.tableview registerClass:[CommodityBannerTableViewCell class] forCellReuseIdentifier:kCommodityBannerTableViewCellID];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    NSString * integerStr = [NSString stringWithFormat:@"所需积分: %d", ([self getGoodPoint] * self.count)];
    NSMutableAttributedString *integerStr_m = [[NSMutableAttributedString alloc]initWithString:integerStr];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:kMainRedColor};
    [integerStr_m addAttributes:attribute range: NSMakeRange(5, integerStr.length - 5)];
    
    UILabel * orderBtn = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 200, 20)];
    orderBtn.textColor = UIColorFromRGB(0x000000);
    orderBtn.attributedText = integerStr_m;
    orderBtn.font = [UIFont systemFontOfSize:16];
    self.totalPointLB = orderBtn;
    [bottomView addSubview:orderBtn];
    
    UIButton * convertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    convertBtn.frame = CGRectMake(bottomView.hd_width - 120, 0, 120, 50);
    convertBtn.backgroundColor = kMainRedColor;
    [convertBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [convertBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    convertBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [convertBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:convertBtn];
    
    [self.view addSubview:bottomView];
    
}

- (void)refreshUI_iPhone
{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, kScreenHeight - 50) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[CommodityInfoTableViewCell class] forCellReuseIdentifier:kCommodityInfoTableViewCellID];
    [self.tableview registerClass:[CommodityBannerTableViewCell class] forCellReuseIdentifier:kCommodityBannerTableViewCellID];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableview];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    NSString * integerStr = [NSString stringWithFormat:@"所需积分: %d", ([self getGoodPoint] * self.count)];
    NSMutableAttributedString *integerStr_m = [[NSMutableAttributedString alloc]initWithString:integerStr];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:kMainRedColor};
    [integerStr_m addAttributes:attribute range: NSMakeRange(5, integerStr.length - 5)];
    
    UILabel * orderBtn = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 200, 20)];
    orderBtn.textColor = UIColorFromRGB(0x000000);
    orderBtn.attributedText = integerStr_m;
    orderBtn.font = [UIFont systemFontOfSize:16];
    self.totalPointLB = orderBtn;
    [bottomView addSubview:orderBtn];
    
    UIButton * convertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    convertBtn.frame = CGRectMake(bottomView.hd_width - 120, 0, 120, 50);
    convertBtn.backgroundColor = kMainRedColor;
    [convertBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [convertBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    convertBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [convertBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:convertBtn];
    
    [self.view addSubview:bottomView];
    
}

- (int)getGoodPoint
{
    NSString * pointStr = [NSString stringWithFormat:@"%@", [self.info objectForKey:@"point"]];
    pointStr = [pointStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return pointStr.intValue;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CommodityBannerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCommodityBannerTableViewCellID forIndexPath:indexPath];
        cell.bannerImgUrlArray = self.bannerImageUrlArray;
        [cell resetSubviews];
        
        __weak typeof(self)weakSelf = self;
        cell.backBtnClickBlock = ^{
            [weakSelf.navigationController setNavigationBarHidden:NO animated:NO];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        return cell;
    }else {
        CommodityInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCommodityInfoTableViewCellID forIndexPath:indexPath];
        [cell refreshUIWithInfo:self.info];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 167;
    }
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)buyAction
{
    ConvertCommodityViewController * convertVC = [[ConvertCommodityViewController alloc]init];
    convertVC.info = [[NSMutableDictionary alloc] initWithDictionary:self.info];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:convertVC animated:YES];
}

- (void)didRequestGoodDetailSuccessed
{
    [SVProgressHUD dismiss];
    NSDictionary * data = [[UserManager sharedManager] getGoodDetailInfo];
    
    NSDictionary * info = [data objectForKey:@"data"];
    self.goodInfo = info;
    
    [self.bannerImageUrlArray removeAllObjects];
    NSArray * albums = [info objectForKey:@"albums"];
    if (albums.count == 0) {
        [self.bannerImageUrlArray addObject:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[info objectForKey:@"img_url"]]];
    }else
    {
        for (NSString * imageUrl in albums) {
            [self.bannerImageUrlArray addObject:[NSString stringWithFormat:@"%@%@", kRootImageUrl,imageUrl]];
        }
    }
    // 商品规格
//    self.goodSpecificationArray = [info objectForKey:@"goods"];
//    self.specsArray = [data objectForKey:@"specs"];
//    // 商品详细参数获取
//    NSDictionary * fieldsInfo = [info objectForKey:@"fields"];
//    NSDictionary * field_listInfo = [data objectForKey:@"field_list"];
//    NSMutableArray * fieldArray = [NSMutableArray array];
//    for (NSString * fieldKey in [fieldsInfo allKeys]) {
//        for (NSString * field_listKey in [field_listInfo allKeys]) {
//            if ([fieldKey isEqualToString:field_listKey]) {
//                NSString * str = [NSString stringWithFormat:@"%@：%@", [field_listInfo objectForKey:field_listKey],[fieldsInfo objectForKey:fieldKey]];
//                [fieldArray addObject:str];
//                break;
//            }
//        }
//    }
//    self.foodDetailArray = fieldArray;
    
    [self.tableview reloadData];
}

- (void)didRequestGoodDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


@end
