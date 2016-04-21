//
//  JeffCustomCollectionViewLayout.h
//  CustomUICollectionView
//
//  Created by Jeff DeWitte on 4/21/16.
//  Copyright © 2016 Jeff DeWitte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JeffCustomCollectionViewLayout : UICollectionViewLayout

@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;

@end
