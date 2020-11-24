//
//  CGXPickerViewManager.m
//  CGXPickerView
//
//  Created by CGX on 2018/1/8.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "CGXPickerViewManager.h"

/// RGB颜色(16进制)
#define CGXPickerRGBColor(r,g,b,a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a];


@interface CGXPickerViewManager ()

@end
@implementation CGXPickerViewManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _kPickerViewH = 200;
        _kTopViewH = 50;
        _pickerTitleSize  =15;
        _pickerTitleColor = [UIColor blackColor];
        
        _pickerTitleSelectSize  =15;
        _pickerTitleSelectColor = [UIColor blackColor];
        
        _lineViewColor =CGXPickerRGBColor(225, 225, 225, 1);
        
        _titleLabelColor = kMainRedColor;
        _titleSize = 16;
        _titleLabelBGColor = [UIColor whiteColor];
        _rowHeight = 50;
        _rightBtnTitle = @"确定";
        _rightBtnBGColor =  kMainRedColor;
        _rightBtnTitleSize = 16;
        _rightBtnTitleColor = [UIColor whiteColor];
        
        _rightBtnborderColor = kMainRedColor;
        _rightBtnCornerRadius = 6;
        _rightBtnBorderWidth = 1;
        
        _leftBtnTitle = @"取消";
        _leftBtnBGColor =  kMainRedColor;
        _leftBtnTitleSize = 16;
        _leftBtnTitleColor = [UIColor whiteColor];
        
        _leftBtnborderColor = kMainRedColor;
        _leftBtnCornerRadius = 6;
        _leftBtnBorderWidth = 1;
        _isHaveLimit = NO;
        
    }
    return self;
}
@end
