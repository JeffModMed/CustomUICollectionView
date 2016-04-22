//
//  JeffCustomCollectionViewCell.m
//  CustomUICollectionView
//
//  Created by Jeff DeWitte on 4/21/16.
//  Copyright © 2016 Jeff DeWitte. All rights reserved.
//

#import "JeffCustomCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface JeffCustomCollectionViewCell()

/*
 "This follows the convention that Apple uses for subviews on UITableViewCell, allowing consumers of this class to
 change properties of the provided image view, but not switch out the image view itself."
 */

@property (nonatomic, strong, readwrite) UIImageView *imageView;

@end

@implementation JeffCustomCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupHardCodedUI];
    }
    return self;
}

-(void)setupHardCodedUI{
    self.backgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
    
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 3.0f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 3.0f;
    self.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    self.layer.shadowOpacity = 0.5f;
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.contentView addSubview:self.imageView];
}

-(void)prepareForReuse{
    [super prepareForReuse];
    
    self.imageView.image = nil;
}

@end
