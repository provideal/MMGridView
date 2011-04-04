//
//  MMGridView.m
//  MMGridView
//
//  Created by René Sprotte on 28.03.11.
//  Copyright 2011 metaminded. All rights reserved.
//

#import "MMGridView.h"


@interface MMGridView(Private)
- (void)createSubviews;
@end


@implementation MMGridView

@synthesize scrollView;
@synthesize pageControl;
@synthesize pageControlBackgroundView;
@synthesize dataSource;
@synthesize delegate;
@synthesize numberOfRows;
@synthesize numberOfColumns;

- (void)dealloc
{
    [scrollView release];
    [pageControl release];
    [pageControlBackgroundView release];
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) {
        [self createSubviews];
    }
    
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self createSubviews];
    }
    
    return self;
}


- (void)createSubviews
{
    self.numberOfRows = 2;
    self.numberOfColumns = 3;
    
    self.backgroundColor = [UIColor clearColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectNull];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    [self addSubview:self.scrollView];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


- (void)setDataSource:(id<MMGridViewDataSource>)aDataSource
{
    dataSource = aDataSource;
    [self reloadData];
}


- (void)setNumberOfColumns:(NSUInteger)value
{
    numberOfColumns = value;
    [self reloadData];
}


- (void)setNumberOfRows:(NSUInteger)value
{
    numberOfRows = value;
}


- (void)layoutSubviews
{
    self.scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}


- (void)reloadData
{
    for (UIView *v in self.scrollView.subviews) {
        [v removeFromSuperview];
    }
    
    if (self.dataSource) {
        NSInteger cellMargin = 0;
        NSInteger cellsPerPage = self.numberOfColumns * self.numberOfRows;
        
        NSInteger numberOfCells = [self.dataSource numberOfCellsInGridView:self];
        NSInteger numberOfPages = (int)(ceil((float)numberOfCells / (float)cellsPerPage));
        
        CGRect gridBounds = self.scrollView.bounds;
        CGRect cellBounds = CGRectMake(0, 0, gridBounds.size.width / (float)self.numberOfColumns, gridBounds.size.height / (float)self.numberOfRows);
        
        [self.scrollView setContentSize:CGSizeMake((numberOfPages * gridBounds.size.width), gridBounds.size.height)];
        
        for (NSInteger i = 0; i < numberOfCells; i++) {
            MMGridViewCell *cell = [self.dataSource gridView:self cellAtIndex:i];
            
            NSInteger page = (int)floor((float)i / (float)cellsPerPage);
            NSInteger row  = (int)floor((float)i / (float)self.numberOfColumns) - (page * self.numberOfRows);
            
            CGPoint origin = CGPointMake((page * gridBounds.size.width) + ((i % self.numberOfColumns) * cellBounds.size.width), (row * cellBounds.size.height));
            
            CGRect f = CGRectMake(origin.x, origin.y, cellBounds.size.width, cellBounds.size.height);
            cell.frame = CGRectInset(f, cellMargin, cellMargin);
            
            [self.scrollView addSubview:cell];
        }
    }
}

@end
