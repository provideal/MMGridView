//
//  MMGridView.h
//  MMGridView
//
//  Created by René Sprotte on 28.03.11.
//  Copyright 2011 metaminded. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMGridViewCell.h"


@class MMGridView;

// ----------------------------------------------------------------------------------

#pragma - MMGridViewDataSource

@protocol MMGridViewDataSource<NSObject>
- (NSInteger)numberOfCellsInGridView:(MMGridView *)gridView;
- (MMGridViewCell *)gridView:(MMGridView *)gridView cellAtIndex:(NSInteger)index;
@end

// ----------------------------------------------------------------------------------

#pragma - MMGridViewDelegate

@protocol MMGridViewDelegate<NSObject>
@optional
- (void)gridView:(MMGridView *)gridView didSelectCell:(MMGridViewCell *)cell atIndex:(NSInteger)index;
- (void)gridView:(MMGridView *)gridView didDoubleTappedCell:(MMGridViewCell *)cell atIndex:(NSInteger)index;
@end

// ----------------------------------------------------------------------------------

#pragma - MMGridView

@interface MMGridView : UIView 
{
    @private
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    UIView *pageControlBackgroundView;
    id<MMGridViewDataSource> dataSource;
    id<MMGridViewDelegate> delegate;
    NSUInteger numberOfRows;
    NSUInteger numberOfColumns;
    NSUInteger cellMargin;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UIView *pageControlBackgroundView;
@property (nonatomic, assign) IBOutlet id<MMGridViewDataSource> dataSource;
@property (nonatomic, assign) IBOutlet id<MMGridViewDelegate> delegate;
@property (nonatomic) NSUInteger numberOfRows;
@property (nonatomic) NSUInteger numberOfColumns;
@property (nonatomic) NSUInteger cellMargin;

- (void)reloadData;

@end
