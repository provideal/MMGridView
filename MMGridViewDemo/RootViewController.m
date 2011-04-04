//
//  MMGridViewDemoViewController.m
//  MMGridViewDemo
//
//  Created by René Sprotte on 28.03.11.
//  Copyright 2011 metaminded. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

// ----------------------------------------------------------------------------------

#pragma - Object lifecycle

- (void)dealloc
{
    [gridView release];
    [super dealloc];
}

- (void)viewDidUnload {
    [gridView release];
    gridView = nil;
    [super viewDidUnload];
}

- (void)loadView
{
    [super loadView];
    // Create the GridView
    gridView = [[MMGridView alloc] initWithFrame:self.view.bounds];
    //gridView.delegate = self;
    gridView.dataSource = self;
    [self.view addSubview:gridView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait || 
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft || 
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

// ----------------------------------------------------------------------------------

#pragma - MMGridViewDataSource

- (NSInteger)numberOfCellsInGridView:(MMGridView *)gridView
{
    return 15;
}


- (MMGridViewCell *)gridView:(MMGridView *)gridView cellAtIndex:(NSInteger)index
{
    MMGridViewCell *cell = [[[MMGridViewCell alloc] initWithFrame:CGRectNull] autorelease];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", index];
    return cell;
}

@end
