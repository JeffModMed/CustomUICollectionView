//
//  JeffCustomCollectionViewLayout.m
//  CustomUICollectionView
//
//  Created by Jeff DeWitte on 4/21/16.
//  Copyright © 2016 Jeff DeWitte. All rights reserved.
//

#import "JeffCustomCollectionViewLayout.h"

static NSString * const JeffDefaultCollectionViewLayoutCellKind = @"JeffCell";

@interface JeffCustomCollectionViewLayout()

@property (nonatomic, strong) NSDictionary *layoutInfo;

@end

@implementation JeffCustomCollectionViewLayout

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    self.itemSize = CGSizeMake(125.0f, 125.0f);
    self.interItemSpacingY = 12.0f;
    self.numberOfColumns = 2;
}

#pragma mark - Properties

- (void)setItemInsets:(UIEdgeInsets)itemInsets{
    
    if (UIEdgeInsetsEqualToEdgeInsets(_itemInsets, itemInsets)) {
        return;
    }
    
    _itemInsets = itemInsets;
    
    [self invalidateLayout];
}

- (void)setItemSize:(CGSize)itemSize{
    
    if (CGSizeEqualToSize(_itemSize, itemSize)) {
        return;
    }
    
    _itemSize = itemSize;
    
    [self invalidateLayout];
}

- (void)setInterItemSpacingY:(CGFloat)interItemSpacingY{
    
    if(_interItemSpacingY == interItemSpacingY){
        return;
    }
    
    _interItemSpacingY = interItemSpacingY;
    
    [self invalidateLayout];
}

- (void)setNumberOfColumns:(NSInteger)numberOfColumns{
    
    if (_numberOfColumns == numberOfColumns) {
        return;
    }
    
    _numberOfColumns = numberOfColumns;
    
    [self invalidateLayout];
}

#pragma mark - Layout

-(void)prepareLayout{
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForDefaultItemContentAtIndexPath:indexPath];
            
            cellLayoutInfo[indexPath] = itemAttributes;
        }
    }
    
    newLayoutInfo[JeffDefaultCollectionViewLayoutCellKind] = cellLayoutInfo;
    self.layoutInfo = newLayoutInfo;
}

-(CGRect)frameForDefaultItemContentAtIndexPath:(NSIndexPath*)indexPath{
    NSInteger row = indexPath.section / self.numberOfColumns;
    NSInteger column = indexPath.section % self.numberOfColumns;
    
    CGFloat spacingX = self.collectionView.bounds.size.width -
                       self.itemInsets.left -
                       self.itemInsets.right -
                       (self.numberOfColumns * self.itemSize.width);
    
    if (self.numberOfColumns > 1) {
        spacingX = spacingX / (self.numberOfColumns - 1);
    }
    
    CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column);
    CGFloat originY = floor(self.itemInsets.top + (self.itemSize.height + self.interItemSpacingY) * row);
    
    
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.layoutInfo[JeffDefaultCollectionViewLayoutCellKind][indexPath];
}

-(CGSize)collectionViewContentSize{
    NSInteger rowCount = [self.collectionView numberOfSections] / self.numberOfColumns;
    //make sure we count another row if one is only partially filled
    if ([self.collectionView numberOfSections] % self.numberOfColumns) {
        rowCount++;
    }
    
    CGFloat height = self.itemInsets.top + rowCount*self.itemSize.height + (rowCount-1)*self.interItemSpacingY + self.itemInsets.bottom;
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}





@end
