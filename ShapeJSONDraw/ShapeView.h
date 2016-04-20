//
//  ShapeView.h
//  ShapeJSONDraw
//
//  Created by anoopm on 19/04/16.
//  Copyright © 2016 anoopm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShapeView : UIView

@property(nonatomic, strong)NSMutableArray *shapesArray;

-(void) setUpDataWithArray:(NSMutableArray*) array;

@end
