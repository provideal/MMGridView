//
//  MMGridView.m
//  MMGridView
//
//  Created by René Sprotte on 28.03.11.
//  Copyright 2011 metaminded. All rights reserved.
//

#import "MMGridView.h"


@interface MMGridView()
- (void)createSubviews;
- (void)cellWasSelected:(MMGridViewCell *)cell;
- (void)cellWasDoubleTapped:(MMGridViewCell *)cell;
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
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
    self.contentMode = UIViewContentModeRedraw;
    
    self.numberOfRows = 3;
    self.numberOfColumns = 2;
    
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
    [self reloadData];
}


- (void)reloadData
{
    for (UIView *v in self.scrollView.subviews) {
        [v removeFromSuperview];
    }
    
    if (self.dataSource) {
        NSInteger cellMargin = 3;
        NSInteger noOfCols = self.numberOfColumns;
        NSInteger noOfRows = self.numberOfRows;
        NSInteger cellsPerPage = noOfCols * noOfRows;
        
        BOOL isLandscape = UIInterfaceOrientationIsLandscape([[UIDevice currentDevice] orientation]);
        if (isLandscape) {
            // In landscape mode switch rows and columns
            noOfCols = self.numberOfRows;
            noOfRows = self.numberOfColumns;
        }
        
        NSInteger numberOfCells = [self.dataSource numberOfCellsInGridView:self];
        NSInteger numberOfPages = (int)(ceil((float)numberOfCells / (float)cellsPerPage));
        
        CGRect gridBounds = self.scrollView.bounds;
        CGRect cellBounds = CGRectMake(0, 0, gridBounds.size.width / (float)noOfCols, 
                                       gridBounds.size.height / (float)noOfRows);
        
        CGSize contentSize = CGSizeMake(numberOfPages * gridBounds.size.width, gridBounds.size.height);
        [self.scrollView setContentSize:contentSize];
        
        for (NSInteger i = 0; i < numberOfCells; i++) {
            MMGridViewCell *cell = [self.dataSource gridView:self cellAtIndex:i];
            [cell performSelector:@selector(setGridView:) withObject:self];
            [cell performSelector:@selector(setIndex:) withObject:[NSNumber numberWithInt:i]];
            
            
            NSInteger page = (int)floor((float)i / (float)cellsPerPage);
            NSInteger row  = (int)floor((float)i / (float)noOfCols) - (page * noOfRows);
            
            CGPoint origin = CGPointMake((page * gridBounds.size.width) + ((i % noOfCols) * cellBounds.size.width), 
                                         (row * cellBounds.size.height));
            
            CGRect f = CGRectMake(origin.x, origin.y, cellBounds.size.width, cellBounds.size.height);
            cell.frame = CGRectInset(f, cellMargin, cellMargin);
            
            [self.scrollView addSubview:cell];
        }
    }
}


- (void)cellWasSelected:(MMGridViewCell *)cell
{
    if (delegate) {
        [delegate gridView:self didSelectCell:cell atIndex:cell.index];
    }
}


- (void)cellWasDoubleTapped:(MMGridViewCell *)cell
{
    if (delegate) {
        [delegate gridView:self didDoubleTappedCell:cell atIndex:cell.index];
    }
}

@end
