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
- (void)gridView:(MMGridView *)gridView didSelectAtIndex:(NSInteger)index;
@end

// ----------------------------------------------------------------------------------

#pragma - MMGridView

@interface MMGridView : UIView 
{
    @private
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    UIView *pageControlBackgroundView;
    UIView *view;
    id<MMGridViewDataSource> dataSource;
    id<MMGridViewDelegate> delegate;
    NSUInteger numberOfRows;
    NSUInteger numberOfColumns;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UIView *pageControlBackgroundView;
@property (nonatomic, assign) IBOutlet id<MMGridViewDataSource> dataSource;
@property (nonatomic, assign) IBOutlet id<MMGridViewDelegate> delegate;
@property (nonatomic) NSUInteger numberOfRows;
@property (nonatomic) NSUInteger numberOfColumns;

- (void)reloadData;
//- (void)cellWasSelected:(MMGridViewCell *)cell;

@end
