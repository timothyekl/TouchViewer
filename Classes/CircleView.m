//
//  CircleView.m
//  TouchViewer
//
//  Created by Tim Ekl on 12/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CircleView.h"


@implementation CircleView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        self.opaque = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(context, self.bounds);
	
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
    
	CGContextFillPath(context);
    CGContextStrokePath(context);
}

@end
