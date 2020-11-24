//
//  QRCodeCreate.h
//  lanhailieren
//
//  Created by aaa on 2020/3/9.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QRCodeCreate : NSObject
- (UIImage *)generateQRCodeWithString:(NSString *)string Size:(CGFloat)size;

@end

