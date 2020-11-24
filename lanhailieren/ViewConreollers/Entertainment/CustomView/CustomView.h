//
//  CustomView.h
//  lanhailieren
//
//  Created by aaa on 2020/4/16.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView

@property (nonatomic, copy)void (^customMakeCommitBlock)(NSDictionary * info);

- (instancetype)initWithFrame:(CGRect)frame withJopinClub:(BOOL)isjoin;

@end
