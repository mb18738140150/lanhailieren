//
//  ClubActivityViewController.h
//  lanhailieren
//
//  Created by aaa on 2020/4/22.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ViewController.h"
#import "ENestScrollPageView.h"

@interface ClubActivityViewController : ViewController

@end

@interface ClubActivityItemView:EScrollPageItemBaseView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)NSMutableArray * dataSource;
@property(nonatomic,retain)UICollectionView *tableView;

@end
