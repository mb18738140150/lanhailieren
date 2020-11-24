//
//  UIImagePickerController+Nonroating.m
//  lanhailieren
//
//  Created by aaa on 2020/3/6.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "UIImagePickerController+Nonroating.h"

@implementation UIImagePickerController (Nonroating)

- (NSUInteger)supportedInterfaceOrientations{
    
    if (IS_PAD) {
        return UIInterfaceOrientationMaskLandscape;
    }else
    {
        return UIInterfaceOrientationMaskPortrait;
    }
    
}

@end
