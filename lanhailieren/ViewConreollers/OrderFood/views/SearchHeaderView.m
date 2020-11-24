//
//  SearchHeaderView.m
//  lanhailieren
//
//  Created by aaa on 2020/3/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "SearchHeaderView.h"
@interface SearchHeaderView()<UITextFieldDelegate>

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UITextField * textTF;
@property (nonatomic, strong)UIButton * searchImageBtn;
@property (nonatomic, strong)UIButton * cleanKeyBtn;
@property (nonatomic, strong)UIButton * cancelBtn;

@end
@implementation SearchHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor clearColor];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(15, 5, self.hd_width - 65, self.hd_height - 4)];
    self.backView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    self.backView.layer.cornerRadius = self.backView.hd_height / 2;
    self.backView.layer.masksToBounds = YES;
    [self addSubview:self.backView];
    
    self.searchImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchImageBtn.frame = CGRectMake(self.backView.hd_height / 2, self.backView.hd_height / 2 - 10, 20, 20);
    [self.searchImageBtn setImage:[UIImage imageNamed:@"ic_search"] forState:UIControlStateNormal];
    [self.backView addSubview:self.searchImageBtn];
    
    self.textTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.searchImageBtn.frame) + 5, 0, self.backView.hd_width - self.hd_height - 40, self.backView.hd_height)];
    self.textTF.placeholder = @"搜索";
    self.textTF.textColor = UIColorFromRGB(0x333333);
    self.textTF.font = kMainFont_12;
    self.textTF.delegate = self;
    self.textTF.returnKeyType = UIReturnKeySearch;
    [self.backView addSubview:self.textTF];
    
    self.cleanKeyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cleanKeyBtn.frame = CGRectMake(self.backView.hd_width - self.backView.hd_height / 2 - 20, self.backView.hd_height / 2 - 10, 20, 20);
    [self.cleanKeyBtn setImage:[UIImage imageNamed:@"ic_empty"] forState:UIControlStateNormal];
    [self.backView addSubview:self.cleanKeyBtn];
    [self.cleanKeyBtn addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.hd_width - 50, 5, 50, self.hd_height - 5);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = kMainFont_12;
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];
}

- (void)clearAction
{
    self.textTF.text = @"";
}

- (void)cancelAction
{
    [self clearAction];
    [self.textTF resignFirstResponder];
    if (self.cancelSearchBlock) {
        self.cancelSearchBlock(@{});
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (self.searchBlock) {
        self.searchBlock(textField.text);
    }
    return YES;
}

@end
