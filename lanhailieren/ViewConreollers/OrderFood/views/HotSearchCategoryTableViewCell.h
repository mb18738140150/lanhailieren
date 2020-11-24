//
//  HotSearchCategoryTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HotSearchCategoryTableViewCell : UICollectionViewCell

@property (nonatomic, copy)void(^hotSearctBlock)(NSDictionary * info);
- (void)refreshWith:(NSDictionary * )info;

@end

NS_ASSUME_NONNULL_END
