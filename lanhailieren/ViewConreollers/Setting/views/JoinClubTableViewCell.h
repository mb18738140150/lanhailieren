//
//  JoinClubTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/4/20.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JoinClubTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView * iconImageVIew;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * connectPersonNameLB;
@property (nonatomic, strong)UILabel * phoneLB;
@property (nonatomic, strong)UILabel * wechatLB;
@property (nonatomic, strong)UILabel * addressLB;
@property (nonatomic, strong)MAMapView * mapView;
@property (nonatomic, strong)UIButton * applyBtn;
@property (nonatomic, copy)void(^applyBlock)(NSDictionary * info);
@property (nonatomic, strong)NSDictionary * infoDic;
- (void)refreshUIWith:(NSDictionary *)infoDic;

@end

