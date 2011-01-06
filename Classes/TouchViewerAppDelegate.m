//
//  TouchViewerAppDelegate.m
//  TouchViewer
//
//  Created by Tim Ekl on 12/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TouchViewerAppDelegate.h"

#import "TouchViewerViewController.h"

@implementation TouchViewerAppDelegate

@synthesize window;

@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
    return YES;
}

- (void)dealloc {

    [window release];
    [viewController release];
    [super dealloc];
}

@end
