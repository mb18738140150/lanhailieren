//
//  RechargeViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/9.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeCollectionViewCell.h"
#define kRechargeCollectionViewCellID @"RechargeCollectionViewCellID"
#import "RechargeFooterCollectionReusableView.h"
#define kRechargeFooterCollectionReusableViewID @"RechargeFooterCollectionReusableViewID"


@interface RechargeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UICollectionView * colletionView;
@property (nonatomic, strong)NSMutableArray * chongzhiDataSource;
@property (nonatomic,strong) UICollectionViewFlowLayout         *flowLayout;

@property (nonatomic, strong)NSIndexPath * currentIndexPath;

@end

@implementation RechargeViewController

- (NSMutableArray *)chongzhiDataSource
{
    if (!_chongzhiDataSource) {
        _chongzhiDataSource = [NSMutableArray array];
    }
    return _chongzhiDataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self navigationViewSetup];
    
    if (IS_PAD) {
        [self refreshUI_iPad];
    }else
    {
        [self refreshUI_iPhone];
    }

}
- (void)navigationViewSetup
{
    self.navigationItem.title = @"充值";
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
    NSDictionary * dataInfo = @{@"price":@"50",@"actualPrice":@"49.9",@"integer":@"+120",@"state":@"待发货"};
    NSDictionary  * passwordFoodInfo = @{@"price":@"50",@"actualPrice":@"49.9",@"integer":@"+120",@"state":@"待发货"};
    NSDictionary  * phoneNumberInfo = @{@"price":@"50",@"actualPrice":@"49.9",@"integer":@"+120",@"state":@"待发货"};
    NSDictionary  * addressInfo = @{@"price":@"50",@"actualPrice":@"49.9",@"integer":@"+120",@"state":@"待发货"};
    NSDictionary  * info1 = @{@"price":@"50",@"actualPrice":@"49.9",@"integer":@"+120",@"state":@"待发货"};
    NSDictionary  * info2 = @{@"price":@"50",@"actualPrice":@"49.9",@"integer":@"+120",@"state":@"待发货"};
    
    [self.chongzhiDataSource addObject:dataInfo];
    [self.chongzhiDataSource addObject:passwordFoodInfo];
    [self.chongzhiDataSource addObject:phoneNumberInfo];
    [self.chongzhiDataSource addObject:addressInfo];
    [self.chongzhiDataSource addObject:info1];
    [self.chongzhiDataSource addObject:info2];
    
}

- (void)refreshUI_iPad
{
    self.leftBar = [[LeftBar alloc]initWithFrame:CGRectMake(0, 0, 53, kScreenHeight - 64)];
    [self.view addSubview:self.leftBar];
    
    UIImageView * topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30 + 53, 8, kScreenWidth - 60 - 53, (kScreenWidth - 30 - 53) * 0.12)];
    topImageView.image = [UIImage imageNamed:@"banner_topup"];
    [self.view addSubview:topImageView];
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout = flowLayout;
    self.flowLayout.minimumLineSpacing = 23;
    self.flowLayout.minimumInteritemSpacing = 60;
    self.flowLayout.itemSize = CGSizeMake(160, 87);
    
    float seperateWidth = (kScreenWidth - 53 - 480 - 120) / 2;
    
    self.colletionView = [[UICollectionView alloc]initWithFrame:CGRectMake(53 + seperateWidth, 100, kScreenWidth - 53 - seperateWidth * 2, kScreenHeight - 100 - kNavigationBarHeight - kStatusBarHeight) collectionViewLayout:self.flowLayout];
    [self.colletionView registerClass:[RechargeCollectionViewCell class] forCellWithReuseIdentifier:kRechargeCollectionViewCellID];
    
    [self.colletionView registerClass:[RechargeFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kRechargeFooterCollectionReusableViewID];
    [self.colletionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerReusableViewid"];
    self.colletionView.delegate = self;
    self.colletionView.dataSource = self;
    [self.view addSubview:self.colletionView];
    self.colletionView.backgroundColor = [UIColor whiteColor];
    
}

- (void)refreshUI_iPhone
{
    UIImageView * topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 8, kScreenWidth - 60, 73)];
    topImageView.contentMode = UIViewContentModeScaleAspectFill;
    topImageView.clipsToBounds = YES;
    topImageView.image = [UIImage imageNamed:@"banner_topup"];
    [self.view addSubview:topImageView];
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout = flowLayout;
    self.flowLayout.minimumLineSpacing = 23;
    self.flowLayout.minimumInteritemSpacing = 60;
    self.flowLayout.itemSize = CGSizeMake((kScreenWidth - 120) / 2, 87);
    
    self.colletionView = [[UICollectionView alloc]initWithFrame:CGRectMake(30, 100, kScreenWidth - 60, kScreenHeight - 100 - kNavigationBarHeight - kStatusBarHeight) collectionViewLayout:self.flowLayout];
    [self.colletionView registerClass:[RechargeCollectionViewCell class] forCellWithReuseIdentifier:kRechargeCollectionViewCellID];
    
    [self.colletionView registerClass:[RechargeFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kRechargeFooterCollectionReusableViewID];
    [self.colletionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerReusableViewid"];
    
    self.colletionView.delegate = self;
    self.colletionView.dataSource = self;
    [self.view addSubview:self.colletionView];
    self.colletionView.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - UICollectionview delegate & datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.chongzhiDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RechargeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRechargeCollectionViewCellID forIndexPath:indexPath];
    
    [cell refreshUIWith:[self.chongzhiDataSource objectAtIndex:indexPath.item]];
    if (indexPath.item == self.currentIndexPath.item) {
        [cell refreshSelectUI];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndexPath = indexPath;
    [self.colletionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (kScreenWidth - 120) / 2;
    if (IS_PAD) {
        width = 160;
    }
    return CGSizeMake(width, 87);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.hd_width, 65);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.hd_width, 251);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionViewCell *headview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerReusableViewid" forIndexPath:indexPath];
        
        UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, collectionView.hd_width, 15)];
        titleLB.text = @"账户：深海";
        titleLB.textColor = UIColorFromRGB(0x000000);
        titleLB.font = kMainFont;
        [headview addSubview:titleLB];
        
        reusableview = headview;
    }else if (kind == UICollectionElementKindSectionFooter){
        RechargeFooterCollectionReusableView *headview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kRechargeFooterCollectionReusableViewID forIndexPath:indexPath];
        [headview refreshUIWithInfo:@{@"price":@"49.9"}];
        
        reusableview = headview;
    }
    return reusableview;
}


@end
