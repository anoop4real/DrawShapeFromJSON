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


- (id)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {

    }
    return self;
}
-(void) setUpDataWithArray:(NSMutableArray*) array
{
    self.shapesArray = array;
    [self setNeedsDisplay];
    self.contentMode = UIViewContentModeScaleAspectFit;
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
    CGFloat scaleFactor = self.bounds.size.width/self.bounds.size.height;
    // scale and translate to the standard cartesian coordinate system where the (0,0) is the center of the screen.
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, width*0.5, -height*0.5);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    
    // add y-axis
    CGContextMoveToPoint(context, 0, -height*0.5);
    CGContextAddLineToPoint(context, 0, height*0.5);
    
    // add x-axis
    CGContextMoveToPoint(context, -width*0.5, 0);
    CGContextAddLineToPoint(context, width*0.5, 0);
    CGContextSaveGState(context);
    [self applyCTMTransformsForContext:context frame:self.bounds];
    for (Shape *currentShape in self.shapesArray ) {
        BOOL isFirstPoint = YES;
        Points *firstPoint = nil;
        for (Points *point in currentShape.arrayOfPoints) {
            //NSLog(@"X:%f, Y:%f",point.x,point.y);
            if (isFirstPoint) {
                CGContextMoveToPoint(context, point.x/scaleFactor, point.y/scaleFactor);
                //[bpath moveToPoint:CGPointMake(point.x,point.y)];
                isFirstPoint = NO;
                firstPoint = point;
                continue;
            }
            CGContextAddLineToPoint(context, point.x/scaleFactor, point.y/scaleFactor);
            //[bpath addLineToPoint:CGPointMake(point.x,point.y)];
            
        }
        CGContextAddLineToPoint(context, firstPoint.x/scaleFactor, firstPoint.y/scaleFactor);
    }
    CGPathDrawingMode mode = kCGPathStroke;
    CGContextClosePath( context );
    CGContextDrawPath( context, mode );
    CGContextRestoreGState(context);
    //[self drawInContext:UIGraphicsGetCurrentContext()];
}

- (void)applyCTMTransformsForContext:(CGContextRef)context frame:(CGRect)frame
{
    // This is the actual size of the drawing, ideal it will be 2 times biggest x and 2times biggest y
    CGSize graphicSize = CGSizeMake(800, 800);
    CGSize viewSize = frame.size;
    
    // Translate by the origin of the frame to begin with.
    CGContextTranslateCTM(context, frame.origin.x, frame.origin.y);
    
    switch(self.contentMode)
    {
        case UIViewContentModeScaleToFill:
            // Simple scale
            CGContextScaleCTM(context, viewSize.width/graphicSize.width, viewSize.height/graphicSize.height);
            break;
        case UIViewContentModeScaleAspectFit:
        {
            CGFloat scale = MIN(viewSize.width/graphicSize.width, viewSize.height/graphicSize.height);
            CGContextTranslateCTM(context, (viewSize.width-(graphicSize.width*scale))/2.0f, (viewSize.height-(graphicSize.height*scale))/2.0f);
            CGContextScaleCTM(context, scale, scale);
            break;
        }
        case UIViewContentModeScaleAspectFill:     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
        {
            CGFloat scale = MAX(viewSize.width/graphicSize.width, viewSize.height/graphicSize.height);
            CGContextTranslateCTM(context, (viewSize.width-(graphicSize.width*scale))/2.0f, (viewSize.height-(graphicSize.height*scale))/2.0f);
            CGContextScaleCTM(context, scale, scale);
            break;
        }
        case UIViewContentModeRedraw:              // redraw on bounds change (calls -setNeedsDisplay)
            break;
        case UIViewContentModeCenter:              // contents remain same size. positioned adjusted.
            CGContextTranslateCTM(context, (viewSize.width-graphicSize.width)/2.0f, (viewSize.height-graphicSize.height)/2.0f);
            break;
        case UIViewContentModeTop:
            break;
        case UIViewContentModeBottom:
            CGContextTranslateCTM(context, 0.0f, viewSize.height-graphicSize.height);
            break;
        case UIViewContentModeLeft:
            break;
        case UIViewContentModeRight:
            CGContextTranslateCTM(context, viewSize.width-graphicSize.width, 0.0f);
            break;
        case UIViewContentModeTopLeft:
            break;
        case UIViewContentModeTopRight:
            CGContextTranslateCTM(context, viewSize.width-graphicSize.width, 0.0f);
            break;
        case UIViewContentModeBottomLeft:
            CGContextTranslateCTM(context, 0.0f, viewSize.height-graphicSize.height);
            break;
        case UIViewContentModeBottomRight:
            CGContextTranslateCTM(context, viewSize.width-graphicSize.width, viewSize.height-graphicSize.height);
            break;
    }
}

@end
