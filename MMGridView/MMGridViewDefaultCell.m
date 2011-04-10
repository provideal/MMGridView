//
//  MMGridViewDefaultCell.m
//  MMGridView
//
//  Created by René Sprotte on 10.04.11.
//  Copyright 2011 metaminded. All rights reserved.
//

#import "MMGridViewDefaultCell.h"


@implementation MMGridViewDefaultCell

@synthesize textLabel;
@synthesize textLabelBackgroundView;
@synthesize backgroundView;

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

@end
