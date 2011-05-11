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

#import "RootViewController.h"
#import "AnyViewController.h"
#import "MMGridViewDefaultCell.h"

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


- (MMGridViewCell *)gridView:(MMGridView *)gridView cellAtIndex:(NSUInteger)index
{
    MMGridViewDefaultCell *cell = [[[MMGridViewDefaultCell alloc] initWithFrame:CGRectNull] autorelease];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", index];
    return cell;
}

// ----------------------------------------------------------------------------------

#pragma - MMGridViewDelegate

- (void)gridView:(MMGridView *)gridView didSelectCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
    AnyViewController *c = [[AnyViewController alloc] initWithNibName:@"AnyViewController" bundle:nil];
    [self.navigationController pushViewController:c animated:YES];
    [c release];
}


- (void)gridView:(MMGridView *)gridView didDoubleTappedCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:[NSString stringWithFormat:@"Cell at index %d was double tapped.", index]
                                                   delegate:nil 
                                          cancelButtonTitle:@"Cool!" 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}


- (void)gridView:(MMGridView *)theGridView changedPageToIndex:(NSUInteger)index
{
    pageControl.numberOfPages = theGridView.numberOfPages;
    pageControl.currentPage = index;
}

@end
