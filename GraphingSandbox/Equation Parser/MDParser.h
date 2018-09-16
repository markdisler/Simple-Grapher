//
//  MDParser.h
//  MDParser
//
//  Created by Mark on 8/1/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDParserHelper.h"

@interface MDParser : NSObject
+ (NSString *)parseEquation:(NSString *)expression;
+ (NSArray *)parseEquationPart:(NSArray *)expressionTokens;
@end
