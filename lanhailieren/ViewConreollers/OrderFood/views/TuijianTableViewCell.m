//
//  TuijianTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "TuijianTableViewCell.h"

#import "TuijianCollectionViewCell.h"
#define kTuijianCollectionViewCellID @"TuijianCollectionViewCellID"

@interface TuijianTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)UICollectionView * collectionview;

@end


@implementation TuijianTableViewCell

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)refreshUIWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.frame = self.bounds;
    
    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    backImageView.image = [UIImage imageNamed:@"bg_white"];
    [self.contentView addSubview:backImageView];
    
    self.dataArray = [info objectForKey:@"dataArray"];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 10;
    
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 10, self.hd_width - 20, self.hd_height - 20) collectionViewLayout:layout];
    self.collectionview.backgroundColor = [UIColor clearColor];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    [self.collectionview registerClass:[TuijianCollectionViewCell class] forCellWithReuseIdentifier:kTuijianCollectionViewCellID];
    
    
    [self.contentView addSubview:self.collectionview];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TuijianCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTuijianCollectionViewCellID forIndexPath:indexPath];
    [cell refreshUIWithInfo:[self.dataArray objectAtIndex:indexPath.item]];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.foodClickBlock) {
        self.foodClickBlock([self.dataArray objectAtIndex:indexPath.item]);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = (kScreenWidth) / 5;
    return CGSizeMake(width, (width) * 0.5 + 65);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
