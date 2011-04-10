//
//  MMGridViewDefaultCell.h
//  MMGridView
//
//  Created by René Sprotte on 10.04.11.
//  Copyright 2011 metaminded. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMGridViewCell.h"


@interface MMGridViewDefaultCell : MMGridViewCell 
{
    UILabel *textLabel;
    UIView *textLabelBackgroundView;
    UIView *backgroundView;
}

@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, retain) UIView *textLabelBackgroundView;
@property (nonatomic, retain) UIView *backgroundView;

@end
