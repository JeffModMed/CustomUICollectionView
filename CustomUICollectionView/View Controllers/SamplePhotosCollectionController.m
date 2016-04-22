//
//  SamplePhotosCollectionController.m
//  CustomUICollectionView
//
//  Created by Jeff DeWitte on 4/22/16.
//  Copyright © 2016 Jeff DeWitte. All rights reserved.
//

#import "BHAlbum.h"
#import "BHPhoto.h"
#import "SamplePhotoCollectionAPI.h"
#import "SamplePhotosCollectionController.h"

@interface SamplePhotosCollectionController()

@property (strong, nonatomic) NSMutableArray *albums;
@property (nonatomic, strong) SamplePhotoCollectionAPI *sampleCollectionAPI;

@end

@implementation SamplePhotosCollectionController

- (instancetype) init {
    self = [super init];
    if (self) {
        _albums = [NSMutableArray array];
        [self setupAlbums];
    }
    return self;
}

-(SamplePhotoCollectionAPI*)sampleCollectionAPI{
    if (!_sampleCollectionAPI) {
        _sampleCollectionAPI = [SamplePhotoCollectionAPI new];
    }
    return _sampleCollectionAPI;
}

- (void)setupAlbums{
    NSURL *urlPrefix = [NSURL URLWithString:@"https://raw.github.com/JeffModMed/CustomUICollectionView/master/SamplePhotos/"];
    
    NSInteger photoIndex = 0;
    
    for (NSInteger a = 0; a < 12; a++) {
        BHAlbum *album = [[BHAlbum alloc] init];
        album.name = [NSString stringWithFormat:@"Photo Album %ld",a + 1];
        
        NSUInteger photoCount = 1;
        for (NSInteger p = 0; p < photoCount; p++) {
            // there are up to 25 photos available to load from the code repository
            NSString *photoFilename = [NSString stringWithFormat:@"thumbnail%ld.jpg",photoIndex % 25];
            NSURL *photoURL = [urlPrefix URLByAppendingPathComponent:photoFilename];
            BHPhoto *photo = [BHPhoto photoWithImageURL:photoURL];
            [album addPhoto:photo];
            
            photoIndex++;
        }
        
        [self.albums addObject:album];
    }
}

#pragma mark - External methods

-(NSInteger)albumsCount{
    return self.albums.count;
}

-(NSInteger)albumPhotosCountForSection:(NSInteger)section{
    BHAlbum *album = self.albums[section];
    return album.photos.count;
}

-(void)loadImageForIndexPath:(NSIndexPath*)indexPath{
    BHAlbum *album = self.albums[indexPath.section];
    BHPhoto *photo = album.photos[indexPath.item];
    
    [self.sampleCollectionAPI getImageForPhoto:photo andEndblock:^(UIImage *samplePhoto){
        if (samplePhoto) {
            self.updateCellImageBlock(samplePhoto, indexPath);
        }
        
    }];
}


@end
