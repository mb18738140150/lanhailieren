//
//  HeadCategiryTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Head_categoryCollectionReusableView.h"

@interface HeadCategiryTableViewCell : UITableViewCell

@property (nonatomic,copy)void(^FishCategory_headTableViewClickBlock)(NSDictionary * info);

- (void)refreshUIWithInfo:(NSDictionary *)info;

@end

