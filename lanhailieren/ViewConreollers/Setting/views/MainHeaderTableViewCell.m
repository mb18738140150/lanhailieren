//
//  MainHeaderTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/3/6.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "MainHeaderTableViewCell.h"
#import "OrderStrateView.h"

@interface MainHeaderTableViewCell()

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * nameLB;
@property (nonatomic, strong)UIImageView * vipView;
@property (nonatomic, strong)UIButton * monryBtn;
@property (nonatomic, strong)UIButton * integerBtn;
@property (nonatomic, strong)UIButton * orderBtn;
@property (nonatomic, strong)UIButton * checkAllBtn;

@property (nonatomic, strong)OrderStrateView * nop_a_yView;
@property (nonatomic, strong)OrderStrateView * noSendView;
@property (nonatomic, strong)OrderStrateView * noReceivView;
@property (nonatomic, strong)OrderStrateView * complateView;
@property (nonatomic, strong)OrderStrateView * afterView;

@end

@implementation MainHeaderTableViewCell

- (void)refreshUIWithInfo:(NSDictionary *)info
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    self.contentView.frame = self.bounds;
    self.backgroundColor = [UIColor clearColor];
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 75, self.hd_width, 280)];
    backView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:backView];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    NSString * str = kRootImageUrl;;
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width / 2 - 37, 37, 75, 75)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", str,[info objectForKey:kUserHeaderImageUrl]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    self.iconImageView.layer.cornerRadius = self.iconImageView.hd_width / 2;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderWidth = 3;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.contentView addSubview:self.iconImageView];
    
    NSString * nameStr =[info objectForKey:kUserName];
    float width = [nameStr boundingRectWithSize:CGSizeMake(kScreenWidth, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.width;
    self.nameLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width / 2 - width / 2 - 10, CGRectGetMaxY(self.iconImageView.frame) + 20, width, 20)];
    self.nameLB.font = [UIFont systemFontOfSize:16];
    self.nameLB.text = nameStr;
    self.nameLB.textAlignment = NSTextAlignmentCenter;
    self.nameLB.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.nameLB];
    
    self.vipView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLB.frame) + 5, self.nameLB.hd_y + 3, 15, 15)];
    self.vipView.image = [UIImage imageNamed:@"ic_my_vip"];
    [self.contentView addSubview:self.vipView];
    
    self.monryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.monryBtn.frame = CGRectMake(self.hd_width / 2 - 128, CGRectGetMaxY(self.nameLB.frame) + 20, 128, 35);
    self.monryBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.monryBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    self.monryBtn.titleLabel.font = kMainFont;
    self.monryBtn.titleLabel.numberOfLines = 0;
    NSString * moneyStr = [NSString stringWithFormat:@"%@\n余额",[info objectForKey:kAmount]];
    NSMutableAttributedString *moneyStr_m = [[NSMutableAttributedString alloc]initWithString:moneyStr];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0x888888)};
    [moneyStr_m addAttributes:attribute range:NSMakeRange(moneyStr.length - 2, 2)];
    [self.monryBtn setAttributedTitle:moneyStr_m forState:UIControlStateNormal];
    [self.contentView addSubview:self.monryBtn];
    
    UIView * seperateLine = [[UIView alloc]initWithFrame:CGRectMake(self.hd_width / 2, self.monryBtn.hd_y + 2, 1, 30)];
    seperateLine.backgroundColor = UIColorFromRGB(0xdadada);
    [self.contentView addSubview:seperateLine];
    
    self.integerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.integerBtn.frame = CGRectMake(self.hd_width / 2 + 1, self.monryBtn.hd_y, 128, 35);
    self.integerBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.integerBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    self.integerBtn.titleLabel.numberOfLines = 0;
    self.integerBtn.titleLabel.font = kMainFont;
    NSString * integerStr = [NSString stringWithFormat:@"%@\n积分",[info objectForKey:kPoint]];
    NSMutableAttributedString *integerStr_m = [[NSMutableAttributedString alloc]initWithString:integerStr];
    [integerStr_m addAttributes:attribute range:NSMakeRange(integerStr.length - 2, 2)];
    [self.integerBtn setAttributedTitle:integerStr_m forState:UIControlStateNormal];
    [self.contentView addSubview:self.integerBtn];
    
    self.orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.orderBtn.frame = CGRectMake(15, CGRectGetMaxY(self.monryBtn.frame) + 20, 100, 20);
    [self.orderBtn setTitle:@"我的订单" forState:UIControlStateNormal];
    [self.orderBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    self.orderBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.orderBtn];
    
    self.checkAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.checkAllBtn.frame = CGRectMake(self.hd_width - 100, self.orderBtn.hd_y, 70, 20);
    self.checkAllBtn.titleLabel.font = kMainFont;
    self.checkAllBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.checkAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [self.checkAllBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [self.contentView addSubview:self.checkAllBtn];
    [self.checkAllBtn addTarget:self action:@selector(checkAllOrderAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * goImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.checkAllBtn.frame) + 5, self.checkAllBtn.hd_y + 2, 15, 15)];
    goImageView.image = [UIImage imageNamed:@"main_go"];
    [self.contentView addSubview:goImageView];
    
    if (IS_PAD) {
        [self addiPadStateView];
    }else
    {
        [self addiPhoneStateView];
    }
}

- (void)addiPadStateView
{
    float seperateWidth = (self.hd_width * 0.64 - 200) / 4;
    
    self.nop_a_yView = [[OrderStrateView alloc]initWithFrame:CGRectMake(self.hd_width * 0.18, CGRectGetMaxY(self.orderBtn.frame) + 35, 40, 45) andInfo:@{@"image":@"ic_order_all",@"title":@"全部"}];
    [self.contentView addSubview:self.nop_a_yView];
    
    self.noSendView = [[OrderStrateView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nop_a_yView.frame) + seperateWidth, CGRectGetMaxY(self.orderBtn.frame) + 35, 40, 45) andInfo:@{@"image":@"ic_order_p_a_y",@"title":@"待付款"}];
    [self.contentView addSubview:self.noSendView];
    
    self.noReceivView = [[OrderStrateView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.noSendView.frame) + seperateWidth, CGRectGetMaxY(self.orderBtn.frame) + 35, 40, 45) andInfo:@{@"image":@"ic_order_delivery",@"title":@"待发货"}];
    [self.contentView addSubview:self.noReceivView];
    
    self.complateView = [[OrderStrateView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.noReceivView.frame) + seperateWidth, CGRectGetMaxY(self.orderBtn.frame) + 35, 40, 45) andInfo:@{@"image":@"ic_order_goods",@"title":@"待收货"}];
    [self.contentView addSubview:self.complateView];
    
    self.afterView = [[OrderStrateView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.complateView.frame) + seperateWidth, CGRectGetMaxY(self.orderBtn.frame) + 35, 40, 45) andInfo:@{@"image":@"ic_oeder_complete",@"title":@"已完成"}];
    [self.contentView addSubview:self.afterView];
    
    __weak typeof(self)weakSelf = self;
    self.nop_a_yView.ClickBlock = ^(NSDictionary *info) {
        [weakSelf clickWithInfo:info];
    };
    
    self.noSendView.ClickBlock = ^(NSDictionary *info) {
        [weakSelf clickWithInfo:info];
    };
    
    self.noReceivView.ClickBlock = ^(NSDictionary *info) {
        [weakSelf clickWithInfo:info];
    };
    
    self.complateView.ClickBlock = ^(NSDictionary *info) {
        [weakSelf clickWithInfo:info];
    };
    
    self.afterView.ClickBlock = ^(NSDictionary *info) {
        [weakSelf clickWithInfo:info];
    };
    
    
}
- (void)addiPhoneStateView
{
    float seperateWidth = (self.hd_width  - 200) / 6;
    
    self.nop_a_yView = [[OrderStrateView alloc]initWithFrame:CGRectMake(seperateWidth, CGRectGetMaxY(self.orderBtn.frame) + 35, 40, 45) andInfo:@{@"image":@"ic_order_all",@"title":@"全部",@"orderState":@(0)}];
    [self.contentView addSubview:self.nop_a_yView];
    
    self.noSendView = [[OrderStrateView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nop_a_yView.frame) + seperateWidth, CGRectGetMaxY(self.orderBtn.frame) + 35, 40, 45) andInfo:@{@"image":@"ic_order_p_a_y",@"title":@"待付款",@"orderState":@(1)}];
    [self.contentView addSubview:self.noSendView];
    
    self.noReceivView = [[OrderStrateView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.noSendView.frame) + seperateWidth, CGRectGetMaxY(self.orderBtn.frame) + 35, 40, 45) andInfo:@{@"image":@"ic_order_delivery",@"title":@"待发货",@"orderState":@(2)}];
    [self.contentView addSubview:self.noReceivView];
    
    self.complateView = [[OrderStrateView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.noReceivView.frame) + seperateWidth, CGRectGetMaxY(self.orderBtn.frame) + 35, 40, 45) andInfo:@{@"image":@"ic_order_goods",@"title":@"待收货",@"orderState":@(3)}];
    [self.contentView addSubview:self.complateView];
    
    self.afterView = [[OrderStrateView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.complateView.frame) + seperateWidth, CGRectGetMaxY(self.orderBtn.frame) + 35, 40, 45) andInfo:@{@"image":@"ic_oeder_complete",@"title":@"已完成",@"orderState":@(4)}];
    [self.contentView addSubview:self.afterView];
    
    __weak typeof(self)weakSelf = self;
    self.nop_a_yView.ClickBlock = ^(NSDictionary *info) {
        [weakSelf clickWithInfo:info];
    };
    
    self.noSendView.ClickBlock = ^(NSDictionary *info) {
        [weakSelf clickWithInfo:info];
    };
    
    self.noReceivView.ClickBlock = ^(NSDictionary *info) {
        [weakSelf clickWithInfo:info];
    };
    
    self.complateView.ClickBlock = ^(NSDictionary *info) {
        [weakSelf clickWithInfo:info];
    };
    
    self.afterView.ClickBlock = ^(NSDictionary *info) {
        [weakSelf clickWithInfo:info];
    };
    
}

- (void)clickWithInfo:(NSDictionary *)info
{
    if (self.stateBlock) {
        self.stateBlock(info);
    }
}

- (void)checkAllOrderAction
{
    if (self.stateBlock) {
        self.stateBlock(@{@"image":@"ic_order_all",@"title":@"全部",@"orderState":@(0)});
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
