//
//  AppDelegate.h
//  lanhailieren
//
//  Created by aaa on 2020/3/5.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) TabbarViewController           *tabbarViewController;
@property (nonatomic, assign)BOOL allowRotation;// 是否允许转向

@property (nonatomic, assign)BOOL isFullScreen;;



@end

