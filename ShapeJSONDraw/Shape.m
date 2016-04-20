//
//  Shape.m
//  ShapeJSONDraw
//
//  Created by anoopm on 19/04/16.
//  Copyright © 2016 anoopm. All rights reserved.
//

#import "Shape.h"
#import "Points.h"

@implementation Shape

/*!
 Each shape is going to have points
 @param entire shape data dictionary.
 @result full fledged shape object
 */
-(instancetype) initWithShapeData:(NSDictionary*) shapeDictionary
{
    self = [super init];
    if (!self) {
        return nil;
    }
    _arrayOfPoints = [NSMutableArray array];

    NSArray *points = shapeDictionary[@"Points"];
    for (int i=0; i<points.count; i++) {
        NSDictionary * dict = points[i];
        
        Points *point = [[Points alloc] init];
        point.x = [dict[@"X"] floatValue];
        point.y = [dict[@"Y"] floatValue];
        [_arrayOfPoints addObject:point];
    }

    return self;
}
@end
