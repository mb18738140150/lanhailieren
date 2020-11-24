//
//  Head_categoryCollectionReusableView.m
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "Head_categoryCollectionReusableView.h"

@implementation Head_categoryCollectionReusableView

- (void)refreshUIWith:(NSDictionary *)info
{
    [self removeAllSubviews];
    self.backgroundColor = [UIColor clearColor];
    
    NSArray * dataArray = [info objectForKey:@"dataArray"];
     float categoryView_width = 70;
    if (IS_PAD) {
        
        self.bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.hd_width, self.hd_width * 0.25) imageNamesGroup:self.bannerImgUrlArray];
        self.bannerScrollView.showPageControl = YES;
        self.bannerScrollView.delegate = self;
        self.bannerScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        self.bannerScrollView.autoScrollTimeInterval = 10;
        [self addSubview:self.bannerScrollView];
        
        
        __weak typeof(self)weakSelf = self;
        
        float seperate = (self.hd_width - dataArray.count * categoryView_width) / (dataArray.count + 1);
        seperate = 30;
        CGFloat seperateLeft = (self.hd_width - dataArray.count * categoryView_width - (dataArray.count - 1) * seperate) / 2;
        if (seperateLeft < 50) {
            seperateLeft = seperate;
        }
        
        UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerScrollView.frame) + 8, self.hd_width, categoryView_width)];
        [self addSubview: scrollView];
        scrollView.contentSize = CGSizeMake(seperateLeft * 2 + dataArray.count * categoryView_width + (dataArray.count - 1) * seperate, categoryView_width);
        
        for (int i = 0; i < dataArray.count; i++) {
            NSDictionary * info = [dataArray objectAtIndex:i];
            FishCategoryView * categoryView = [[FishCategoryView alloc]initWithFrame:CGRectMake(seperateLeft + seperate * (i) + categoryView_width * i , 0, categoryView_width, categoryView_width)];
            [categoryView refrehUIWithInfo:info];
            [scrollView addSubview:categoryView];
            
            categoryView.FishCategoryClickBlock = ^(NSDictionary *info) {
                if (weakSelf.FishCategory_headClickBlock) {
                    weakSelf.FishCategory_headClickBlock(info);
                }
            };
        }
        
        UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 5, self.hd_width, 5)];
        seperateView.backgroundColor = UIColorFromRGB(0xf7f7f7);
        self.seperateView = seperateView;
        [self addSubview:seperateView];
    }else
    {
        
        self.bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.hd_width, self.hd_width * 0.42) imageNamesGroup:self.bannerImgUrlArray];
        self.bannerScrollView.placeholderImage = [UIImage imageNamed:@"placeholdImage"];
        self.bannerScrollView.showPageControl = YES;
        self.bannerScrollView.delegate = self;
        self.bannerScrollView.autoScrollTimeInterval = 10;
        self.bannerScrollView.layer.cornerRadius = 3;
        self.bannerScrollView.layer.masksToBounds = YES;
        [self addSubview:self.bannerScrollView];
        
        __weak typeof(self)weakSelf = self;
        
        if (self.maxItem == 0) {
            self.maxItem = 4;
        }
        
        float seperate = (self.hd_width - self.maxItem * categoryView_width) / 5;
        
        for (int i = 0; i < dataArray.count; i++) {
            NSDictionary * info = [dataArray objectAtIndex:i];
            FishCategoryView * categoryView = [[FishCategoryView alloc]initWithFrame:CGRectMake(seperate * (i + 1) + categoryView_width * i , CGRectGetMaxY(self.bannerScrollView.frame) + 10, categoryView_width, categoryView_width)];
            if ((i/_maxItem) > 0) {
                categoryView.frame = CGRectMake(seperate * (i- _maxItem*(i/_maxItem) + 1) + categoryView_width * (i - _maxItem*(i/_maxItem)) , CGRectGetMaxY(self.bannerScrollView.frame) + 10 + (categoryView_width + 5) * ((i/_maxItem)), categoryView_width, categoryView_width);
            }
            [categoryView refrehUIWithInfo:info];
            [self addSubview:categoryView];
            
            categoryView.FishCategoryClickBlock = ^(NSDictionary *info) {
                if (weakSelf.FishCategory_headClickBlock) {
                    weakSelf.FishCategory_headClickBlock(info);
                }
            };
        }
    }
    
}

- (void)hideSeperateView
{
    self.seperateView.hidden = YES;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
//    self.pageControl.currentPage = index;
}

@end
