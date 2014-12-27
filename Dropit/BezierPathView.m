//
//  BezierPathView.m
//  Dropit
//
//  Created by Andrew Codispoti on 2014-12-27.
//  Copyright (c) 2014 Andrew Codispoti. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.path stroke];
}
-(void) setPath:(UIBezierPath *)path{
    _path=path;
    [self setNeedsDisplay];
    
}

@end
