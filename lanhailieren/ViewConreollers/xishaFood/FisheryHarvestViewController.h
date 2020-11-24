//
//  FisheryHarvestViewController.h
//  lanhailieren
//
//  Created by aaa on 2020/4/20.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ViewController.h"
#import "ENestScrollPageView.h"

@interface FisheryHarvestViewController : ViewController

@end

@interface FisheryHarvestItemView:EScrollPageItemBaseView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray * dataSource;
@property(nonatomic,retain)UITableView *tableView;

@end
