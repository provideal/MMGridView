//
//  MMGridViewDemoViewController.m
//  MMGridViewDemo
//
//  Created by René Sprotte on 28.03.11.
//  Copyright 2011 metaminded. All rights reserved.
//

#import "RootViewController.h"
#import "AnyViewController.h"

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

- (void)viewDidLoad
{
    // Give us a nice title
    self.title = @"MMGridView Demo";
    
    // Create the GridView
    gridView = [[MMGridView alloc] initWithFrame:self.view.bounds];
    gridView.delegate = self;
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

// ----------------------------------------------------------------------------------

#pragma - MMGridViewDelegate

- (void)gridView:(MMGridView *)gridView didSelectCell:(MMGridViewCell *)cell atIndex:(NSInteger)index
{
    AnyViewController *c = [[AnyViewController alloc] initWithNibName:@"AnyViewController" bundle:nil];
    [self.navigationController pushViewController:c animated:YES];
    [c release];
}


- (void)gridView:(MMGridView *)gridView didDoubleTappedCell:(MMGridViewCell *)cell atIndex:(NSInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:[NSString stringWithFormat:@"Cell at index %d was double tapped.", index]
                                                   delegate:nil 
                                          cancelButtonTitle:@"Cool!" 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

@end
