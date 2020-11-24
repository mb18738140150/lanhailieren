//
//  TeamContestTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/4/22.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "TeamContestTableViewCell.h"

@implementation TeamContestTableViewCell


- (void)refreshUIWith:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.hd_width, 15)];
    self.titleLB.textColor = UIColorFromRGB(0x000000);
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.font = kMainFont;
    self.titleLB.text = [info objectForKey:@"title"];
    [self.contentView addSubview:self.titleLB];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLB.frame) + 5, self.hd_width, 15)];
    self.timeLB.textColor = UIColorFromRGB(0x999999);
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    self.timeLB.text = [info objectForKey:@"time"];
    self.timeLB.font = kMainFont_12;
    [self.contentView addSubview: self.timeLB];
    
    self.seperateLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width / 2 - 3, CGRectGetMaxY(self.titleLB.frame) , 6, self.hd_height - CGRectGetMaxY(self.titleLB.frame))];
    self.seperateLB.textAlignment = NSTextAlignmentCenter;
    self.seperateLB.text = @":";
    [self.contentView addSubview:self.seperateLB];
    
    NSDictionary * attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:30]};
    
    NSString * score1 = [NSString stringWithFormat:@"%@", [info objectForKey:@"score1"]];
    float score1Width = [score1 boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 60) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width;
    NSString * score2 = [NSString stringWithFormat:@"%@", [info objectForKey:@"score2"]];
    float score2Width = [score2 boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 60) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width;
    
    if (score1Width > score2Width) {
        score2Width = score1Width;
    }else
    {
        score1Width = score2Width;
    }
    
    self.scoreLB1 = [[UILabel alloc]initWithFrame:CGRectMake(self.seperateLB.hd_x - 20 - score1Width - 40, CGRectGetMidY(self.seperateLB.frame) - 25, score1Width + 40, 60)];
    self.scoreLB1.text = score1;
    self.scoreLB1.textAlignment = NSTextAlignmentCenter;
    self.scoreLB1.font = [UIFont systemFontOfSize:30];
    self.scoreLB1.textColor = UIColorFromRGB(0xc40000);
    self.scoreLB1.layer.cornerRadius = 3.3;
    self.scoreLB1.layer.masksToBounds = YES;
    self.scoreLB1.layer.borderWidth = 1;
    self.scoreLB1.layer.borderColor = UIColorFromRGB(0xc40000).CGColor;
    [self.contentView addSubview:self.scoreLB1];
    
    self.scoreLB2 = [[UILabel alloc]initWithFrame:CGRectMake(self.seperateLB.hd_x+ 6 + 20, CGRectGetMidY(self.seperateLB.frame) - 25, score2Width + 40, 60)];
    self.scoreLB2.text = score2;
    self.scoreLB2.textAlignment = NSTextAlignmentCenter;
    self.scoreLB2.font = [UIFont systemFontOfSize:30];
    self.scoreLB2.textColor = UIColorFromRGB(0x333333);
    self.scoreLB2.layer.cornerRadius = 3.3;
    self.scoreLB2.layer.masksToBounds = YES;
    self.scoreLB2.layer.borderWidth = 1;
    self.scoreLB2.layer.borderColor = UIColorFromRGB(0x333333).CGColor;
    [self.contentView addSubview:self.scoreLB2];
    
    self.team1 = [[TeamIntrolView alloc]initWithFrame:CGRectMake(self.scoreLB1.hd_x - 140, CGRectGetMidY(self.scoreLB1.frame) - 62, 108, 124) andInfo:@{@"title":@"四川队",@"image":@"http://wimg.spriteapp.cn/picture/2016/0709/5781023a2e6a2__b_35.jpg"}];
    
    self.team2 = [[TeamIntrolView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.scoreLB2.frame) + 32, CGRectGetMidY(self.scoreLB2.frame) - 62, 108, 124) andInfo:@{@"title":@"xx队",@"image":@"http://wimg.spriteapp.cn/picture/2016/0709/5781023a2e6a2__b_35.jpg"}];
    
    if (!IS_PAD) {
        attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:20]};
        NSString * score1 = [NSString stringWithFormat:@"%@", [info objectForKey:@"score1"]];
        float score1Width = [score1 boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 60) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width;
        NSString * score2 = [NSString stringWithFormat:@"%@", [info objectForKey:@"score2"]];
        float score2Width = [score2 boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 60) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width;
        
        if (score1Width > score2Width) {
            score2Width = score1Width;
        }else
        {
            score1Width = score2Width;
        }
        
        self.scoreLB1.frame = CGRectMake(self.seperateLB.hd_x - 10 - score1Width - 10, CGRectGetMidY(self.seperateLB.frame) - 20, score1Width + 10, 50);
        self.scoreLB1.font = [UIFont systemFontOfSize:20];
        self.scoreLB2.frame = CGRectMake(self.seperateLB.hd_x+ 6 + 10, CGRectGetMidY(self.seperateLB.frame) - 20, score2Width + 10, 50);
        self.scoreLB2.font = [UIFont systemFontOfSize:20];
        
        self.team1 = [[TeamIntrolView alloc]initWithFrame:CGRectMake(self.scoreLB1.hd_x - 104, CGRectGetMidY(self.scoreLB1.frame) - 50, 94, 100) andInfo:@{@"title":@"四川队",@"image":@"http://wimg.spriteapp.cn/picture/2016/0709/5781023a2e6a2__b_35.jpg"}];
        
        self.team2 = [[TeamIntrolView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.scoreLB2.frame) + 10, CGRectGetMidY(self.scoreLB2.frame) - 50, 94, 100) andInfo:@{@"title":@"xx队",@"image":@"http://wimg.spriteapp.cn/picture/2016/0709/5781023a2e6a2__b_35.jpg"}];
    }
    
    [self.contentView addSubview:self.team1];
    [self.contentView addSubview:self.team2];
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
