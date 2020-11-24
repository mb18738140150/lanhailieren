//
//  ReplyView.m
//  Accountant
//
//  Created by aaa on 2017/6/20.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "ReplyView.h"

#define Space 5.0

#define kTopSpace 10

@implementation ReplyView


- (instancetype)initWithFrame:(CGRect)frame tipPoint:(CGPoint)toppoint andInfo:(NSDictionary *)infoDic
{
    if (self = [super initWithFrame:frame]) {
        self.point = toppoint;
        [self resetInfo:infoDic];
    }
    return self;
}

- (void)resetInfo:(NSDictionary *)infoDic{
    
    self.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(17, 20, 100, 20)];
    self.nameLabel.text = @"平台回复";
    self.nameLabel.textColor = UIColorFromRGB(0x000000);
    self.nameLabel.font = kMainFont_16;
    [self addSubview:self.nameLabel];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width - 200, 20, 180, 20)];
    self.timeLB.text = [infoDic objectForKey:@"replyTime"];
    self.timeLB.textColor = UIColorFromRGB(0x999999);
    self.timeLB.font = kMainFont;
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.timeLB];

    
    CGFloat contentHeight = [[infoDic objectForKey:@"replay"] boundingRectWithSize:CGSizeMake(self.hd_width - 24, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont_16} context:nil].size.height;
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(self.nameLabel.frame) + 15, self.hd_width - 24, contentHeight)];
    self.contentLB.textColor = UIColorFromRGB(0x666666);
    self.contentLB.text = [infoDic objectForKey:@"replay"];
    self.contentLB.font = kMainFont_16;
    self.contentLB.numberOfLines = 0;
    [self addSubview:self.contentLB];
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, kTopSpace)];
    [bezierPath addLineToPoint:CGPointMake(self.point.x - kTopSpace / 2, kTopSpace)];
    [bezierPath addLineToPoint:CGPointMake(self.point.x, 0)];
    [bezierPath addLineToPoint:CGPointMake(self.point.x + kTopSpace / 2, kTopSpace)];
    [bezierPath addLineToPoint:CGPointMake(self.hd_width, kTopSpace)];
    [bezierPath addLineToPoint:CGPointMake(self.hd_width, self.frame.size.height)];
    [bezierPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [bezierPath stroke];
    
    CAShapeLayer * layer = [[CAShapeLayer alloc]init];
    layer.frame = self.bounds;
    layer.path = bezierPath.CGPath;
    
    self.layer.mask = layer;
    
    self.height = contentHeight + 80;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
