//
//  GraphView.m
//  GraphingTest
//
//  Created by Mark on 5/24/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import "GraphView.h"
#import "CCGraphableFunction.h"
#import "MDParser.h"
#import "UIColor+CCColors.h"

@interface GraphView ()

@property (nonatomic, assign) float xMin;
@property (nonatomic, assign) float xMax;
@property (nonatomic, assign) NSInteger xInc;
@property (nonatomic, assign) float yMin;
@property (nonatomic, assign) float yMax;
@property (nonatomic, assign) NSInteger yInc;

@property (nonatomic, assign) float coreAxisLength;

@property (nonatomic, assign) float xMultiplier;
@property (nonatomic, assign) float yMultiplier;

@property (nonatomic, strong) UIView *xAxisLine;
@property (nonatomic, strong) UIView *yAxisLine;

@property (nonatomic, strong) NSMutableArray *gridlines;

@property (nonatomic, assign) CGPoint centerOffsetFromFrameOrigin;

@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, assign) CGPoint startingPoint;
@property (nonatomic, assign) float lastScale;

@end

@implementation GraphView

- (id)initWithAxisLength:(CGFloat)length {
    self = [super initWithFrame:CGRectMake(0, 0, length, length)];
    if (self) {
        
        
        // Array to store all functions to be graphed on this graph view
        self.availableFunctions = [NSMutableArray array];
        
        // Set length of both x & y axis
        length -= 40;
        self.coreAxisLength = length;
        
        // Set clear background
        [self setBackgroundColor:[UIColor clearColor]];
        
        // Create x and y axis lines
        self.yAxisLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds), 0, 1, self.coreAxisLength + 35)];
        self.xAxisLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMidY(self.bounds), self.coreAxisLength + 35, 1)];
        
        // Array to store ALL gridlines (horizontal and vertical)
        self.gridlines = [NSMutableArray array];
        
        // Create gesutre for panning around graph
        UIPanGestureRecognizer *scrollPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesturePan:)];
        scrollPan.cancelsTouchesInView = NO;
        scrollPan.delegate = self;
        [scrollPan setMinimumNumberOfTouches:1];
        [scrollPan setMaximumNumberOfTouches:1];
        [self addGestureRecognizer:scrollPan];
        
        // Create gesture for zooming
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(gesturePinch:)];
        pinchGesture.cancelsTouchesInView = NO;
        pinchGesture.delegate = self;
        [self addGestureRecognizer:pinchGesture];
        
        // Set graph bounds
        [self updateWindowBounds];
    }
    return self;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}

- (void)updateWindowBounds {
    self.xMin = -20;
    self.xMax = 20;
    self.xInc = 1;
    self.yMin = -20;
    self.yMax = 20;
    self.yInc = 1;
}

- (void)createGeneralGraph {

    // Get lengths of the units on each axis
    float yAxisCoordinateMagnitude = self.yMax - self.yMin;
    float xAxisCoordinateMagnitude = self.xMax - self.xMin;
    xAxisCoordinateMagnitude = MAX(1, xAxisCoordinateMagnitude);
    yAxisCoordinateMagnitude = MAX(1, yAxisCoordinateMagnitude);
    
    // Find the length (in points) that is equivalent to 1 graph unit
    CGFloat yAxisIncrementLength = self.coreAxisLength / yAxisCoordinateMagnitude;
    CGFloat xAxisIncrementLength = self.coreAxisLength / xAxisCoordinateMagnitude;
    
    // Offsets from CGPoint(0,0) that represent the graph's origin point
    float yOffsetForOrigin = self.yMax * yAxisIncrementLength + 20;
    float xOffsetForOrigin = self.xMax * xAxisIncrementLength + 20;
    
    // Remove the axis (will be added back later if they should be on screen)
    [self.yAxisLine removeFromSuperview];
    [self.xAxisLine removeFromSuperview];

    // if the yAxis (x = 0) can be displayed given the x bounds, display it
    if (self.xMin <= 0 && 0 <= self.xMax) {
        [self.yAxisLine setCenter:CGPointMake(xOffsetForOrigin, self.frame.size.height/2)];
        [self.yAxisLine setBackgroundColor:[UIColor blackColor]];
        [self addSubview:self.yAxisLine];
    }
    
    // if the xAxis (y = 0) can be displayed given the y bounds, display it
    if (self.yMin <= 0 && 0 <= self.yMax) {
        [self.xAxisLine setCenter:CGPointMake(self.frame.size.width/2, yOffsetForOrigin)];
        [self.xAxisLine setBackgroundColor:[UIColor blackColor]];
        [self addSubview:self.xAxisLine];
    }
    
    // Remove all gridlines from the graph
    for (UIView *line in self.gridlines) {
        [line removeFromSuperview];
    }
    [self.gridlines removeAllObjects];
    
    
    self.xMultiplier = self.coreAxisLength / (self.xMax - self.xMin);
    self.yMultiplier = self.coreAxisLength / (self.yMax - self.yMin);
    
    for (NSInteger i = self.xMin-2; i <= self.xMax+2; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds), 0, 1, self.coreAxisLength+40)];
        [line setCenter:CGPointMake(xOffsetForOrigin - (i * self.xMultiplier), self.frame.size.height/2)];
        [line setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.15]];
        [self addSubview:line];
        [self.gridlines addObject:line];
    }
    
    for (NSInteger i = self.yMin-2; i <= self.yMax+2; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMidY(self.bounds), self.coreAxisLength+40, 1)];
        [line setCenter:CGPointMake(self.frame.size.width/2, yOffsetForOrigin - (i * self.yMultiplier))];
        [line setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.15]];
        [self addSubview:line];
        [self.gridlines addObject:line];
    }
    
    self.centerOffsetFromFrameOrigin = CGPointMake(xOffsetForOrigin, yOffsetForOrigin);
    
    NSLog(@"%f, %f | %f, %f", self.xMin, self.xMax, self.yMin, self.yMax);
}

- (void)graphEquation:(CCGraphableFunction *)function {

    // Add this function to the internal list of functions
    [self.availableFunctions addObject:function];
    
    // Reset any previously-calculated coordinate points
    [function clearScaledCoordinates];
    [function clearPath];
    
    // Pull the actual function string out of the function object
    NSString *equation = function.functionString;
    
    // Graph from [xMin, xMax] while incremending by 0.05
    for (long double x = self.xMin; x <= self.xMax; x+=0.05) {
    
        // Convert the current loop value to a string
        NSString *val = [NSString stringWithFormat:@"(%LG)",x];
        
        // Replace the 'x' in the function with this value
        NSString *eval = [NSString stringWithFormat:@"%@", [equation stringByReplacingOccurrencesOfString:@"x" withString:val]];
        
        // Throw the expression through the parser
        NSString *answer = [MDParser parseEquation:eval];
        
        // If no error, graph the calculated 'y' value at the given x
        if (![answer isEqualToString:@"Error"]) {
            double y = [answer doubleValue];
            [self graphPoint:CGPointMake(x, y) forEquation:function];
        }
    }
}

- (void)graphPoint:(CGPoint)pt forEquation:(CCGraphableFunction *)function {
    self.xMultiplier = self.coreAxisLength / (self.xMax - self.xMin);
    self.yMultiplier = self.coreAxisLength / (self.yMax - self.yMin);
    
    [function.rawCoordinates addObject:[NSValue valueWithCGPoint:pt]];
    pt = CGPointMake(pt.x * self.xMultiplier, pt.y * self.yMultiplier);
    
    CGPoint convertedPt = CGPointMake(self.centerOffsetFromFrameOrigin.x + pt.x , self.centerOffsetFromFrameOrigin.y - pt.y);
    [function.scaledCoordinates addObject:[NSValue valueWithCGPoint:convertedPt]];
    
    UIBezierPath *path = function.path;
    
    if (function.scaledCoordinates.count == 1) {
        NSValue *first = [function.scaledCoordinates objectAtIndex:0];
        CGPoint pt1 = first.CGPointValue;
        [path moveToPoint:pt1];
    } else {
        NSValue *other = [function.scaledCoordinates objectAtIndex:function.scaledCoordinates.count-1];
        CGPoint pt = other.CGPointValue;
        [path addLineToPoint:pt];
    }
    [self setNeedsDisplay];
}

- (void)regraph {
    for (CCGraphableFunction *function in self.availableFunctions) {
        [function clearScaledCoordinates];
        [function clearPath];
        
        self.xMultiplier = self.coreAxisLength / (self.xMax - self.xMin);
        self.yMultiplier = self.coreAxisLength / (self.yMax - self.yMin);
        
        for (NSValue *value in function.rawCoordinates) {
            CGPoint pt = [value CGPointValue];
            pt = CGPointMake(pt.x * self.xMultiplier, pt.y * self.yMultiplier);
            
            CGPoint convertedPt = CGPointMake(self.centerOffsetFromFrameOrigin.x + pt.x , self.centerOffsetFromFrameOrigin.y - pt.y);
            [function.scaledCoordinates addObject:[NSValue valueWithCGPoint:convertedPt]];
            
            UIBezierPath *path = function.path;
            
            if (function.scaledCoordinates.count == 1) {
                NSValue *first = [function.scaledCoordinates objectAtIndex:0];
                CGPoint pt1 = first.CGPointValue;
                [path moveToPoint:pt1];
            } else {
                NSValue *other = [function.scaledCoordinates objectAtIndex:function.scaledCoordinates.count-1];
                CGPoint pt = other.CGPointValue;
                [path addLineToPoint:pt];
            }
            [self setNeedsDisplay];
        }
    }
}

- (void)gesturePan:(UIPanGestureRecognizer *)pan {
    CGPoint currentPoint = [pan locationInView:self];
    float deltaX = currentPoint.x - self.lastPoint.x;
    float deltaY = currentPoint.y - self.lastPoint.y;
    float realDeltaX = deltaX / self.xMultiplier;
    float realDeltaY = deltaY / self.yMultiplier;
    self.lastPoint = [pan locationInView:self];
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        self.xMin += realDeltaX;
        self.xMax += realDeltaX;
        self.yMin += realDeltaY;
        self.yMax += realDeltaY;
        [self createGeneralGraph];
        [self regraph];
    }
}

- (void)gesturePinch:(UIPinchGestureRecognizer *)pinch {
    
    if (pinch.state == UIGestureRecognizerStateBegan) {
        self.lastScale = 1.0;
        self.lastPoint = [pinch locationInView:self];
        self.startingPoint = [pinch locationInView:self];
    } else if (pinch.state == UIGestureRecognizerStateChanged) {

        CGFloat scale = 1.0 - (self.lastScale - pinch.scale);
        self.lastScale = pinch.scale;
        

        float centerX = (self.startingPoint.x - self.centerOffsetFromFrameOrigin.x) / self.xMultiplier;
        float centerY = (self.startingPoint.y - self.centerOffsetFromFrameOrigin.y) / self.yMultiplier;
        
        float minToCenterX = centerX - self.xMin;
        float maxToCenterX = self.xMax - centerX;
        float minToCenterY = centerY - self.yMin;
        float maxToCenterY = self.yMax - centerY;
        
        float newMinToCenterX = minToCenterX / scale;
        float newMaxToCenterX = maxToCenterX / scale;
        float newMinToCenterY = minToCenterY / scale;
        float newMaxToCenterY = maxToCenterY / scale;
        
        CGPoint currentP = [pinch locationInView:self];
        
        self.xMin = centerX - newMinToCenterX;
        self.xMax = centerX + newMaxToCenterX;
        self.yMin = centerY - newMinToCenterY;
        self.yMax = centerY + newMaxToCenterY;
        
        
        float deltaX = currentP.x - self.lastPoint.x;
        float deltaY = currentP.y - self.lastPoint.y;
        float realDeltaX = deltaX / self.xMultiplier;
        float realDeltaY = deltaY / self.yMultiplier;
        self.lastPoint = [pinch locationInView:self];
        
        self.xMin += realDeltaX;
        self.xMax += realDeltaX;
        self.yMin += realDeltaY;
        self.yMax += realDeltaY;
        
        [self createGeneralGraph];
        [self regraph];
    }
    
    self.lastPoint = [pinch locationInView:self];
}

- (void)clearGraph {
    // Visit each function and clear all calculated values and the graph
    for (CCGraphableFunction *function in self.availableFunctions) {
        [function clearScaledCoordinates];
        [function clearPath];
        [function clearRawCoordinates];
    }
    
    // Remove all the functions
    [self.availableFunctions removeAllObjects];
}

- (void)drawRect:(CGRect)rect {
    // Note: CCGraphableFunction stores the visual graph and collection of points
    // Visit each function, set the stroke color, and draw out the visual graph
    for (CCGraphableFunction *function in self.availableFunctions) {
        [[UIColor colorWithHex:function.functionHexColor] set];
        [function.path stroke];
        [[UIColor clearColor] setFill];
    }
}


@end
