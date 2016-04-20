//
//  ShapeView.m
//  ShapeJSONDraw
//
//  Created by anoopm on 19/04/16.
//  Copyright © 2016 anoopm. All rights reserved.
//

#import "ShapeView.h"
#import "Points.h"
#import "Shape.h"

@implementation ShapeView

-(void) setUpDataWithArray:(NSMutableArray*) array
{
    self.shapesArray = array;
    [self setNeedsDisplay];
}
-(void)drawInContext:(CGContextRef)context
{
    // Default is to do nothing.
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    // scale and translate to the standard cartesian coordinate system where the (0,0) is the center of the screen.
    CGContextScaleCTM(context, 1, 1);
    CGContextTranslateCTM(context, width*0.5, height*0.5);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    
    // add y-axis
    CGContextMoveToPoint(context, 0, -height*0.5);
    CGContextAddLineToPoint(context, 0, height*0.5);
    
    // add x-axis
    CGContextMoveToPoint(context, -width*0.5, 0);
    CGContextAddLineToPoint(context, width*0.5, 0);
    for (Shape *currentShape in self.shapesArray ) {
        BOOL isFirstPoint = YES;
        Points *firstPoint = nil;
        for (Points *point in currentShape.arrayOfPoints) {
            //NSLog(@"X:%f, Y:%f",point.x,point.y);
            if (isFirstPoint) {
                CGContextMoveToPoint(context, point.x/2, point.y/2);
                //[bpath moveToPoint:CGPointMake(point.x,point.y)];
                isFirstPoint = NO;
                firstPoint = point;
                continue;
            }
            CGContextAddLineToPoint(context, point.x/2, point.y/2);
            //[bpath addLineToPoint:CGPointMake(point.x,point.y)];
            
        }
        CGContextAddLineToPoint(context, firstPoint.x/2, firstPoint.y/2);
    }
    CGPathDrawingMode mode = kCGPathStroke;
    CGContextClosePath( context );
    CGContextDrawPath( context, mode );

    //[self drawInContext:UIGraphicsGetCurrentContext()];
}

@end
