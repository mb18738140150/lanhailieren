//
//  FoodMakeViewController.h
//  lanhailieren
//
//  Created by aaa on 2020/4/16.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ViewController.h"
#import "ENestScrollPageView.h"


@interface FoodMakeViewController : ViewController
@property(nonatomic,assign)BOOL haveLoad;
- (void)showCategory;
@end

@interface FoodMakeItemView:EScrollPageItemBaseView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)NSMutableArray * dataSource;
@property(nonatomic,retain)UICollectionView *tableView;
- (void)stopPlay;

- (void)getCurrentpage_indexInfo;

@end
