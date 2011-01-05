//
//  TouchViewerAppDelegate.h
//  TouchViewer
//
//  Created by Tim Ekl on 12/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TouchViewerViewController;

@interface TouchViewerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TouchViewerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TouchViewerViewController *viewController;

@end
