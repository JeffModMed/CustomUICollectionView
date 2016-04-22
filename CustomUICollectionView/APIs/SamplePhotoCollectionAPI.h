//
//  SamplePhotoCollectionAPI.h
//  CustomUICollectionView
//
//  Created by Jeff DeWitte on 4/22/16.
//  Copyright © 2016 Jeff DeWitte. All rights reserved.
//

#import "BHAlbum.h"
#import "BHPhoto.h"
#import <Foundation/Foundation.h>

typedef void(^LoadSamplePhotoEndBlock)(UIImage *samplePhoto);

@interface SamplePhotoCollectionAPI : NSObject

-(void)getImageForPhoto:(BHPhoto*)photo andEndblock:(LoadSamplePhotoEndBlock)endBlock;

@end
