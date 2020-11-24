//
//  FoodMakeCommentTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/4/16.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFReplyBody.h"
#import "YMTextData.h"
#import "WFMessageBody.h"
#import "WFTextView.h"

@interface FoodMakeCommentTableViewCell : UITableViewCell<WFCoretextDelegate>

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * contentLB;
@property (nonatomic, strong)UILabel * timeLb;
@property (nonatomic, strong)UIButton * commentBtn;

@property (nonatomic, strong)NSDictionary * info;
@property (nonatomic, copy)void(^commentBlock)(NSDictionary * info);

- (void)refreshUIWith:(YMTextData *)ymData;

@end

