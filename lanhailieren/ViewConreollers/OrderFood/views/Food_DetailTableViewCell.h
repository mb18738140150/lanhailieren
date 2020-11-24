//
//  Food_DetailTableViewCell.h
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Food_DetailTableViewCell : UITableViewCell

@property (nonatomic, copy)void (^foodDetailCollectionHetghtBlock)(float height);
- (void)refreshUIWithInfo:(NSDictionary *)info andHeight:(float)collectionViewHeight;

- (void)refreshFisheryHarvestDetailUIWithInfo:(NSDictionary *)info andHeight:(float)collectionViewHeight;

@end
