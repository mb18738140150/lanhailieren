//
//  FoodMakeCommentTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/4/16.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "FoodMakeCommentTableViewCell.h"
#import "WFTextView.h"

@interface FoodMakeCommentTableViewCell()

@property (nonatomic, strong)UIView * repalyView;

@end

@implementation FoodMakeCommentTableViewCell


- (void)refreshUIWith:(YMTextData *)ymData
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    NSDictionary * infoDic = ymData.infoDic;
    self.info = ymData.infoDic;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 25, 25)];
    self.iconImageView.layer.cornerRadius = self.iconImageView.hd_height / 2;
    self.iconImageView.layer.masksToBounds = YES;
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[infoDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[infoDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"] options:SDWebImageAvoidDecodeImage];
    
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, self.iconImageView.hd_y, self.hd_width - 60, self.iconImageView.hd_height)];
    self.titleLB.font = kMainFont_12;
    self.titleLB.textColor = UIColorFromRGB(0x333333);
    self.titleLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"title"]];
    [self.contentView addSubview:self.titleLB];
    
    NSString * content = [infoDic objectForKey:@"content"];
    CGFloat contentHeight = [content boundingRectWithSize:CGSizeMake(self.hd_width - 55, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont_12} context:nil].size.height + 5;
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.iconImageView.frame) + 5, self.hd_width - 55, contentHeight)];
    self.contentLB.textColor = UIColorFromRGB(0x000000);
    self.contentLB.font = kMainFont_12;
    self.contentLB.text = content;
    self.contentLB.numberOfLines = 0;
    [self.contentView addSubview:self.contentLB];
    
    self.timeLb = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.contentLB.frame) + 10, 120, 15)];
    self.timeLb.font = kMainFont_10;
    self.timeLb.textColor = UIColorFromRGB(0x999999);
    self.timeLb.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"time"]];
    [self.contentView addSubview:self.timeLb];
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.frame = CGRectMake(CGRectGetMaxX(self.timeLb.frame) , self.timeLb.hd_y - 2.5, 40, 20);
    [self.commentBtn setTitle:@"回复" forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    self.commentBtn.titleLabel.font = kMainFont_12;
    [self.contentView addSubview:self.commentBtn];
    [self.commentBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.repalyView = [[UIView alloc]initWithFrame:CGRectMake(self.timeLb.hd_x, CGRectGetMaxY(self.timeLb.frame) + 15, self.hd_width - 60, ymData.replyHeight)];
    self.repalyView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    self.repalyView.layer.cornerRadius = 3;
    self.repalyView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.repalyView];
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(self.repalyView.hd_x + 8, self.repalyView.hd_y - 7, 14, 7)];
    topView.backgroundColor = [UIColor clearColor];
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(topView.hd_x, self.repalyView.hd_y)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMidX(topView.frame), topView.hd_y)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMaxX(topView.frame), self.repalyView.hd_y)];
    [bezierPath closePath];
    CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
    shapLayer.frame = topView.bounds;
    shapLayer.path = bezierPath.CGPath;
    shapLayer.fillColor = UIColorFromRGB(0xf4f4f4).CGColor;
    [topView.layer setMask:shapLayer];
    [self.contentView addSubview:topView];
    
    float origin_Y = 5;
    for (int i = 0; i < ymData.replyDataSource.count; i ++ ) {
        
        WFTextView *_ilcoreText = [[WFTextView alloc] initWithFrame:CGRectMake(10,origin_Y, kScreenWidth - 80, 0)];
        
//        _ilcoreText.delegate = self;
        _ilcoreText.replyIndex = i;
        _ilcoreText.isFold = NO;
        _ilcoreText.attributedData = [ymData.attributedDataReply objectAtIndex:i];
        _ilcoreText.textColor = UIColorFromRGB(0x666666);
        WFReplyBody *body = (WFReplyBody *)[ymData.replyDataSource objectAtIndex:i];
        
        NSString *matchString;
        
        if ([body.repliedUser isEqualToString:@""]) {
            matchString = [NSString stringWithFormat:@"%@:%@",body.replyUser,body.replyInfo];
            
        }else{
            matchString = [NSString stringWithFormat:@"%@回复%@:%@",body.replyUser,body.repliedUser,body.replyInfo];
        }
        
        [_ilcoreText setOldString:matchString andNewString:[ymData.completionReplySource objectAtIndex:i]];
        
        _ilcoreText.frame = CGRectMake(10,origin_Y, kScreenWidth - 80, [_ilcoreText getTextHeight]);
        [self.repalyView addSubview:_ilcoreText];
        
        origin_Y += [_ilcoreText getTextHeight] + 5 ;
        
    }
    
    [self setNeedsDisplay];
}

- (void)commentAction
{
    if (self.commentBlock) {
        self.commentBlock(self.info);
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
