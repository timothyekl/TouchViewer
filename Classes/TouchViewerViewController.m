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

@synthesize circles = _circles;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.circles = [NSMutableSet set];
    self.view.multipleTouchEnabled = YES;
}

- (CGRect)frameForPoint:(CGPoint)loc {
    return CGRectMake(loc.x - CIRCLE_SIZE / 2, loc.y - CIRCLE_SIZE / 2, CIRCLE_SIZE, CIRCLE_SIZE);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches began; circles is %@", self.circles);
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)dealloc {
	[_circles dealloc];
	
    [super dealloc];
}

@end
