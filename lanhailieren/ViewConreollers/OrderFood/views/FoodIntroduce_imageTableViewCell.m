//
//  FoodIntroduce_imageTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/14.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "FoodIntroduce_imageTableViewCell.h"
#import "SCPageControl.h"
@interface FoodIntroduce_imageTableViewCell()<UIScrollViewDelegate>
@property (nonatomic, strong)SCPageControl * pageControl;
@property (nonatomic, strong)UIView * backView;
@end

@implementation FoodIntroduce_imageTableViewCell


- (void)refreshUIWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    NSArray * imageArrays = [info objectForKey:@"imageArray"];
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.contentView.bounds];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.hd_width * imageArrays.count, self.hd_height);
    for (int i = 0; i < imageArrays.count; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width * i, 0, self.hd_width, self.hd_height)];
        NSString * imageUrlStr = [[NSString stringWithFormat:@"%@",[imageArrays objectAtIndex:i]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
        [self.scrollView addSubview:imageView];
    }
    [self.contentView addSubview:self.scrollView];
    
    SCPageControl *pagecontrol = [[SCPageControl alloc]init];
    pagecontrol.numberOfPages = imageArrays.count;
    pagecontrol.currentPage  = 0; //默认第一页页数为0
    //设置分页控制点颜色
    pagecontrol.pageIndicatorTintColor = [UIColor whiteColor];//未选中的颜色
    pagecontrol.currentPageIndicatorTintColor = kMainRedColor;//选中时的颜色
    //将分页控制视图添加到视图控制器视图中
    [self.contentView addSubview:pagecontrol];
    self.pageControl = pagecontrol;
    pagecontrol.frame=CGRectMake(self.hd_width / 2 - 50, self.hd_height - 30, 100, 20);
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(10, 20, 23, 23);
    [self.backBtn setImage:[UIImage imageNamed:@"ic_fooeIntroduceback"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.backBtn];
    
}

- (void)addBottomView
{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 5, self.hd_width, 5 )];
    self.backView.backgroundColor = [UIColor whiteColor];
    UIBezierPath * bezierpath = [UIBezierPath bezierPathWithRoundedRect:self.backView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
    shapLayer.frame = self.backView.bounds;
    shapLayer.path = bezierpath.CGPath;
    [self.backView.layer setMask: shapLayer];
    [self.contentView addSubview:self.backView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int itemIndex = self.scrollView.contentOffset.x / self.scrollView.hd_width;
    self.pageControl.currentPage = itemIndex;
}

- (void)backAction
{
    if (self.backFoodIntroduceBlock) {
        self.backFoodIntroduceBlock(YES);
    }
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
