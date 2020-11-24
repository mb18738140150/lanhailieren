//
//  CustomView.m
//  lanhailieren
//
//  Created by aaa on 2020/4/16.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "CustomView.h"
#import "MKPPlaceholderTextView.h"
#import "CGXPickerView.h"


@interface CustomView()<UITextViewDelegate>

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UITextField * nameLB;
@property (nonatomic, strong)UITextField * phoneLB;
@property (nonatomic, strong)UITextField * wexinLB;
@property (nonatomic, strong)UITextField * birthdayLB;

@property (nonatomic, strong)MKPPlaceholderTextView * opinionTextView;
@property (nonatomic, strong)UIButton * commitBtn;

@property (nonatomic, strong)UIButton * closeBtn;
@property (nonatomic, assign)BOOL isjoin;

@end

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame withJopinClub:(BOOL)isjoin
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isjoin = isjoin;
        [self prepareHomeJoinClubUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareHomeCustomUI];
    }
    return self;
}

- (void)prepareHomeJoinClubUI
{
    
    UIView * backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.7];
    [self addSubview:backView];
    
    UIControl *resignControl = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [resignControl addTarget:self action:@selector(resignTextFiled) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:resignControl];
    
    UIView * backWhiteView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 160, kScreenHeight / 2 - 150 , 320, 310)];
    if (!IS_PAD) {
        backWhiteView.frame = CGRectMake(50, kScreenHeight / 2 - 150 , kScreenWidth - 100, 300);
    }
    backWhiteView.backgroundColor = [UIColor whiteColor];
    backWhiteView.layer.cornerRadius = 5;
    backWhiteView.layer.masksToBounds = YES;
    [self addSubview:backWhiteView];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(backWhiteView.frame) - 47, backWhiteView.hd_y - 47, 95, 95)];
    self.iconImageView.image = [UIImage imageNamed:@"icon_custom"];
    [self addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, backWhiteView.hd_width, 15)];
    self.titleLB.text = @"申请入会";
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.font = kMainFont;
    self.titleLB.textColor = UIColorFromRGB(0x333333);
    [backWhiteView addSubview:self.titleLB];
    
    NSDictionary * attribute = @{NSFontAttributeName:kMainFont_12,NSForegroundColorAttributeName:UIColorFromRGB(0x999999)};
    
    UIView * nameView = [[UIView alloc]initWithFrame:CGRectMake(36, CGRectGetMaxY(self.titleLB.frame) + 22, backWhiteView.hd_width - 72, 25)];
    nameView.backgroundColor = [UIColor whiteColor];
    nameView.layer.cornerRadius = nameView.hd_height / 2;
    nameView.layer.masksToBounds = YES;
    nameView.layer.borderWidth = 1;
    nameView.layer.borderColor = UIColorFromRGB(0xdedede).CGColor;
    [backWhiteView addSubview:nameView];
    
    self.nameLB = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, nameView.hd_width - 30, nameView.hd_height)];
    self.nameLB.textColor = UIColorFromRGB(0x333333);
    self.nameLB.font = kMainFont_12;
    //    self.nameLB.placeholder = @"请填写姓名";
    NSString * str = @"请填写姓名";
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:@"请填写姓名"];
    [mStr addAttributes:attribute range:NSMakeRange(0, str.length)];
    self.nameLB.attributedPlaceholder = mStr;
    [nameView addSubview:self.nameLB];
    
    UIView * phoneView = [[UIView alloc]initWithFrame:CGRectMake(36, CGRectGetMaxY(nameView.frame) + 13, backWhiteView.hd_width - 72, 25)];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.layer.cornerRadius = phoneView.hd_height / 2;
    phoneView.layer.masksToBounds = YES;
    phoneView.layer.borderWidth = 1;
    phoneView.layer.borderColor = UIColorFromRGB(0xdedede).CGColor;
    [backWhiteView addSubview:phoneView];
    
    self.phoneLB = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, phoneView.hd_width - 30, phoneView.hd_height)];
    self.phoneLB.textColor = UIColorFromRGB(0x333333);
    self.phoneLB.font = kMainFont_12;
    self.phoneLB.placeholder = @"请填写联系方式";
    NSString * str1 = @"请填写联系方式";
    NSMutableAttributedString * mStr1 = [[NSMutableAttributedString alloc]initWithString:@"请填写联系方式"];
    [mStr1 addAttributes:attribute range:NSMakeRange(0, str1.length)];
    self.phoneLB.attributedPlaceholder = mStr1;
    [phoneView addSubview:self.phoneLB];
    
    UIView * wexinView = [[UIView alloc]initWithFrame:CGRectMake(36, CGRectGetMaxY(phoneView.frame) + 13, backWhiteView.hd_width - 72, 25)];
    wexinView.backgroundColor = [UIColor whiteColor];
    wexinView.layer.cornerRadius = phoneView.hd_height / 2;
    wexinView.layer.masksToBounds = YES;
    wexinView.layer.borderWidth = 1;
    wexinView.layer.borderColor = UIColorFromRGB(0xdedede).CGColor;
    [backWhiteView addSubview:wexinView];
    
    self.wexinLB = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, phoneView.hd_width - 30, phoneView.hd_height)];
    self.wexinLB.textColor = UIColorFromRGB(0x333333);
    self.wexinLB.font = kMainFont_12;
    self.wexinLB.placeholder = @"请填写微信号";
    NSString * str2 = @"请填写微信号";
    NSMutableAttributedString * mStr2 = [[NSMutableAttributedString alloc]initWithString:@"请填写微信号"];
    [mStr2 addAttributes:attribute range:NSMakeRange(0, str2.length)];
    self.wexinLB.attributedPlaceholder = mStr2;
    [wexinView addSubview:self.wexinLB];
    
    UIView * birthdayView = [[UIView alloc]initWithFrame:CGRectMake(36, CGRectGetMaxY(wexinView.frame) + 13, backWhiteView.hd_width - 72, 25)];
    birthdayView.backgroundColor = [UIColor whiteColor];
    birthdayView.layer.cornerRadius = phoneView.hd_height / 2;
    birthdayView.layer.masksToBounds = YES;
    birthdayView.layer.borderWidth = 1;
    birthdayView.layer.borderColor = UIColorFromRGB(0xdedede).CGColor;
    [backWhiteView addSubview:birthdayView];
    
    self.birthdayLB = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, phoneView.hd_width - 30, phoneView.hd_height)];
    self.birthdayLB.textColor = UIColorFromRGB(0x333333);
    self.birthdayLB.font = kMainFont_12;
    self.birthdayLB.placeholder = @"请选择生日";
    NSString * str3 = @"请选择生日";
    NSMutableAttributedString * mStr3 = [[NSMutableAttributedString alloc]initWithString:@"请选择生日"];
    [mStr3 addAttributes:attribute range:NSMakeRange(0, str3.length)];
    self.birthdayLB.attributedPlaceholder = mStr3;
    [birthdayView addSubview:self.birthdayLB];
    
    UIButton * birthdayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    birthdayBtn.frame = birthdayView.bounds;
    [birthdayView addSubview:birthdayBtn];
    birthdayBtn.backgroundColor = [UIColor clearColor];
    [birthdayBtn addTarget:self action:@selector(chooseBirthdayAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(36, CGRectGetMaxY(birthdayView.frame) + 5, birthdayView.hd_width, 15)];
    tipLB.text = @"提交之后会有门店联系您";
    tipLB.textAlignment = NSTextAlignmentRight;
    tipLB.font = kMainFont_10;
    tipLB.textColor = UIColorFromRGB(0x999999);
    [backWhiteView addSubview:tipLB];
    
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commitBtn.frame = CGRectMake(36, CGRectGetMaxY(birthdayView.frame) + 36, backWhiteView.hd_height - 72, 25);
    [self.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.commitBtn.titleLabel.font = kMainFont_12;
    [self.commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commitBtn.backgroundColor = kMainRedColor;
    self.commitBtn.layer.cornerRadius = self.commitBtn.hd_height / 2;
    self.commitBtn.layer.masksToBounds = YES;
    [self.commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [backWhiteView addSubview:self.commitBtn];
    
    self.closeBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(CGRectGetMidX(backWhiteView.frame) - 12, CGRectGetMaxY(backWhiteView.frame) + 25, 25, 25);
    [self.closeBtn setImage:[UIImage imageNamed:@"chahao"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtn];
}

- (void)chooseBirthdayAction
{
    [self resignTextFiled];
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *nowStr = [fmt stringFromDate:now];
    __weak typeof(self)weakSelf = self;
    [CGXPickerView showDatePickerWithTitle:@"出生年月" DateType:UIDatePickerModeDate DefaultSelValue:@"2019-06-26" MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:YES Manager:nil ResultBlock:^(NSString *selectValue) {
        NSLog(@"%@",selectValue);
        weakSelf.birthdayLB.text = selectValue;
    }];
}

- (void)prepareHomeCustomUI
{
    
    UIView * backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.7];
    [self addSubview:backView];
    
    UIControl *resignControl = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [resignControl addTarget:self action:@selector(resignTextFiled) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:resignControl];
    
    UIView * backWhiteView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 160, kScreenHeight / 2 - 150 , 320, 300)];
    if (!IS_PAD) {
        backWhiteView.frame = CGRectMake(50, kScreenHeight / 2 - 150 , kScreenWidth - 100, 300);
    }
    backWhiteView.backgroundColor = [UIColor whiteColor];
    backWhiteView.layer.cornerRadius = 5;
    backWhiteView.layer.masksToBounds = YES;
    [self addSubview:backWhiteView];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(backWhiteView.frame) - 47, backWhiteView.hd_y - 47, 95, 95)];
    self.iconImageView.image = [UIImage imageNamed:@"icon_custom"];
    [self addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, backWhiteView.hd_width, 15)];
    self.titleLB.text = @"上门定制服务";
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.font = kMainFont;
    self.titleLB.textColor = UIColorFromRGB(0x333333);
    [backWhiteView addSubview:self.titleLB];
    
    NSDictionary * attribute = @{NSFontAttributeName:kMainFont_12,NSForegroundColorAttributeName:UIColorFromRGB(0x999999)};
    
    UIView * nameView = [[UIView alloc]initWithFrame:CGRectMake(36, CGRectGetMaxY(self.titleLB.frame) + 22, backWhiteView.hd_width - 72, 25)];
    nameView.backgroundColor = [UIColor whiteColor];
    nameView.layer.cornerRadius = nameView.hd_height / 2;
    nameView.layer.masksToBounds = YES;
    nameView.layer.borderWidth = 1;
    nameView.layer.borderColor = UIColorFromRGB(0xdedede).CGColor;
    [backWhiteView addSubview:nameView];
    
    self.nameLB = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, nameView.hd_width - 30, nameView.hd_height)];
    self.nameLB.textColor = UIColorFromRGB(0x333333);
    self.nameLB.font = kMainFont_12;
    NSString * str = @"请填写姓名";
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:@"请填写姓名"];
    [mStr addAttributes:attribute range:NSMakeRange(0, str.length)];
    self.nameLB.attributedPlaceholder = mStr;
    [nameView addSubview:self.nameLB];
    
    UIView * phoneView = [[UIView alloc]initWithFrame:CGRectMake(36, CGRectGetMaxY(nameView.frame) + 13, backWhiteView.hd_width - 72, 25)];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.layer.cornerRadius = phoneView.hd_height / 2;
    phoneView.layer.masksToBounds = YES;
    phoneView.layer.borderWidth = 1;
    phoneView.layer.borderColor = UIColorFromRGB(0xdedede).CGColor;
    [backWhiteView addSubview:phoneView];
    
    self.phoneLB = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, phoneView.hd_width - 30, phoneView.hd_height)];
    self.phoneLB.textColor = UIColorFromRGB(0x333333);
    self.phoneLB.font = kMainFont_12;
    self.phoneLB.placeholder = @"请填写联系方式";
    NSString * str1 = @"请填写联系方式";
    NSMutableAttributedString * mStr1 = [[NSMutableAttributedString alloc]initWithString:@"请填写联系方式"];
    [mStr1 addAttributes:attribute range:NSMakeRange(0, str1.length)];
    self.phoneLB.attributedPlaceholder = mStr1;
    [phoneView addSubview:self.phoneLB];
    
    MKPPlaceholderTextView *textView = [[MKPPlaceholderTextView alloc]init];
    textView.placeholder = @"请填写详细地址";
    textView.frame = CGRectMake(36, CGRectGetMaxY(phoneView.frame) + 13, backWhiteView.hd_width - 72, 50);
    textView.delegate = self;
    textView.font = kMainFont_12;
    textView.placeholderColor = UIColorFromRGB(0x999999);
    textView.layer.cornerRadius = 5;
    textView.layer.masksToBounds = YES;
    textView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    textView.layer.borderWidth = 1;
    [backWhiteView addSubview:textView];
    self.opinionTextView = textView;
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(36, CGRectGetMaxY(textView.frame) + 5, textView.hd_width, 15)];
    tipLB.text = @"提交之后会有附近门店联系您";
    tipLB.textAlignment = NSTextAlignmentRight;
    tipLB.font = kMainFont_10;
    tipLB.textColor = UIColorFromRGB(0x999999);
    [backWhiteView addSubview:tipLB];
    
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commitBtn.frame = CGRectMake(36, CGRectGetMaxY(textView.frame) + 36, backWhiteView.hd_height - 72, 25);
    [self.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.commitBtn.titleLabel.font = kMainFont_12;
    [self.commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commitBtn.backgroundColor = kMainRedColor;
    self.commitBtn.layer.cornerRadius = self.commitBtn.hd_height / 2;
    self.commitBtn.layer.masksToBounds = YES;
    [self.commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [backWhiteView addSubview:self.commitBtn];
    
    self.closeBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(CGRectGetMidX(backWhiteView.frame) - 12, CGRectGetMaxY(backWhiteView.frame) + 25, 25, 25);
    [self.closeBtn setImage:[UIImage imageNamed:@"chahao"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtn];
}

- (void)resignTextFiled
{
    [self.nameLB resignFirstResponder];
    [self.phoneLB resignFirstResponder];
    [self.wexinLB resignFirstResponder];
    [self.opinionTextView resignFirstResponder];
}

- (void)commitAction
{
    if (self.nameLB.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"姓名不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    if (self.phoneLB.text.length == 0 || self.phoneLB.text.length > 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if (self.isjoin) {
        
        if (self.wexinLB.text.length == 0 ) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确微信号"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return;
        }
        
        if (self.birthdayLB.text.length == 0 ) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确日期"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return;
        }
        
        if (self.customMakeCommitBlock) {
            self.customMakeCommitBlock(@{@"name":self.nameLB.text,@"phone":self.phoneLB.text,@"birthday":self.birthdayLB.text,@"webchat":self.wexinLB.text});
        }
    }else
    {
        
        if (self.opinionTextView.text.length == 0 ) {
            [SVProgressHUD showErrorWithStatus:@"地址不能为空"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return;
        }
        
        if (self.customMakeCommitBlock) {
            self.customMakeCommitBlock(@{@"name":self.nameLB.text,@"phone":self.phoneLB.text,@"address":self.opinionTextView.text});
        }
    }
    
    [self removeFromSuperview];
}

- (void)closeAction
{
    [self removeFromSuperview];
}

@end
