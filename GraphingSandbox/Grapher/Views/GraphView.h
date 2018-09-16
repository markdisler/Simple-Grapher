//
//  GraphView.h
//  GraphingTest
//
//  Created by Mark on 5/24/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCGraphableFunction;

@interface GraphView : UIView <UIGestureRecognizerDelegate>

- (id)initWithAxisLength:(CGFloat)length;
- (void)graphEquation:(CCGraphableFunction *)function;
- (void)createGeneralGraph;
- (void)clearGraph;

@property NSMutableArray *availableFunctions;

@end
