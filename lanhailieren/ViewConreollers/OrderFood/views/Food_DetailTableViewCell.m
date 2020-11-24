//
//  Food_DetailTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "Food_DetailTableViewCell.h"

@interface Food_DetailTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)UICollectionView * collectionview;

@end

@implementation Food_DetailTableViewCell



- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)refreshFisheryHarvestDetailUIWithInfo:(NSDictionary *)info andHeight:(float)collectionViewHeight
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.frame = self.bounds;
    
    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    backImageView.image = [UIImage imageNamed:@"bg_white"];
    
    
    [self.contentView addSubview:backImageView];
    
    self.dataArray = [info objectForKey:@"dataArray"];
    
    UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width / 2 - 100, 10, 200, 15)];
    titleLB.backgroundColor = [UIColor whiteColor];
    titleLB.text = [info objectForKey:@"title"];
    titleLB.font = kMainFont;
    titleLB.textColor = UIColorFromRGB(0x000000);
    titleLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLB];
    
    UILabel * tagLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width / 2 - 100, CGRectGetMaxY(titleLB.frame) + 5, 200, 15)];
    tagLB.backgroundColor = [UIColor whiteColor];
    tagLB.text = [info objectForKey:@"tag"];
    tagLB.font = kMainFont;
    tagLB.textColor = UIColorFromRGB(0x999999);
    tagLB.textAlignment = NSTextAlignmentCenter;
//    [self.contentView addSubview:tagLB];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 2;
    
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(15, 35, self.hd_width - 30, collectionViewHeight) collectionViewLayout:layout];
    self.collectionview.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    
    [self.contentView addSubview:self.collectionview];
    
    [self.collectionview reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        float height = self.collectionview.collectionViewLayout.collectionViewContentSize.height;
        NSLog(@"---------- %.2f ------------", height);
        if (collectionViewHeight == 0) {
            if (self.foodDetailCollectionHetghtBlock) {
                self.foodDetailCollectionHetghtBlock(height);
            }
        }
    });
}

- (void)refreshUIWithInfo:(NSDictionary *)info andHeight:(float)collectionViewHeight;
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.frame = self.bounds;
    
    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    backImageView.image = [UIImage imageNamed:@"bg_white"];
    [self.contentView addSubview:backImageView];
    
    self.dataArray = [info objectForKey:@"dataArray"];
    
    UIView * sepeLine = [[UIView alloc]initWithFrame:CGRectMake(self.hd_width / 2 - 45, 17, 90, 1)];
    sepeLine.backgroundColor = UIColorFromRGB(0x666666);
    [self.contentView addSubview:sepeLine];
    UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width / 2 - 27, 12, 55, 15)];
    titleLB.backgroundColor = [UIColor whiteColor];
    titleLB.text = @"详细参数";
    titleLB.font = kMainFont_12;
    titleLB.textColor = UIColorFromRGB(0x666666);
    titleLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLB];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10;
    
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(15, 30, self.hd_width - 30, collectionViewHeight) collectionViewLayout:layout];
    self.collectionview.backgroundColor = [UIColor whiteColor];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    
    [self.contentView addSubview:self.collectionview];
    
    [self.collectionview reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        float height = self.collectionview.collectionViewLayout.collectionViewContentSize.height;
        NSLog(@"---------- %.2f ------------", height);
        if (collectionViewHeight == 0) {
            if (self.foodDetailCollectionHetghtBlock) {
                self.foodDetailCollectionHetghtBlock(height);
            }
        }
    });
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    [cell.contentView removeAllSubviews];
    UILabel * contentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.hd_width, 30)];
    contentLB.textColor = UIColorFromRGB(0x666666);
    contentLB.text = [self.dataArray objectAtIndex:indexPath.item];
    contentLB.font = kMainFont_12;
    [cell.contentView addSubview:contentLB];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = (kScreenWidth - 40) / 3;
    if (IS_PAD) {
        width = (kScreenWidth - 40 ) / 3;
    }
    return CGSizeMake(width, 30);
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
