//
//  Food_ specificationView.m
//  lanhailieren
//
//  Created by aaa on 2020/3/14.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "Food_ specificationView.h"
#import "PackageCountView.h"
@interface Food_specificationView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)NSDictionary *info;
@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIButton * closeBtn;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * priceLB;
@property (nonatomic, strong)UILabel * countLB;
@property (nonatomic, strong)UILabel * tipLB;
@property (nonatomic, strong)UILabel * specificationLB;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, strong)UILabel * buyCountLB;
@property (nonatomic, strong)PackageCountView * packageCountView;
@property (nonatomic, assign)int buyCount;
@property (nonatomic, strong)UIButton * complateBtn;

@property (nonatomic, strong)NSIndexPath * indexPath;

@end

@implementation Food_specificationView

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
    self.dataArray = [self.info objectForKey:@"dataArray"];
    
    UIView * backBlackView = [[UIView alloc]initWithFrame:self.bounds];
    backBlackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [self addSubview:backBlackView];
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 200, kScreenWidth, 300)];
    backView.backgroundColor = [UIColor whiteColor];
    self.backView = backView;
    [self addSubview:backView];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(self.backView.hd_width - 32, 10, 22, 22);
    [self.closeBtn setImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.closeBtn];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30, 120, 85)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[self.info objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    [self.backView addSubview:self.iconImageView];
    
    self.priceLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, self.iconImageView.hd_y + 12, self.hd_width - 200, 20)];
    self.priceLB.font = [UIFont systemFontOfSize:12];
    self.priceLB.textColor = kMainRedColor;
    [self.backView addSubview:self.priceLB];
    NSString * priceLB = [NSString stringWithFormat:@"￥%@", [self.info objectForKey:@"price"]];
    self.priceLB.text = priceLB;
    
    self.countLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, CGRectGetMaxY(self.priceLB.frame), self.hd_width - 120 - 35, 20)];
    self.countLB.text = [NSString stringWithFormat:@"%@", [self.info objectForKey:@"count"]];
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
    [self.backView addSubview:self.specificationLB];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.specificationLB.frame) + 10, kScreenWidth - 30, 30) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [self.backView addSubview:self.collectionView];
    
    UIView * seperateView1 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.collectionView.frame) + 10 , self.hd_width - 30, 1)];
    seperateView1.backgroundColor = UIColorFromRGB(0xe1e1e1);
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
    [self.backView addSubview:seperateView];
    
    self.complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(self.backView.hd_width - 100, CGRectGetMaxY(seperateView.frame) + 15, 200, 30);
    self.closeBtn.backgroundColor = kMainRedColor;
    [self.closeBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.layer.cornerRadius = self.complateBtn.hd_height / 2;
    self.layer.masksToBounds = YES;
    [self.closeBtn addTarget:self action:@selector(complateAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.closeBtn];
    
}
- (void)closeAction
{
    [self removeFromSuperview];
}

- (void)complateAction
{
    if (self.specificationComplateBlock) {
        self.specificationComplateBlock(@{});
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    
    UILabel * contentLB = [[UILabel alloc]initWithFrame:cell.contentView.bounds];
    contentLB.text = [NSString stringWithFormat:@"%@", [self.dataArray objectAtIndex:indexPath.item]];
    contentLB.textAlignment = NSTextAlignmentCenter;
    contentLB.font = kMainFont_12;
    if (self.indexPath.item == indexPath.item) {
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
    self.indexPath = indexPath;
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = [self.dataArray objectAtIndex:indexPath.item];
    float width = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, collectionView.hd_height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont_12} context:nil].size.width;
    return CGSizeMake(width + 30, collectionView.hd_height);
}

@end
