//
//  FoodIntroduceViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/14.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "FoodIntroduceViewController.h"
#import "FoodIntroduce_imageTableViewCell.h"
#define kFoodIntroduce_imageTableViewCellID @"FoodIntroduce_imageTableViewCellID"
#import "Food_remarkTableViewCell.h"
#define kFood_remarkTableViewCellID @"Food_remarkTableViewCellID"
#import "Food_DetailTableViewCell.h"
#define kFood_DetailTableViewCellID @"Food_DetailTableViewCellID"
#import "ShoppingCarBottomView.h"
#import "FooeSpecificationView.h"
#import "ChoosStoreViewController.h"
#import "ConfirmOrderViewController.h"

@interface FoodIntroduceViewController ()<UITableViewDelegate,UITableViewDataSource,UserModule_GoodDetailProtocol,UserModule_AddShoppingCarProtocol,UserModule_ShoppingCarListProtocol>
@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)NSMutableArray * imageArray;// banner
@property (nonatomic, strong)ShoppingCarBottomView * shoppingCarBottomView;
@property (nonatomic, strong)NSMutableArray * foodDetailArray;
@property (nonatomic, assign)float foodDetailColletionHeight;
@property (nonatomic, strong)NSArray * goodSpecificationArray;
@property (nonatomic, strong)NSArray * specsArray;

@property (nonatomic, strong)NSDictionary * currentSpecificationInfo;// 当前选中商品规格info
@property (nonatomic, strong)NSDictionary * goodInfo;// 商品info
@end

@implementation FoodIntroduceViewController

- (NSMutableArray *)foodDetailArray
{
    if (!_foodDetailArray) {
        _foodDetailArray = [NSMutableArray array];
    }
    return _foodDetailArray;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
     [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self navigationViewSetup];
    if (IS_PAD) {
        [self refreshUI_iPad];
    }else
    {
        [self refreshUI_iPhone];
    }
}

#pragma mark - ui
- (void)navigationViewSetup
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
- (void)loadData
{
    [SVProgressHUD dismiss];
    [[UserManager sharedManager] didRequestGoodDetailWithInfo:@{@"command":@10,@"good_id":@(self.good_id)} withNotifiedObject:self];
    
}
- (void)refreshUI_iPad
{
    self.leftBar = [[LeftBar alloc]initWithFrame:CGRectMake(0, 0, 53, kScreenHeight - 64)];
    [self.view addSubview:self.leftBar];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(53, 0, kScreenWidth - 53, kScreenHeight - 50) style:UITableViewStylePlain];
    [self.tableview registerClass:[Food_DetailTableViewCell class] forCellReuseIdentifier:kFood_DetailTableViewCellID];
    [self.tableview registerClass:[Food_remarkTableViewCell class] forCellReuseIdentifier:kFood_remarkTableViewCellID];
    [self.tableview registerClass:[FoodIntroduce_imageTableViewCell class] forCellReuseIdentifier:kFoodIntroduce_imageTableViewCellID];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    self.tableview.backgroundColor = UIColorFromRGB(0xf5f5f5);
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    self.shoppingCarBottomView = [[ShoppingCarBottomView alloc]initWithFrame:CGRectMake(53, kScreenHeight - 50, kScreenWidth - 53, 50) andFoodIntroduce:YES];
    [self.view addSubview:self.shoppingCarBottomView];
    
    __weak typeof(self)weakSelf = self;
    self.shoppingCarBottomView.buyShoppingCarBlock = ^(NSDictionary *info) {
        NSLog(@"立即购买");
        [weakSelf pushToConfirmOrderVC];
    };
    self.shoppingCarBottomView.addShoppingCarBlock = ^(NSDictionary *info) {
        NSLog(@"addShoppingCar");
        [weakSelf addShoppingCarAction];
    };
}

- (void)refreshUI_iPhone
{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[Food_DetailTableViewCell class] forCellReuseIdentifier:kFood_DetailTableViewCellID];
    [self.tableview registerClass:[Food_remarkTableViewCell class] forCellReuseIdentifier:kFood_remarkTableViewCellID];
    [self.tableview registerClass:[FoodIntroduce_imageTableViewCell class] forCellReuseIdentifier:kFoodIntroduce_imageTableViewCellID];;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = UIColorFromRGB(0xf5f5f5);
    
    self.shoppingCarBottomView = [[ShoppingCarBottomView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50) andFoodIntroduce:YES];
    [self.view addSubview:self.shoppingCarBottomView];
    
    __weak typeof(self)weakSelf = self;
    self.shoppingCarBottomView.buyShoppingCarBlock = ^(NSDictionary *info) {
        NSLog(@"立即购买");
        [weakSelf pushToConfirmOrderVC];
    };
    self.shoppingCarBottomView.addShoppingCarBlock = ^(NSDictionary *info) {
        NSLog(@"addShoppingCar");
        [weakSelf addShoppingCarAction];
    };
}

- (void)pushToConfirmOrderVC
{
    if (![[UserManager sharedManager] isUserLogin]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfLoginClick object:nil];
        return;
    }
    
    
    ConfirmOrderViewController * vc = [[ConfirmOrderViewController alloc]init];
    
    
    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:self.currentSpecificationInfo];
    if (self.currentSpecificationInfo != nil) {
        [mInfo setObject:[self.currentSpecificationInfo objectForKey:@"id"] forKey:@"goods_id"];
        [mInfo setObject:[[self.goodInfo objectForKey:@"fields"] objectForKey:@"point"] forKey:@"point"];
        
        [mInfo setObject:[self.currentSpecificationInfo objectForKey:@"sell_price"] forKey:@"price"];
        [mInfo setObject:[self.currentSpecificationInfo objectForKey:@"spec_text"] forKey:@"tip"];
        [mInfo setObject:[self.goodInfo objectForKey:@"title"] forKey:@"title"];
        [mInfo setObject:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[self.goodInfo objectForKey:@"img_url"]] forKey:@"image"];
    }else
    {
        [mInfo setObject:[self.goodInfo objectForKey:@"channel_id"] forKey:@"channel_id"];
        [mInfo setObject:[self.goodInfo objectForKey:@"id"] forKey:@"article_id"];
        [mInfo setObject:@1 forKey:@"count"];
        [mInfo setObject:@1 forKey:@"quantity"];
        [mInfo setObject:@0 forKey:@"goods_id"];
        [mInfo setObject:[[self.goodInfo objectForKey:@"fields"] objectForKey:@"point"] forKey:@"point"];
        
        [mInfo setObject:[[self.goodInfo objectForKey:@"fields"] objectForKey:@"sell_price"] forKey:@"price"];
        [mInfo setObject:@"" forKey:@"tip"];
        [mInfo setObject:[self.goodInfo objectForKey:@"title"] forKey:@"title"];
        [mInfo setObject:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[self.goodInfo objectForKey:@"img_url"]] forKey:@"image"];
    }
    
    vc.selectArray = [NSMutableArray arrayWithObject:mInfo];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:vc animated:YES];
    __weak typeof(self)weakSelf = self;
    vc.popFoodIntroVCBlock = ^{
        [weakSelf.navigationController setNavigationBarHidden:YES animated:NO];
    };
    
}

- (void)addShoppingCarAction
{
    if (![[UserManager sharedManager] isUserLogin]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfLoginClick object:nil];
        return;
    }
    
    if ([UserManager sharedManager].currentSelectStore == nil) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"您还未选择门店"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    if ([[self.goodInfo objectForKey:@"goods"] count] > 0 && self.currentSpecificationInfo == nil) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"您还未选择商品规格"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    [SVProgressHUD show];
    if (self.currentSpecificationInfo) {
        [[UserManager sharedManager] didRequestAddShoppingCarWith:@{@"command":@19,@"channel_id":[self.currentSpecificationInfo objectForKey:@"channel_id"],@"article_id":[self.currentSpecificationInfo objectForKey:@"article_id"],@"goods_id":[self.currentSpecificationInfo objectForKey:@"id"],@"quantity":[self.currentSpecificationInfo objectForKey:@"count"],@"shop_id":[[UserManager sharedManager].currentSelectStore objectForKey:@"id"]} withNotifiedObject:self];
    }else
    {
        [[UserManager sharedManager] didRequestAddShoppingCarWith:@{@"command":@19,@"channel_id":[self.goodInfo objectForKey:@"channel_id"],@"article_id":[self.goodInfo objectForKey:@"id"],@"goods_id":@0,@"quantity":@1,@"shop_id":[[UserManager sharedManager].currentSelectStore objectForKey:@"id"]} withNotifiedObject:self];
    }
    
}

#pragma mark - tableview delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            if (self.goodSpecificationArray.count == 0) {
                return 1;
            }else
            {
                return 2;
            }
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            FoodIntroduce_imageTableViewCell * imageCell = [tableView dequeueReusableCellWithIdentifier:kFoodIntroduce_imageTableViewCellID forIndexPath:indexPath];
            [imageCell refreshUIWithInfo:@{@"imageArray":self.imageArray}];
            imageCell.backFoodIntroduceBlock = ^(BOOL back) {
                [weakSelf.navigationController setNavigationBarHidden:NO animated:NO];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            };
            return imageCell;
        }else
        {
            Food_remarkTableViewCell * remarkCell = [tableView dequeueReusableCellWithIdentifier:kFood_remarkTableViewCellID forIndexPath:indexPath];
            if (self.currentSpecificationInfo == nil) {
                if (self.goodInfo) {
                    [remarkCell refreshWithInfo:@{@"title":[self.goodInfo objectForKey:@"title"],@"content":[self.goodInfo objectForKey:@"tags"],@"price":[NSString stringWithFormat:@"%@", [[self.goodInfo objectForKey:@"fields"] objectForKey:@"sell_price"]],@"saleCount":[NSString stringWithFormat:@"%@", [[self.goodInfo objectForKey:@"fields"] objectForKey:@"sale_num"]],@"count":[NSString stringWithFormat:@"%@", [[self.goodInfo objectForKey:@"fields"] objectForKey:@"stock_quantity"]]}];
                }
            }else
            {
                if (self.goodInfo) {
                    [remarkCell refreshWithInfo:@{@"title":[self.goodInfo objectForKey:@"title"],@"content":[self.goodInfo objectForKey:@"tags"],@"price":[NSString stringWithFormat:@"%@", [self.currentSpecificationInfo objectForKey:@"sell_price"]],@"saleCount":[NSString stringWithFormat:@"%@", [[self.goodInfo objectForKey:@"fields"] objectForKey:@"sale_num"]],@"count":[NSString stringWithFormat:@"%@", [[self.goodInfo objectForKey:@"fields"] objectForKey:@"stock_quantity"]]}];
                }
            }
            return remarkCell;
        }
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 1) {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
            [cell.contentView removeAllSubviews];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, tableView.hd_width - 50, cell.hd_height)];
            titleLB.font = kMainFont_12;
            NSString * str;
            if (self.currentSpecificationInfo == nil) {
                str = @"商品规格   请选择商品规格";
            }else
            {
                str = [NSString stringWithFormat:@"商品规格   %@", [self.currentSpecificationInfo objectForKey:@"spec_text"]];
            }
            NSMutableAttributedString * str_m = [[NSMutableAttributedString alloc]initWithString:str];
            [str_m addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x000000) range:NSMakeRange(6, str.length - 6)];
            titleLB.attributedText = str_m;
            [cell.contentView addSubview:titleLB];
            
            UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, cell.hd_height - 1, cell.hd_width, 1)];
            seperateView.backgroundColor = UIColorFromRGB(0xf7f7f7);
            [cell.contentView addSubview:seperateView];
            
            return cell;
        }else
        {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
            [cell.contentView removeAllSubviews];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, tableView.hd_width - 50, cell.hd_height)];
            titleLB.font = kMainFont_12;
            NSString * str = @"所选门店  请选择门店";
            if ([UserManager sharedManager].currentSelectStore) {
                str = [NSString stringWithFormat:@"所选门店  %@", [[UserManager sharedManager].currentSelectStore objectForKey:@"title"]];
            }
            NSMutableAttributedString * str_m = [[NSMutableAttributedString alloc]initWithString:str];
            [str_m addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x000000) range:NSMakeRange(6, str.length - 6)];
            titleLB.attributedText = str_m;
            [cell.contentView addSubview:titleLB];
            return cell;
        }
    }else if (indexPath.section == 2)
    {
        Food_DetailTableViewCell * detailCell = [tableView dequeueReusableCellWithIdentifier:kFood_DetailTableViewCellID forIndexPath:indexPath];
        [detailCell refreshUIWithInfo:@{@"dataArray":self.foodDetailArray} andHeight:self.foodDetailColletionHeight];
        detailCell.foodDetailCollectionHetghtBlock = ^(float height) {
            weakSelf.foodDetailColletionHeight = height;
            [weakSelf.tableview reloadData];
        };
        return detailCell;
    }else
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (IS_PAD) {
                return tableView.hd_width * 0.3;
            }
            return tableView.hd_width * 9 / 16;
        }else
        {
            return 70;
        }
    }else if(indexPath.section == 1)
    {
        return 50;
    }else if (indexPath.section == 2)
    {
        return self.foodDetailColletionHeight + 40;
    }
    else{
        return 100;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.hd_width, 5)];
    footView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            
            if (self.goodSpecificationArray.count == 0) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showInfoWithStatus:@"该商品暂无其他规格"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                return;
            }
            
            FooeSpecificationView * view = [[FooeSpecificationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andInfo:@{@"dataArray":self.goodSpecificationArray,@"price":@"128-460",@"count":@"已售：1456       库存：32",@"specs":self.specsArray}];
            view.specificationComplateBlock = ^(NSDictionary * _Nonnull info) {
                NSLog(@"%@", info);
                weakSelf.currentSpecificationInfo = info;
                [weakSelf.tableview reloadData];
                float price = [[info objectForKey:@"sell_price"] floatValue] * [[info objectForKey:@"count"] intValue];
                NSString * priceStr = [NSString stringWithFormat:@"%.2f", price];
                [weakSelf.shoppingCarBottomView refreshGoodPrice:@{@"price":priceStr}];
            };
            AppDelegate * delegate = [UIApplication sharedApplication].delegate;
            [delegate.window addSubview:view];
        }else
        {
            [self pushChooseStoreVC];
        }
    }
}
- (void)pushChooseStoreVC
{
    __weak typeof(self)weakSelf = self;
    ChoosStoreViewController * vc = [[ChoosStoreViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.chooseStoreBlock = ^(NSDictionary * _Nonnull info) {
        [UserManager sharedManager].currentSelectStore = info;
        [weakSelf.tableview reloadData];
    };
    vc.backBlock = ^(NSDictionary * _Nonnull info) {
        [weakSelf.navigationController setNavigationBarHidden:YES animated:NO];
    };
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didRequestGoodDetailSuccessed
{
    [SVProgressHUD dismiss];
    NSDictionary * data = [[UserManager sharedManager] getGoodDetailInfo];
    
    NSDictionary * info = [data objectForKey:@"data"];
    self.goodInfo = info;
    
    // banner
    [self.imageArray removeAllObjects];
    NSArray * albums = [info objectForKey:@"albums"];
    if (albums.count == 0) {
        [self.imageArray addObject:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[info objectForKey:@"img_url"]]];
    }else
    {
        for (NSString * imageUrl in albums) {
            [self.imageArray addObject:[NSString stringWithFormat:@"%@%@", kRootImageUrl,imageUrl]];
        }
    }
    
    // 商品规格
    self.goodSpecificationArray = [info objectForKey:@"goods"];
    self.specsArray = [data objectForKey:@"specs"];
    // 商品详细参数获取
    NSDictionary * fieldsInfo = [info objectForKey:@"fields"];
    NSDictionary * field_listInfo = [data objectForKey:@"field_list"];
    NSMutableArray * fieldArray = [NSMutableArray array];
    for (NSString * fieldKey in [fieldsInfo allKeys]) {
        for (NSString * field_listKey in [field_listInfo allKeys]) {
            if ([fieldKey isEqualToString:field_listKey]) {
//                NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
//                [mInfo setObject:[fieldsInfo objectForKey:fieldKey] forKey:@"value"];
//                [mInfo setObject:[field_listInfo objectForKey:field_listKey] forKey:@"name"];
                
                NSString * str = [NSString stringWithFormat:@"%@：%@", [field_listInfo objectForKey:field_listKey],[fieldsInfo objectForKey:fieldKey]];
                [fieldArray addObject:str];
                break;
            }
        }
    }
    self.foodDetailArray = fieldArray;
    
    if (self.goodSpecificationArray.count == 0) {
        [self.shoppingCarBottomView refreshGoodPrice:@{@"price":[[self.goodInfo objectForKey:@"fields"] objectForKey:@"sell_price"]}];
    }
    
    [self.tableview reloadData];
}

- (void)didRequestGoodDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestAddShoppingCarSuccessed
{
    [SVProgressHUD dismiss];
    NSLog(@"添加购物车成功");
    [SVProgressHUD showSuccessWithStatus:@"添加购物车成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    [[UserManager sharedManager] didRequestShoppingCarListWith:@{@"command":@21,@"shop_id":[[UserManager sharedManager].currentSelectStore objectForKey:@"id"]} withNotifiedObject:self ];
}

- (void)didRequestAddShoppingCarFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestShoppingCarListSuccessed
{
    [self.shoppingCarBottomView refreshTotalCount];
}

- (void)didRequestShoppingCarListFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
