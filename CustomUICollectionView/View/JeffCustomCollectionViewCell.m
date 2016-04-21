//
//  JeffCustomCollectionViewCell.m
//  CustomUICollectionView
//
//  Created by Jeff DeWitte on 4/21/16.
//  Copyright © 2016 Jeff DeWitte. All rights reserved.
//

#import "JeffCustomCollectionViewCell.h"

@implementation JeffCustomCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
    }
    return self;
}

@end
