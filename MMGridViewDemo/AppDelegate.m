//
//  MMGridViewDemoAppDelegate.m
//  MMGridViewDemo
//
//  Created by René Sprotte on 28.03.11.
//  Copyright 2011 metaminded. All rights reserved.
//

#import "AppDelegate.h"

#import "RootViewController.h"

@implementation AppDelegate

@synthesize window;
@synthesize viewController;

- (void)dealloc
{
    [window release];
    [viewController release];
    [super dealloc];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = nc;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
