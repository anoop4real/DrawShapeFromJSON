//
//  ViewController.m
//  ShapeJSONDraw
//
//  Created by anoopm on 19/04/16.
//  Copyright © 2016 anoopm. All rights reserved.
//

#import "ViewController.h"
#import "Shape.h"
#import "ShapeView.h"

@interface ViewController ()
{
    NSMutableArray *arrayOfShapes;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        arrayOfShapes = [[NSMutableArray alloc] init];
    [self parseData];
    myScrollView.minimumZoomScale=1.0;
    myScrollView.maximumZoomScale=10.0;
    myScrollView.delegate=self;
    myScrollView.contentSize = self.view.frame.size;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) parseData
{
    
    
    //    NSData *data = [NSData dataWithContentsOfFile:jsonPath options:NSDataReadingMappedAlways | NSDataReadingUncached error:&error];
    // convert `boat.geojson` to an NSDIctionary
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"Shapes" ofType:@"json"];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[[NSData alloc]
                                                                  initWithContentsOfFile:jsonPath]
                                                         options:0
                                                           error:&error];
    NSArray *responsejson = json[@"Shapes"];
    CGFloat width = [json[@"canvasWidth"] floatValue];
    CGFloat height = [json[@"canvasHeight"] floatValue];
    myview.canvasWidth = width;
    myview.canvasHeight = height;
    for (int i=0; i<responsejson.count; i++) {
        Shape *shape = [[Shape alloc] initWithShapeData:responsejson[i]];
        [arrayOfShapes addObject:shape];
    }
    [self render];
}

- (void) render
{
    [myview setUpDataWithArray:arrayOfShapes];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView

{
    // Return the image subview as the view to be zoomed
    return myview;
}
@end
