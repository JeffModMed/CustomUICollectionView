//
//  SamplePhotosCollectionController.h
//  CustomUICollectionView
//
//  Created by Jeff DeWitte on 4/22/16.
//  Copyright © 2016 Jeff DeWitte. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UpdateCollectionCellImageBlock)(UIImage *image, NSIndexPath *indexPath);

@interface SamplePhotosCollectionController : NSObject

@property (nonatomic, copy) UpdateCollectionCellImageBlock updateCellImageBlock;

-(NSInteger)albumsCount;
-(NSInteger)albumPhotosCountForSection:(NSInteger)section;
-(void)loadImageForIndexPath:(NSIndexPath*)indexPath;

@end
