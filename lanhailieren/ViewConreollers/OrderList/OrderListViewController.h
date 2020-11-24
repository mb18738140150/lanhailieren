//
//  OrderListViewController.h
//  lanhailieren
//
//  Created by aaa on 2020/3/10.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ViewController.h"
#import "ENestScrollPageView.h"


@interface OrderListViewController : ViewController
@property(nonatomic,assign)int type;

@end

@interface Test1ItemView:EScrollPageItemBaseView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray * dataSource;
@property(nonatomic,retain)UITableView *tableView;

@end
