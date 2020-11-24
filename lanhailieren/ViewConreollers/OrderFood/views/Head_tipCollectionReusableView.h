//
//  Head_tipCollectionReusableView.h
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Head_tipCollectionReusableView : UICollectionReusableView

@property (nonatomic, copy)void (^goBlock)(NSDictionary * info);
- (void)refreshUIWith:(NSDictionary *)info;

- (void)hideGoBtn;

- (void)refreshCenterContent:(NSDictionary *)info;

- (void)showMore;

@end

