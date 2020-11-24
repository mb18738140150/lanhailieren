//
//  CommodityBannerTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/10.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "CommodityBannerTableViewCell.h"
#import "UIMacro.h"
#import "MainViewMacro.h"
#import "SDCycleScrollView.h"
#import "SCPageControl.h"

@interface CommodityBannerTableViewCell ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong) SDCycleScrollView          *bannerScrollView;
@property (nonatomic, strong)UIButton * backbtn;
@property (nonatomic, strong)SCPageControl * pageControl;

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIImageView * titleImageView;
@property (nonatomic, strong)UILabel * detailsLB;


@property (nonatomic, assign)CGFloat y;
@property (nonatomic,assign)CGFloat height;

@end

@implementation CommodityBannerTableViewCell

- (void)resetSubviews
{
    [self.contentView removeAllSubviews];
    [self.backView removeFromSuperview];
    [self.titleImageView removeFromSuperview];
    [self.detailsLB removeFromSuperview];
    [self.bannerScrollView removeFromSuperview];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backbtn.frame = CGRectMake(10, 20, 23, 23);
    [self.backbtn setImage:[UIImage imageNamed:@"ic_fooeIntroduceback"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.backbtn];
    [self.backbtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(self.hd_width / 2 - 82, 20, 164, 111) imageNamesGroup:self.bannerImgUrlArray];
    self.bannerScrollView.showPageControl = NO;
    self.bannerScrollView.delegate = self;
    self.bannerScrollView.autoScrollTimeInterval = 10;
    [self.contentView addSubview:self.bannerScrollView];
    
    SCPageControl *pagecontrol = [[SCPageControl alloc]init];
    pagecontrol.numberOfPages = self.bannerImgUrlArray.count;
    pagecontrol.currentPage  = 0; //默认第一页页数为0
    //设置分页控制点颜色
    pagecontrol.pageIndicatorTintColor = [UIColor blackColor];//未选中的颜色
    pagecontrol.currentPageIndicatorTintColor = kMainRedColor;//选中时的颜色
    //添加分页控制事件用来分页
    //[self.pagecontrol addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    //将分页控制视图添加到视图控制器视图中
    [self.contentView addSubview:pagecontrol];
    self.pageControl = pagecontrol;
    pagecontrol.frame=CGRectMake(self.bannerScrollView.hd_centerX - 50, CGRectGetMaxY(self.bannerScrollView.frame) + 5, 100, 30);
//    pagecontrol.backgroundColor=[UIColor yellowColor];
    
//    [pagecontrol setValue:[UIImage imageNamed:@"index_sublunbo_black"] forKeyPath:@"_currentPageImage"];
//    [pagecontrol setValue:[UIImage imageNamed:@"index_sublunbo_white"] forKeyPath:@"_pageImage"];
    
}

- (void)backAction
{
    if (self.backBtnClickBlock) {
        self.backBtnClickBlock();
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    self.pageControl.currentPage = index;
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
