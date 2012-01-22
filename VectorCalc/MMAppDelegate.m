//
//  MMAppDelegate.m
//  VectorCalc
//
//  Created by Matthew Murdock on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMAppDelegate.h"
#import "MMMainViewController.h"

@implementation MMAppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    MMMainViewController* vc = [[MMMainViewController alloc] init];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UINavigationController* navControl = [[UINavigationController alloc] initWithRootViewController:vc];
    navControl.navigationBar.hidden = true;
    
    [self.window addSubview:navControl.view];
    
    return YES;
}

@end
