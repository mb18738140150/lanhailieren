//
//  FisheryHarvestTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/4/21.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "FisheryHarvestTableViewCell.h"

@implementation FisheryHarvestTableViewCell

- (void)refreshUIWithInfo:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.frame = self.bounds;
    self.info = info;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(7, 8, (self.hd_height - 17) * 2.1, self.hd_height - 17)];
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[info objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[info objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"] options:SDWebImageAvoidDecodeImage];
    
    self.iconImageView.layer.cornerRadius = 3.3;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 12, self.iconImageView.hd_y + 5, self.hd_width - 200, 20)];
    self.titleLB.text = [info objectForKey:@"title"];
    self.titleLB.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.titleLB];
    
    self.countLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 12, CGRectGetMaxY(self.titleLB.frame) + 5, self.hd_width - 200, 20)];
    self.countLB.textColor = UIColorFromRGB(0x999999);
    self.countLB.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"zhaiyao"]];
    self.countLB.font = kMainFont_12;
    [self.contentView addSubview:self.countLB];
    
    
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.hd_height - 1, self.hd_width, 1)];
    seperateView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.contentView addSubview:seperateView];
}

+ (void)loadImage:(NSDictionary *)info
{
//    [FisheryHarvestTableViewCell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRootImageUrl,[info objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
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
