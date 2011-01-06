//
//  TouchViewerViewController.h
//  TouchViewer
//
//  Created by Tim Ekl on 12/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CircleView;

@interface TouchViewerViewController : UIViewController {
    NSMutableSet * _circles;
}
@property (nonatomic, retain) NSMutableSet * circles;

- (CGRect)frameForPoint:(CGPoint)loc;
- (CircleView *)closestCircleTo:(CGPoint)point;

@end
