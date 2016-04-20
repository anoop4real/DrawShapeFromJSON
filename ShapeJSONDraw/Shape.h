//
//  Shape.h
//  ShapeJSONDraw
//
//  Created by anoopm on 19/04/16.
//  Copyright © 2016 anoopm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shape : NSObject

@property(nonatomic, strong) NSMutableArray *arrayOfPoints;
-(instancetype) initWithShapeData:(NSDictionary*) shapeDictionary;

@end
