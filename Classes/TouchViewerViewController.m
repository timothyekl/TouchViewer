//
//  TouchViewerViewController.m
//  TouchViewer
//
//  Created by Tim Ekl on 12/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TouchViewerViewController.h"

#import "CircleView.h"

#define CIRCLE_SIZE 100.0

@implementation TouchViewerViewController

@synthesize circles;


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.circles = [NSMutableSet set];
    self.view.multipleTouchEnabled = YES;
}

- (CGRect)frameForPoint:(CGPoint)loc {
    return CGRectMake(loc.x - CIRCLE_SIZE / 2, loc.y - CIRCLE_SIZE / 2, CIRCLE_SIZE, CIRCLE_SIZE);
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches began; circles is %@", circles);
    for(UITouch * touch in touches) {
        CGPoint loc = [touch locationInView:self.view];
        CircleView * circle = [[[CircleView alloc] initWithFrame:[self frameForPoint:loc]] autorelease];
        [self.view addSubview:circle];
        [self.circles addObject:circle];
        NSLog(@"circles has %d objects", [self.circles count]);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for(UITouch * touch in touches) {
        CGPoint loc = [touch locationInView:self.view];
        CircleView * circle = [self closestCircleTo:loc];
        circle.frame = [self frameForPoint:loc];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches ended; %d circles", [self.circles count]);
    for(UITouch * touch in touches) {
        CGPoint loc = [touch locationInView:self.view];
        CircleView * circle = [self closestCircleTo:loc];
        [circle removeFromSuperview];
        [self.circles removeObject:circle];
    }
}
                               
- (CircleView *)closestCircleTo:(CGPoint)point {
    CGFloat minDist = 99999999.9;
    CircleView * closest = nil;
    for(CircleView * circle in self.circles) {
        CGRect frame = circle.frame;
        CGPoint center = CGPointMake(frame.origin.x + CIRCLE_SIZE / 2, frame.origin.y + CIRCLE_SIZE / 2);
        CGFloat dist = sqrtf((center.x - point.x) * (center.x - point.x) + (center.y - point.y) * (center.y - point.y));
        NSLog(@"Comparing calculated distance %f to minimum distance %f", dist, minDist);
        if(dist < minDist) {
            minDist = dist;
            closest = circle;
        }
    }
    NSLog(@"found closest circle: %@", closest);
    return closest;
}

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
