//
//  WriteCommentContentView.m
//  lanhailieren
//
//  Created by aaa on 2020/4/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "WriteCommentContentView.h"

@interface WriteCommentContentView()<UITextViewDelegate>

@end

@implementation WriteCommentContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSDictionary *)info
{
    self = [super initWithFrame:frame];
    if (self) {
        self.infoDic = info;
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIView * topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.hd_width,1)];
    topLine.backgroundColor = UIColorFromRGB(0xececec);
    [self addSubview:topLine];
    
    MKPPlaceholderTextView *textView = [[MKPPlaceholderTextView alloc]init];
    textView.placeholder = @"我来说两句";
    textView.frame = CGRectMake(10, 10, kScreenWidth / 2 - 20, 30);
    textView.delegate = self;
    textView.font = kMainFont_12;
    textView.placeholderColor = UIColorFromRGB(0x666666);
    textView.layer.cornerRadius = textView.hd_height / 2;
    textView.layer.masksToBounds = YES;
    textView.backgroundColor = UIColorFromRGB(0xf1f1f1);
    [textView resetPlaceholderLabel];
    [textView setPlaceholderTextAlignment:NSTextAlignmentCenter];
    textView.returnKeyType = UIReturnKeySend;
    [self addSubview:textView];
    self.textView = textView;
    
    CGFloat btnSpace = (self.hd_width / 2 - 50 - 60 * 3) / 3;
    self.goodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.goodBtn.frame = CGRectMake(CGRectGetMaxX(textView.frame) + 35, 12, 60, 25);
    [self.goodBtn setImage:[UIImage imageNamed:@"icon_givlike"] forState:UIControlStateNormal];
    [self.goodBtn setTitle:[NSString stringWithFormat:@"%@", [self.infoDic objectForKey:@"zan"]] forState:UIControlStateNormal];
    [self.goodBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    self.goodBtn.titleLabel.font = kMainFont;
    [self.goodBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [self addSubview:self.goodBtn];
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.frame = CGRectMake(CGRectGetMaxX(self.goodBtn.frame) + btnSpace, self.goodBtn.hd_y, 60, 25);
    [self.commentBtn setImage:[UIImage imageNamed:@"icon_comments"] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%@", [self.infoDic objectForKey:@"comment_num"]] forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    self.commentBtn.titleLabel.font = kMainFont;
    [self.commentBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
//    [self addSubview:self.commentBtn];
    
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.frame = CGRectMake(CGRectGetMaxX(self.goodBtn.frame) +btnSpace, self.goodBtn.hd_y, 60, 25);
    [self.collectBtn setImage:[UIImage imageNamed:@"icon_collection"] forState:UIControlStateNormal];
    [self.collectBtn setTitle:[NSString stringWithFormat:@"%@", [self.infoDic objectForKey:@"collect_num"]] forState:UIControlStateNormal];
    [self.collectBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    self.collectBtn.titleLabel.font = kMainFont;
    [self.collectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [self addSubview:self.collectBtn];
    if([[self.infoDic objectForKey:@"is_collect"] intValue])
    {
        [self.collectBtn setImage:[UIImage imageNamed:@"icon_already_collected"] forState:UIControlStateNormal];
    }
    if([[self.infoDic objectForKey:@"is_zan"] intValue])
    {
        [self.goodBtn setImage:[UIImage imageNamed:@"icon_givlike_active"] forState:UIControlStateNormal];
    }
    
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.frame = CGRectMake(CGRectGetMaxX(self.collectBtn.frame) +btnSpace, self.goodBtn.hd_y, 60, 25);
    [self.shareBtn setImage:[UIImage imageNamed:@"icon_forwarding"] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%@", [self.infoDic objectForKey:@"share"]] forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    self.shareBtn.titleLabel.font = kMainFont;
    [self.shareBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [self addSubview:self.shareBtn];
    
//    if (!IS_PAD) {
//        self.textView.frame = CGRectMake(10, 10, kScreenWidth  - 20, 30);
//        self.goodBtn.hidden = YES;
//        self.commentBtn.hidden = YES;
//        self.collectBtn.hidden = YES;
//        self.shareBtn.hidden = YES;
//    }
    
    [self.goodBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.collectBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self bringSubviewToFront:self.textView];
}

- (void)refreshUIWithInfo:(NSDictionary *)info
{
    [self.goodBtn setTitle:[NSString stringWithFormat:@"%@", [self.infoDic objectForKey:@"zan"]] forState:UIControlStateNormal];
    [self.collectBtn setTitle:[NSString stringWithFormat:@"%@", [self.infoDic objectForKey:@"collect_num"]] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%@", [self.infoDic objectForKey:@"share"]] forState:UIControlStateNormal];
    if([[self.infoDic objectForKey:@"is_collect"] intValue])
    {
        [self.collectBtn setImage:[UIImage imageNamed:@"icon_already_collected"] forState:UIControlStateNormal];
    }else
    {
        [self.collectBtn setImage:[UIImage imageNamed:@"icon_collection"] forState:UIControlStateNormal];
    }
    if([[self.infoDic objectForKey:@"is_zan"] intValue])
    {
        [self.goodBtn setImage:[UIImage imageNamed:@"icon_givlike_active"] forState:UIControlStateNormal];
    }else
    {
        [self.goodBtn setImage:[UIImage imageNamed:@"icon_givlike"] forState:UIControlStateNormal];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        if (self.commitBlock) {
            self.commitBlock(textView.text);
        }
        [self.textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)operationAction:(UIButton *)button
{
    if ([button isEqual:self.goodBtn]) {
        if (self.goodBlock) {
            self.goodBlock(self.infoDic);
        }
    }else if ([button isEqual:self.collectBtn])
    {
        if (self.collectBlock) {
            self.collectBlock(self.infoDic);
        }
    }
    else if ([button isEqual:self.shareBtn])
    {
        if (self.shareBlock) {
            self.shareBlock(self.infoDic);
        }
    }
}

- (void)textViewResignFirstResponder
{
    [self.textView resignFirstResponder];
}

- (void)hideOperationBtn
{
    self.textView.frame = CGRectMake(10, 10, kScreenWidth  - 20, 30);
}
- (void)showOperationBtn
{
    self.textView.frame = CGRectMake(10, 10, kScreenWidth / 2 - 20, 30);
}


@end
