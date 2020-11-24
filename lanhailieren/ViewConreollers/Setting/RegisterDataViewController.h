//
//  RegisterDataViewController.h
//  lanhailieren
//
//  Created by aaa on 2020/3/5.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterDataViewController : UIViewController

@property (nonatomic, assign)int userId;
@property (nonatomic, copy)void (^loginBlock)(NSDictionary *info);

@property (nonatomic, assign)BOOL isFromSetting;

@end
