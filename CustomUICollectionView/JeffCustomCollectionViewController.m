//
//  JeffCustomCollectionViewController.m
//  CustomUICollectionView
//
//  Created by Jeff DeWitte on 4/21/16.
//  Copyright © 2016 Jeff DeWitte. All rights reserved.
//
//Change to test commit

#import "BHAlbum.h"
#import "BHPhoto.h"
#import "JeffCustomCollectionViewCell.h"
#import "JeffCustomCollectionViewController.h"
#import "JeffCustomCollectionViewLayout.h"
#import "SamplePhotosCollectionController.h"

static NSString * const JeffDefaultCellReuseIdentifier = @"JeffCell";

@interface JeffCustomCollectionViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (weak, nonatomic) IBOutlet JeffCustomCollectionViewLayout *jeffLayout;
@property (strong, nonatomic) SamplePhotosCollectionController *sampleCollectionController;

@end

@implementation JeffCustomCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sampleCollectionController = [SamplePhotosCollectionController new];
    
    [self.collectionView registerClass:[JeffCustomCollectionViewCell class] forCellWithReuseIdentifier:JeffDefaultCellReuseIdentifier];
    
    __weak JeffCustomCollectionViewController *weakSelf = self;
    self.sampleCollectionController.updateCellImageBlock = ^(UIImage *samplePhoto, NSIndexPath *indexPath){
        dispatch_async(dispatch_get_main_queue(), ^{
            // then set them via the main queue if the cell is still visible.
            __strong typeof(weakSelf)strongSelf = weakSelf;
            if ([strongSelf.mainCollectionView.indexPathsForVisibleItems containsObject:indexPath]) {
                JeffCustomCollectionViewCell *jeffCell = (JeffCustomCollectionViewCell*)[strongSelf.mainCollectionView cellForItemAtIndexPath:indexPath];
                jeffCell.imageView.image = samplePhoto;
            }
            
        });
    };
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.sampleCollectionController albumsCount];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.sampleCollectionController albumPhotosCountForSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self buildCellWithSamplePhotoForCollectionView:collectionView AndIndexPath:indexPath];
}

-(JeffCustomCollectionViewCell*)buildCellWithSamplePhotoForCollectionView:(UICollectionView*)collectionView AndIndexPath:(NSIndexPath*)indexPath{
    JeffCustomCollectionViewCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:JeffDefaultCellReuseIdentifier forIndexPath:indexPath];
    
    [self.sampleCollectionController loadImageForIndexPath:indexPath];
    
    return photoCell;
}

#pragma mark - View Rotation (Doesn't seem scalable...)
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
         if (UIInterfaceOrientationIsLandscape(orientation)) {
             self.jeffLayout.numberOfColumns = 3;
             
             // handle insets for iPhone 4 or 5
             CGFloat sideInset = [UIScreen mainScreen].preferredMode.size.width == 1136.0f ? 45.0f : 25.0f;
             
             self.jeffLayout.itemInsets = UIEdgeInsetsMake(22.0f, sideInset, 13.0f, sideInset);
             
         } else {
             self.jeffLayout.numberOfColumns = 2;
             self.jeffLayout.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
         }
     } completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         
     }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
