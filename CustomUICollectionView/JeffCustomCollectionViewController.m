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

static NSString * const JeffDefaultCellReuseIdentifier = @"JeffCell";

@interface JeffCustomCollectionViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (weak, nonatomic) IBOutlet JeffCustomCollectionViewLayout *jeffLayout;
@property (weak, nonatomic) NSMutableArray *albums;

@end

@implementation JeffCustomCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.albums = [NSMutableArray array];
    
    [self setupAlbums];
    
    [self.collectionView registerClass:[JeffCustomCollectionViewCell class] forCellWithReuseIdentifier:JeffDefaultCellReuseIdentifier];
    
}

- (void)setupAlbums{
    NSURL *urlPrefix = [NSURL URLWithString:@"https://raw.github.com/ShadoFlameX/PhotoCollectionView/master/Photos/"];
    
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


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.albums.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    BHAlbum *album = self.albums[section];
    
    return album.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JeffCustomCollectionViewCell *jeffCell = [collectionView dequeueReusableCellWithReuseIdentifier:JeffDefaultCellReuseIdentifier forIndexPath:indexPath];
    
    BHAlbum *album = self.albums[indexPath.section];
    BHPhoto *photo = album.photos[indexPath.item];
    
    jeffCell.imageView.image = [photo image];
    
    return jeffCell;
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
