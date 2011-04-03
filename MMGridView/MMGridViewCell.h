//
//  GridViewCell.h
//  MyApp
//
//  Created by René Sprotte on 27.03.11.
//  Copyright 2011 metaminded. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMGridViewCell : UIView 
{
    UILabel *textLabel;
    UIView *textLabelBackgroundView;
    UIView *backgroundView;
}

@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, retain) UIView *textLabelBackgroundView;
@property (nonatomic, retain) UIView *backgroundView;

@end
