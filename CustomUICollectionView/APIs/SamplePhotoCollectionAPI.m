//
//  SamplePhotoCollectionAPI.m
//  CustomUICollectionView
//
//  Created by Jeff DeWitte on 4/22/16.
//  Copyright © 2016 Jeff DeWitte. All rights reserved.
//

#import "SamplePhotoCollectionAPI.h"

@interface SamplePhotoCollectionAPI()

@property (nonatomic, strong) NSOperationQueue *samplePhotosQueue;

@end

@implementation SamplePhotoCollectionAPI

- (instancetype) init {
    self = [super init];
    if (self) {
        _samplePhotosQueue = [NSOperationQueue new];
        _samplePhotosQueue.maxConcurrentOperationCount = 3;
    }
    return self;
}

-(void)getImageForPhoto:(BHPhoto*)photo andEndblock:(LoadSamplePhotoEndBlock)endBlock{

    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        UIImage *imageFromURL = [photo image];
        
        if (endBlock) {
            endBlock(imageFromURL);
        }
    }];
    
    [self.samplePhotosQueue addOperation:operation];
}

@end
