//
//  FunctionLibrary.h
//  MDParserIOD
//
//  Created by Mark on 8/25/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FunctionLibrary : NSObject

#pragma mark - Others
+ (float)factorial:(float)n;
+ (NSString *)binToDec:(NSString *)binary;
+ (NSString *)decToBin:(long)decimal;

#pragma mark - Rounding Functions
+ (float)ceiling:(float)num;
+ (float)floorRound:(float)num;
+ (float)greatestInteger:(float)num;

#pragma mark - Statistics Functions
+ (float)minimum:(NSArray *)data;
+ (float)maximum:(NSArray *)data;
+ (float)median:(NSArray *)data;
+ (float)average:(NSArray *)data;

@end
