//
// Copyright (c) 2010-2011 René Sprotte, Provideal GmbH
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
// OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "MMGridViewCell.h"


@interface MMGridViewCell()
@property (nonatomic, assign) MMGridView *gridView;
@end


@implementation MMGridViewCell

@synthesize textLabel;
@synthesize textLabelBackgroundView;
@synthesize backgroundView;
@synthesize gridView;
@synthesize index;

- (void)dealloc
{
    [textLabel release];
    [textLabelBackgroundView release];
    [backgroundView release];
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) {
        // Background view
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectNull];
        self.backgroundView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.backgroundView];
        
        // Label
        self.textLabelBackgroundView = [[UIView alloc] initWithFrame:CGRectNull];
        self.textLabelBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectNull];
        self.textLabel.textAlignment = UITextAlignmentRight;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:12];
        
        [self.textLabelBackgroundView addSubview:self.textLabel];
        [self addSubview:self.textLabelBackgroundView];
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int labelHeight = 30;
    int inset = 5;
    
    // Background view
    self.backgroundView.frame = self.bounds;
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Layout label
    self.textLabelBackgroundView.frame = CGRectMake(0, 
                                                    self.bounds.size.height - labelHeight - inset, 
                                                    self.bounds.size.width, 
                                                    labelHeight);
    self.textLabelBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Layout label background
    CGRect f = CGRectMake(0, 
                          0, 
                          self.textLabel.superview.bounds.size.width,
                          self.textLabel.superview.bounds.size.height);
    self.textLabel.frame = CGRectInset(f, inset, 0);
    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}


- (void)setIndex:(NSNumber *)theIndex
{
    index = [theIndex intValue];
}

// ----------------------------------------------------------------------------------

#pragma - Touch event handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *aTouch = [touches anyObject];
    if (aTouch.tapCount == 2) {
        [NSObject cancelPreviousPerformRequestsWithTarget:gridView];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    SEL singleTapSelector = @selector(cellWasSelected:);
    SEL doubleTapSelector = @selector(cellWasDoubleTapped:);
    
    if (gridView) {
        UITouch *touch = [touches anyObject];
        
        switch ([touch tapCount]) 
        {
            case 1:
                [gridView performSelector:singleTapSelector withObject:self afterDelay:.3];
                break;
                
            case 2:
                [gridView performSelector:doubleTapSelector withObject:self];
                break;
                              
            default:
                break;
        }
    }
}

@end
