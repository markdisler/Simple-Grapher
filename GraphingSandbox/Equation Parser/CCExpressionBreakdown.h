//
//  CCExpressionBreakdown.h
//  CapCalc Pro
//
//  Created by Mark on 7/15/16.
//  Copyright © 2016 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCExpressionBreakdown : NSObject

+ (NSArray *)buildArrayOfTokensForExpression:(NSString *)expression;
+ (NSString *)expressionForTokenArray:(NSArray *)parserTokens;

@end
