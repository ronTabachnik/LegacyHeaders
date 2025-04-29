//
//  UICollectionView+Extension.m
//  MentorHouse
//
//  Created by Lior Shabo on 29/07/2018.
//  Copyright © 2018 Aman. All rights reserved.
//

#import "UICollectionView+Extension.h"

@implementation UICollectionView (Extension)

- (void)scrollToLastIndex:(UICollectionView*)collectionView inputToolbar:(UIView*)inputToolbar animated:(BOOL)animated;
{
    if ([collectionView numberOfSections] == 0) {
        return;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:([collectionView numberOfItemsInSection:0] - 1) inSection:0];
    
    if ([collectionView numberOfSections] <= indexPath.section) {
        return;
    }
    
    NSInteger numberOfItems = [collectionView numberOfItemsInSection:indexPath.section];
    if (numberOfItems == 0) {
        return;
    }
    
    CGFloat collectionViewContentHeight = [collectionView.collectionViewLayout collectionViewContentSize].height;
    BOOL isContentTooSmall = (collectionViewContentHeight < CGRectGetHeight(collectionView.bounds));
    
    if (isContentTooSmall) {
        //  workaround for the first few messages not scrolling
        //  when the collection view content size is too small, `scrollToItemAtIndexPath:` doesn't work properly
        //  this seems to be a UIKit bug, see #256 on GitHub
        [collectionView scrollRectToVisible:CGRectMake(0.0, collectionViewContentHeight - 1.0f, 1.0f, 1.0f)
                                        animated:animated];
        return;
    }
    
    NSInteger item = MAX(MIN(indexPath.item, numberOfItems - 1), 0);
    indexPath = [NSIndexPath indexPathForItem:item inSection:0];
    
    [collectionView scrollToItemAtIndexPath:indexPath
                           atScrollPosition:UICollectionViewScrollPositionBottom
                                   animated:animated];
    
    //  workaround for really long messages not scrolling
    //  if last message is too long, use scroll position bottom for better appearance, else use top
    //  possibly a UIKit bug, see #480 on GitHub
    /*CGSize cellSize = [collectionView.collectionViewLayout sizeForItemAtIndexPath:indexPath];
    CGFloat maxHeightForVisibleMessage = CGRectGetHeight(collectionView.bounds)
    - collectionView.contentInset.top
    - collectionView.contentInset.bottom
    - CGRectGetHeight(inputToolbar.bounds);
    UICollectionViewScrollPosition scrollPosition = (cellSize.height > maxHeightForVisibleMessage) ? UICollectionViewScrollPositionBottom : UICollectionViewScrollPositionTop;
    
    [collectionView scrollToItemAtIndexPath:indexPath
                                atScrollPosition:scrollPosition
                                        animated:animated];*/
}

@end
