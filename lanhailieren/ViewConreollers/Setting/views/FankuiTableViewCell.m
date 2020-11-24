//
//  FankuiTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/9.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "FankuiTableViewCell.h"


@implementation FankuiTableViewCell

- (void)refreshUIWith:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.infoDic = infoDic;
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 16, 16)];
    self.iconImageView.image = [UIImage imageNamed:@"wxp_a_y"];
    [self.contentView addSubview:self.iconImageView];
    
    self.tipLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, 13, 100, 20)];
    self.tipLB.textColor = UIColorFromRGB(0x000000);
    self.tipLB.font = kMainFont_16;
    [self.contentView addSubview:self.tipLB];
    self.tipLB.text = @"反馈问题";
    
    self.seperateLine = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.iconImageView.frame) + 15, self.hd_width - 30, 1)];
    self.seperateLine.backgroundColor = UIColorFromRGB(0xededed);
    [self.contentView addSubview:self.seperateLine];
    
    NSString * content = [infoDic objectForKey:@"content"];
    CGSize contentSize = [content boundingRectWithSize:CGSizeMake(self.hd_width - 50, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont_16} context:nil].size;
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(self.seperateLine.frame) + 15,self.hd_width - 50 , contentSize.height)];
    self.contentLB.text = [infoDic objectForKey:@"content"];
    self.contentLB.numberOfLines = 0;
    self.contentLB.font = kMainFont_16;
    self.contentLB.textColor = UIColorFromRGB(0x000000);
    [self.contentView addSubview:self.contentLB];
    
    NSArray *imgs = [infoDic objectForKey:kQuestionImgStr];
    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(27, CGRectGetMaxY(self.contentLB.frame) + 10, 60, 60)];
    self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame) + 20, self.imageView1.hd_y , 60, 60)];
    self.imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(140, self.imageView1.hd_y, 60, 60)];
    if (imgs.count == 1) {
        [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:imgs[0]]];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
        [self.imageView1 addGestureRecognizer:tap1];
        self.imageView1.userInteractionEnabled = YES;
        [self.contentView addSubview:self.imageView1];
    }
    if (imgs.count == 2) {
        [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:imgs[0]]];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
        [self.imageView1 addGestureRecognizer:tap1];
        self.imageView1.userInteractionEnabled = YES;
        
        [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:imgs[1]]];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)];
        [self.imageView2 addGestureRecognizer:tap2];
        self.imageView2.userInteractionEnabled = YES;
        
        [self.contentView addSubview:self.imageView1];
        [self.contentView addSubview:self.imageView2];
    }
    if (imgs.count == 3) {
        [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:imgs[0]]];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
        [self.imageView1 addGestureRecognizer:tap1];
        self.imageView1.userInteractionEnabled = YES;
        
        [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:imgs[1]]];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)];
        [self.imageView2 addGestureRecognizer:tap2];
        self.imageView2.userInteractionEnabled = YES;
        
        [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:imgs[2]]];
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3)];
        [self.imageView3 addGestureRecognizer:tap3];
        self.imageView3.userInteractionEnabled = YES;
        
        [self.contentView addSubview:self.imageView1];
        [self.contentView addSubview:self.imageView2];
        [self.contentView addSubview:self.imageView3];
    }
    
    
    CGFloat contentHeight = [[infoDic objectForKey:@"replay"] boundingRectWithSize:CGSizeMake(self.hd_width - 24 - 55, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont_16} context:nil].size.height;
    
    if ([[infoDic objectForKey:@"replay"] length] > 0) {
        if (imgs.count > 0) {
            self.replayView = [[ReplyView alloc]initWithFrame:CGRectMake(28, CGRectGetMaxY(self.imageView1.frame) + 10, self.hd_width - 55, contentHeight + 70) tipPoint:CGPointMake(self.contentLB.hd_x + 25, 0) andInfo:infoDic];
        }else
        {
            self.replayView = [[ReplyView alloc]initWithFrame:CGRectMake(28, CGRectGetMaxY(self.contentLB.frame) + 10, self.hd_width - 55, contentHeight + 70) tipPoint:CGPointMake(self.contentLB.hd_x + 25, 0) andInfo:infoDic];
        }
        [self.contentView addSubview:self.replayView];
    }
    
    UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.hd_height - 5, self.contentView.hd_width, 5)];
    bottomLine.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.contentView addSubview:bottomLine];
}

- (void)tap1
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfQuestionImageClick object:self.imageView1.image];
}

- (void)tap2
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfQuestionImageClick object:self.imageView2.image];
}

- (void)tap3
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfQuestionImageClick object:self.imageView3.image];
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
