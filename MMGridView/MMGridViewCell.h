//
//  GridViewCell.h
//  MyApp
//
//  Created by René Sprotte on 27.03.11.
//  Copyright 2011 metaminded. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMGridView;

@interface MMGridViewCell : UIView 
{
    UILabel *textLabel;
    UIView *textLabelBackgroundView;
    UIView *backgroundView;
    MMGridView *gridView;
    NSInteger index;
}

@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, retain) UIView *textLabelBackgroundView;
@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, readonly) MMGridView *gridView;
@property (nonatomic, readonly) NSInteger index;

@end
