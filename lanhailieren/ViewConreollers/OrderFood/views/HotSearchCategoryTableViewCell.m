//
//  HotSearchCategoryTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "HotSearchCategoryTableViewCell.h"

@interface HotSearchCategoryTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSDictionary * info;

@property (nonatomic, strong)UILabel * searchLB;
@end

@implementation HotSearchCategoryTableViewCell

- (void)refreshWith:(NSDictionary * )info
{
    self.info = info;
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    [self prepareUI];
}

- (void)prepareUI
{
    self.dataArray = [self.info objectForKey:@"dataArray"];
    
    self.searchLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 12, 100, 15)];
    self.searchLB.textColor = UIColorFromRGB(0x666666);
    self.searchLB.text = @"热门搜索";
    self.searchLB.font = kMainFont_12;
    [self.contentView addSubview:self.searchLB];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchLB.frame) + 8, self.hd_width, 20) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [self.contentView addSubview:self.collectionView];
    
    
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
    contentLB.layer.cornerRadius = contentLB.hd_height / 2;
    contentLB.layer.masksToBounds = YES;
    contentLB.backgroundColor = UIColorFromRGB(0xf5f5f5);
    contentLB.textColor = UIColorFromRGB(0x333333);
    [cell.contentView addSubview:contentLB];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = [self.dataArray objectAtIndex:indexPath.item];
    if (self.hotSearctBlock) {
        self.hotSearctBlock(@{@"keyword":str});
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = [self.dataArray objectAtIndex:indexPath.item];
    float width = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, collectionView.hd_height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont_12} context:nil].size.width;
    return CGSizeMake(width + 30, collectionView.hd_height);
}


@end
