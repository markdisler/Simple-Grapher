//
//  CCFunctions.h
//  CapCalc
//
//  Created by Mark on 6/6/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCFunctions : NSObject
+ (NSArray *)fixRoots:(NSArray *)expTokens;
+ (NSArray *)fixLogarithms:(NSArray *)expTokens;
+ (NSArray *)fixTrigFunctions:(NSArray *)expTokens;

+ (NSArray *)fixExtraFunctions:(NSArray *)expTokens;
@end
