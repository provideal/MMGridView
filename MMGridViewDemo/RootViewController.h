//
//  MMGridViewDemoViewController.h
//  MMGridViewDemo
//
//  Created by René Sprotte on 28.03.11.
//  Copyright 2011 metaminded. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMGridView.h"

@interface RootViewController : UIViewController<MMGridViewDataSource> 
{
    IBOutlet MMGridView *gridView;
}

@end
