//
//  FooeSpecificationView.m
//  lanhailieren
//
//  Created by aaa on 2020/3/14.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "FooeSpecificationView.h"
#import "PackageCountView.h"
#import "SpecificationLayout.h"
#import "Head_tipCollectionReusableView.h"
#define kHead_tipCollectionReusableViewID @"Head_tipCollectionReusableViewID"

@interface FooeSpecificationView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)NSDictionary *info;
@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIButton * closeBtn;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * priceLB;
@property (nonatomic, strong)UILabel * countLB;
@property (nonatomic, strong)UILabel * tipLB;
@property (nonatomic, strong)UILabel * specificationLB;

@property (nonatomic, strong)UIView * seperateView1;
@property (nonatomic, strong)UIView * seperateView;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSMutableArray * goodsArray;

@property (nonatomic, strong)UILabel * buyCountLB;
@property (nonatomic, strong)PackageCountView * packageCountView;
@property (nonatomic, assign)int buyCount;
@property (nonatomic, strong)UIButton * complateBtn;

//@property (nonatomic, strong)NSIndexPath * indexPath;
@property (nonatomic, strong)NSMutableArray * indepathArray;

@property (nonatomic, strong)NSDictionary * currentSelectSpecificationInfo;// 当前已选中规格

@property (nonatomic, assign)float collectionViewHeight;


@end

@implementation FooeSpecificationView

- (NSMutableArray *)indepathArray
{
    if (!_indepathArray) {
        _indepathArray = [NSMutableArray array];
    }
    return _indepathArray;
}

- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSDictionary *)info
{
    self = [super initWithFrame:frame];
    if (self) {
        self.info = info;
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    [self removeAllSubviews];
    self.goodsArray = [self.info objectForKey:@"dataArray"];
    self.dataArray = [self.info objectForKey:@"specs"];
    self.buyCount = 1;
    
    [self.indepathArray removeAllObjects];
    for (int i = 0; i < self.dataArray.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
        [self.indepathArray addObject:indexPath];
    }
    
    NSDictionary * firstInfo ;
    if (self.dataArray.count > 0) {
        firstInfo = [self.dataArray firstObject];
    }
    
    UIView * backBlackView = [[UIView alloc]initWithFrame:self.bounds];
    backBlackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [self addSubview:backBlackView];
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 300, kScreenWidth, self.collectionViewHeight + 270)];
    backView.backgroundColor = [UIColor whiteColor];
    self.backView = backView;
    [self addSubview:backView];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(self.backView.hd_width - 32, 10, 22, 22);
    [self.closeBtn setImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.closeBtn];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30, 120, 85)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[firstInfo objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    [self.backView addSubview:self.iconImageView];
    
    self.priceLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, self.iconImageView.hd_y + 12, self.hd_width - 200, 20)];
    self.priceLB.font = [UIFont systemFontOfSize:12];
    self.priceLB.textColor = kMainRedColor;
    [self.backView addSubview:self.priceLB];
    NSString * priceLB = [NSString stringWithFormat:@"￥%@", [firstInfo objectForKey:@"sell_price"]];
    self.priceLB.text = priceLB;
    
    self.countLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, CGRectGetMaxY(self.priceLB.frame), self.hd_width - 120 - 35, 20)];
    self.countLB.text = [NSString stringWithFormat:@"库存：%@", [firstInfo objectForKey:@"stock_quantity"]];
    self.countLB.font = [UIFont systemFontOfSize:10];
    self.countLB.textColor = UIColorFromRGB(0x999999);
    [self.backView addSubview:self.countLB];
    
    self.tipLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, CGRectGetMaxY(self.countLB.frame), self.hd_width - 120 - 35, 20)];
    self.tipLB.textColor = UIColorFromRGB(0x010101);
    self.tipLB.text = @"请选择规格";
    self.tipLB.font = [UIFont systemFontOfSize:10];
    [self.backView addSubview:self.tipLB];
    
    self.specificationLB = [[UILabel alloc]initWithFrame:CGRectMake(self.iconImageView.hd_x, CGRectGetMaxY(self.iconImageView.frame) + 10, 100, 20)];
    self.specificationLB.textColor = UIColorFromRGB(0x010101);
    self.specificationLB.text = @"规格";
    self.specificationLB.font = kMainFont_12;
//    [self.backView addSubview:self.specificationLB];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.iconImageView.frame) + 10, kScreenWidth - 30, self.collectionViewHeight) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [self.collectionView registerClass:[Head_tipCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHead_tipCollectionReusableViewID];
    [self.backView addSubview:self.collectionView];
    
    UIView * seperateView1 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.collectionView.frame) + 10 , self.hd_width - 30, 1)];
    seperateView1.backgroundColor = UIColorFromRGB(0xe1e1e1);
    self.seperateView1 = seperateView1;
    [self.backView addSubview:seperateView1];
    
    self.buyCountLB = [[UILabel alloc]initWithFrame:CGRectMake(self.iconImageView.hd_x, CGRectGetMaxY(seperateView1.frame) + 10, 100, 30)];
    self.buyCountLB.textColor = UIColorFromRGB(0x010101);
    self.buyCountLB.text = @"规格";
    self.buyCountLB.font = kMainFont_12;
    [self.backView addSubview:self.buyCountLB];
    
    __weak typeof(self)weakSelf = self;
    self.packageCountView = [[PackageCountView alloc]initWithFrame:CGRectMake(self.hd_width - 100 , CGRectGetMaxY(seperateView1.frame) + 13, 85, 23)];
    self.packageCountView.countBlock = ^(int count) {
        weakSelf.buyCount = count;
        if (weakSelf.countBlock) {
            weakSelf.countBlock(count);
        }
    };
    self.packageCountView.countLB.text = @"1";
    
    [self.backView addSubview:self.packageCountView];
    
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(seperateView1.frame) + 50, self.hd_width - 30, 1)];
    seperateView.backgroundColor = UIColorFromRGB(0xe1e1e1);
    self.seperateView = seperateView;
    [self.backView addSubview:seperateView];
    
    self.complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.complateBtn.frame = CGRectMake(self.backView.hd_width / 2 - 100, CGRectGetMaxY(seperateView.frame) + 15, 200, 30);
    self.complateBtn.backgroundColor = kMainRedColor;
    [self.complateBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.complateBtn.layer.cornerRadius = self.complateBtn.hd_height / 2;
    self.complateBtn.layer.masksToBounds = YES;
    [self.complateBtn addTarget:self action:@selector(complateAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.complateBtn];
    
    [self.collectionView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        float height = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
        NSLog(@"^^^^ %.2f ^^^", height);
        if (self.collectionViewHeight == 0) {
            self.collectionViewHeight = height;
            [self prepareUI1];
        }
    });
    [self getCurrentSelectSpecs];
    
    
}

- (void)prepareUI1
{
    self.backView.frame = CGRectMake(0, kScreenHeight - 270 - self.collectionViewHeight, kScreenWidth, self.collectionViewHeight + 270);
    self.closeBtn.frame = CGRectMake(self.backView.hd_width - 32, 10, 22, 22);
    self.iconImageView.frame = CGRectMake(15, 30, 120, 85);
    self.priceLB.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, self.iconImageView.hd_y + 12, self.hd_width - 200, 20);
    self.countLB.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, CGRectGetMaxY(self.priceLB.frame), self.hd_width - 120 - 35, 20);
    self.tipLB.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, CGRectGetMaxY(self.countLB.frame), self.hd_width - 120 - 35, 20);
    
//    self.specificationLB.frame = CGRectMake(self.iconImageView.hd_x, CGRectGetMaxY(self.iconImageView.frame) + 10, 100, 20);
    self.collectionView.frame = CGRectMake(15, CGRectGetMaxY(self.iconImageView.frame) + 10, kScreenWidth - 30, self.collectionViewHeight);
    
    self.seperateView1.frame = CGRectMake(15, CGRectGetMaxY(self.collectionView.frame) + 10 , self.hd_width - 30, 1);
    self.buyCountLB.frame = CGRectMake(self.iconImageView.hd_x, CGRectGetMaxY(self.seperateView1.frame) + 10, 100, 30);
    self.packageCountView.frame = CGRectMake(self.hd_width - 100 , CGRectGetMaxY(self.seperateView1.frame) + 13, 85, 23);
    
    self.seperateView.frame = CGRectMake(15, CGRectGetMaxY(self.seperateView1.frame) + 50, self.hd_width - 30, 1);
    self.complateBtn.frame = CGRectMake(self.backView.hd_width / 2 - 100, CGRectGetMaxY(self.seperateView.frame) + 15, 200, 30);
}

- (void)closeAction
{
    [self removeFromSuperview];
}

- (void)complateAction
{
    if (self.currentSelectSpecificationInfo == nil) {
        [SVProgressHUD showWithStatus:@"请选择规格"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    if (self.specificationComplateBlock) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:self.currentSelectSpecificationInfo];
        [mInfo setObject:@(self.buyCount) forKey:@"count"];
        self.specificationComplateBlock(mInfo);
    }
    [self removeFromSuperview];
}

#pragma mark - collectionView delegate & datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary * specsInfo = [self.dataArray objectAtIndex:section];
    return [[specsInfo objectForKey:@"son"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    cell.contentView.frame = cell.bounds;
    cell.backgroundColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    UILabel * contentLB = [[UILabel alloc]initWithFrame:cell.contentView.bounds];
    NSDictionary * specsInfo = [[[self.dataArray objectAtIndex:indexPath.section] objectForKey:@"son"] objectAtIndex:indexPath.item];
    contentLB.text = [specsInfo objectForKey:@"title"];
    contentLB.textAlignment = NSTextAlignmentCenter;
    contentLB.font = kMainFont_12;
    contentLB.layer.cornerRadius = 3;
    contentLB.layer.masksToBounds = YES;
    
    NSIndexPath * currentIndex = [self.indepathArray objectAtIndex:indexPath.section];
    if (currentIndex.item == indexPath.item) {
        contentLB.backgroundColor = kMainRedColor;
        contentLB.textColor = UIColorFromRGB(0xffffff);
    }else
    {
        contentLB.backgroundColor = UIColorFromRGB(0xf6f6f6);
    
        contentLB.textColor = UIColorFromRGB(0x000000);
    }
    [cell.contentView addSubview:contentLB];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath * index = [self.indepathArray objectAtIndex:indexPath.section];
    index = [NSIndexPath indexPathForRow:indexPath.item inSection:indexPath.section];
    [self.indepathArray removeObjectAtIndex:indexPath.section];
    [self.indepathArray insertObject:index atIndex:indexPath.section];
    
    
    [self getCurrentSelectSpecs];
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * specsInfo = [[[self.dataArray objectAtIndex:indexPath.section] objectForKey:@"son"] objectAtIndex:indexPath.item];
    NSString * str = [specsInfo objectForKey:@"title"];
    float width = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, collectionView.hd_height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont_12} context:nil].size.width;
    return CGSizeMake(width + 30, 30);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    NSDictionary * specsInfo = [self.dataArray objectAtIndex:indexPath.section];
    Head_tipCollectionReusableView * tipHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHead_tipCollectionReusableViewID forIndexPath:indexPath];
    [tipHeadView refreshUIWith:@{@"title":[specsInfo objectForKey:@"title"]}];
    [tipHeadView hideGoBtn];
    return tipHeadView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.hd_width, 30);
}

- (void)getCurrentSelectSpecs
{
    
    NSString * specsId = @"";
    for (int i = 0; i < self.indepathArray.count; i++) {
        NSIndexPath * index = [self.indepathArray objectAtIndex:i];
        NSDictionary * specsInfo = [[[self.dataArray objectAtIndex:index.section] objectForKey:@"son"] objectAtIndex:index.item];
        if (i < self.indepathArray.count - 1) {
            specsId  = [specsId stringByAppendingString:[NSString stringWithFormat:@"%@,",[specsInfo objectForKey:@"spec_id"]]];
        }else
        {
            specsId  = [specsId stringByAppendingString:[NSString stringWithFormat:@"%@",[specsInfo objectForKey:@"spec_id"]]];
        }
        
    }
    NSLog(@"%@", specsId);
    
    NSDictionary * specsInfo ;
    for (NSDictionary * info in self.goodsArray) {
        if ([[info objectForKey:@"spec_ids"] containsString:specsId]) {
            specsInfo = info;
            break;
        }
    }
    NSLog(@"%@", specsInfo);
    self.currentSelectSpecificationInfo = specsInfo;
    NSString * priceLB = [NSString stringWithFormat:@"￥%@", [self.currentSelectSpecificationInfo objectForKey:@"sell_price"]];
    self.priceLB.text = priceLB;
    self.countLB.text = [NSString stringWithFormat:@"库存：%@", [self.currentSelectSpecificationInfo objectForKey:@"stock_quantity"]];
}

@end
