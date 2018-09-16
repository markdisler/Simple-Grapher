//
//  CCExpressionParser.m
//  CapCalc Pro
//
//  Created by Mark on 7/15/16.
//  Copyright © 2016 mark. All rights reserved.
//

#import "CCExpressionParser.h"
#import "CCExpressionBreakdown.h"
#import "FunctionLibrary.h"
#import "MDParserHelper.h"

@implementation CCExpressionParser

+ (NSArray *)parseExpression:(NSArray *)tokens {
    tokens = [self parseParenthesis:tokens];
    tokens = [self parseFactorial:tokens];
    tokens = [self parseOperation:tokens operation1:@"^" operation2:@"^"];

    tokens = [self parseOperation:tokens operation1:@"*" operation2:@"/"];
    tokens = [self parseOperation:tokens operation1:@"+" operation2:@"-"];
        tokens = [self parseOperation:tokens operation1:@"%" operation2:@"%"];
    return tokens;
}

+ (NSArray *)parseParenthesis:(NSArray *)expTokens {
    while ([expTokens containsObject:@"("]) {
        if ([expTokens containsObject:@"("]) {
            
            NSInteger correspondingOpenParen = [expTokens indexOfObject:@"("];
            NSInteger correspondingCloseParen = [MDParserHelper positionOfCorrespondingClosedParen:correspondingOpenParen in:expTokens];
            
            NSArray *subsetTokens = [expTokens subarrayWithRange:NSMakeRange(correspondingOpenParen+1, correspondingCloseParen - (correspondingOpenParen+1))];
            
            NSArray *evaluatedInside = [self parseExpression:subsetTokens];
            
            NSArray *begin = [expTokens subarrayWithRange:NSMakeRange(0, correspondingOpenParen)];
            NSArray *end = [expTokens subarrayWithRange:NSMakeRange(correspondingCloseParen + 1, expTokens.count - (correspondingCloseParen + 1))];
            
            NSMutableArray *rebuildingArray = [NSMutableArray arrayWithArray:begin];
            [rebuildingArray addObject:[evaluatedInside objectAtIndex:0]];
            [rebuildingArray addObjectsFromArray:end];
            expTokens = rebuildingArray.copy;
        }
    }
    return expTokens;
}

+ (NSArray *)parseFactorial:(NSArray *)parserTokens {
    while ([parserTokens containsObject:@"!"]) {
        NSInteger core = [parserTokens indexOfObject:@"!"];
        
        NSString *firstNumber = [parserTokens objectAtIndex:core-1];
        firstNumber = [[self parseExpression:@[firstNumber]] objectAtIndex:0];
        
        long double result = [FunctionLibrary factorial:[MDParserHelper parseStringToLongDouble:firstNumber]];
        NSString *resultStr = [NSString stringWithFormat:@"%LG", result];
        
        NSMutableArray *newParserTokenArray = [NSMutableArray arrayWithArray:parserTokens];
        [newParserTokenArray replaceObjectAtIndex:core withObject:resultStr];
        [newParserTokenArray removeObjectAtIndex:core-1];
        parserTokens = [newParserTokenArray copy];
    }
    return parserTokens;
}

+ (NSArray *)parseOperation:(NSArray *)parserTokens operation1:(NSString *)sign1 operation2:(NSString *)sign2 {
    while ([parserTokens containsObject:sign1] || [parserTokens containsObject:sign2]) {
        NSString *sign;
        
        NSInteger possibleCore1 = [parserTokens indexOfObject:sign1];
        NSInteger possibleCore2 = [parserTokens indexOfObject:sign2];
        
        if (possibleCore1 == -1) {
            sign = sign2;
        } else if (possibleCore2 == -1) {
            sign = sign1;
        }
        else if (possibleCore1 < possibleCore2) {
            sign = sign1;
        } else {
            sign = sign2;
        }
        
        if ([parserTokens containsObject:sign]) {
            
            NSInteger core = [parserTokens indexOfObject:sign];
            
            NSString *firstNumber = [parserTokens objectAtIndex:core-1];
            firstNumber = [[self parseExpression:@[firstNumber]] objectAtIndex:0];
            
            NSString *secondNumber = [parserTokens objectAtIndex:core+1];
            secondNumber = [[self parseExpression:@[secondNumber]] objectAtIndex:0];
        
            long double result = 0.0;
            
            if ([sign isEqualToString:@"+"])
                result = [MDParserHelper parseStringToLongDouble:firstNumber] + [MDParserHelper parseStringToLongDouble:secondNumber];
            else if ([sign isEqualToString:@"-"])
                result = [MDParserHelper parseStringToLongDouble:firstNumber] - [MDParserHelper parseStringToLongDouble:secondNumber];
            else if ([sign isEqualToString:@"*"])
                result = [MDParserHelper parseStringToLongDouble:firstNumber] * [MDParserHelper parseStringToLongDouble:secondNumber];
            else if ([sign isEqualToString:@"/"]) {
                long double denominator = [MDParserHelper parseStringToLongDouble:secondNumber];
                if (denominator == 0) {
                    [NSException raise:@"Error" format:@"Cannot divide by 0."];
                } else {
                    result = [MDParserHelper parseStringToLongDouble:firstNumber] / denominator;
                }
            } else if ([sign isEqualToString:@"%"]) {
                long double denominator = [MDParserHelper parseStringToLongDouble:secondNumber];
                if (denominator == 0) {
                    [NSException raise:@"Error" format:@"Cannot divide by 0."];
                } else {
                    result = (long)[MDParserHelper parseStringToLongDouble:firstNumber] % (long)denominator;
                    if (result < 0) {
                        result += (long)denominator;
                    }
                }
            } else if ([sign isEqualToString:@"^"]) {
                result = powl([MDParserHelper parseStringToLongDouble:firstNumber], [MDParserHelper parseStringToLongDouble:secondNumber]);
            }
            
            NSString *resultStr = [NSString stringWithFormat:@"%LG", result];
        
            NSMutableArray *newParserTokenArray = [NSMutableArray arrayWithArray:parserTokens];
            [newParserTokenArray replaceObjectAtIndex:core withObject:resultStr];
            [newParserTokenArray removeObjectAtIndex:core+1];
            [newParserTokenArray removeObjectAtIndex:core-1];
            parserTokens = [newParserTokenArray copy];
        }
    }
    return parserTokens;
}

@end
