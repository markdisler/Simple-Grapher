//
//  CCExpressionBreakdown.m
//  CapCalc Pro
//
//  Created by Mark on 7/15/16.
//  Copyright © 2016 mark. All rights reserved.
//

#import "CCExpressionBreakdown.h"
#import "MDParserHelper.h"
#import "NSString+Refined.h"

@implementation CCExpressionBreakdown

+ (NSArray *)buildArrayOfTokensForExpression:(NSString *)expression {
    
    if ([expression characterAtIndex:0] == '-') {
        expression = [NSString stringWithFormat:@"0%@", expression];
    }
    
    NSMutableString *temporaryNumberString = [NSMutableString string];
    NSMutableString *temporaryFunctionString = [NSMutableString string];
    
    NSMutableArray *tokens = [NSMutableArray array];
    for (NSInteger i = 0; i < expression.length; i++) {
        NSString *character = [expression substringFrom:i to:i+1];
        NSString *previous = i == 0 ? @"" : [expression substringFrom:i-1 to:i];
        char characterAsChar = [character UTF8String][0];
        
        //Functions and Numbers
       
        BOOL isOperator = [CCExpressionBreakdown isCharacterAnOperator:character previousCharacter:previous];
        if ([MDParserHelper checkIfNumberWithDec:character] || ([character isEqualToString:@"-"] && !isOperator)) {
            if ([previous isEqualToString:@")"]) {
                [tokens addObject:@"*"];
            }
            [temporaryNumberString appendString:character];
        } else {
            if (![temporaryNumberString isEqualToString:@""]) {
                [tokens addObject:[temporaryNumberString copy]];
                [temporaryNumberString setString:@""];
            }
        }
        
        if ([MDParserHelper checkIfFuncCharacter:characterAsChar]) {
            if ([previous isEqualToString:@")"] || [NSString checkIfNumber:previous]) {
                [tokens addObject:@"*"];
            }
            [temporaryFunctionString appendString:character];
        } else {
            if (![temporaryFunctionString isEqualToString:@""]) {
                [tokens addObject:[temporaryFunctionString copy]];
                [temporaryFunctionString setString:@""];
            }
        }
        
        //Binary Operators
        
        if ([character isEqualToString:@"+"]) {
            [tokens addObject:character];
        }
        if ([character isEqualToString:@"-"]) {
            if (isOperator) {
                [tokens addObject:[character copy]];
            }
        }
        if ([character isEqualToString:@"*"]) {
            [tokens addObject:character];
        }
        if ([character isEqualToString:@"/"] || [character isEqualToString:@"%"]) {
            [tokens addObject:character];
        }
        if ([character isEqualToString:@"^"]) {
            [tokens addObject:character];
        }
    
        //Unary Operators
        
        if ([character isEqualToString:@"!"]) {
            [tokens addObject:character];
        }
        
        //Extra characters
        if ([character isEqualToString:@"("]) {
            if ([NSString checkIfNumber:previous] || [previous isEqualToString:@")"]) {
                [tokens addObject:@"*"];
            }
            [tokens addObject:character];
        }
        if ([character isEqualToString:@")"]) {
            [tokens addObject:character];
        }
        if ([character isEqualToString:@","]) {
            [tokens addObject:character];
        }
        
    }
    if (![[temporaryNumberString copy] isEqualToString:@""]) {
        [tokens addObject:[temporaryNumberString copy]];
        [temporaryNumberString setString:@""];
    }
    
    NSArray *stringTokenArray = [tokens copy];
    return stringTokenArray;
}

+ (BOOL)isCharacterAnOperator:(NSString *)character previousCharacter:(NSString *)previousCharacter {
    for (NSString *operator in [self arrayOfOperators]) {
        if ([operator isEqualToString:character]) {
            if ([character isEqualToString:@"+"] && [previousCharacter isEqualToString:@"E"]) {
                return NO;
            } else if ([character isEqualToString:@"-"] && [previousCharacter isEqualToString:@"("]) {
                return NO;
            } else if ([character isEqualToString:@"-"] && [previousCharacter isEqualToString:@"E"]) {
                return NO;
            } else if ([character isEqualToString:@"-"] && [previousCharacter isEqualToString:@""]) {
                return NO;
            } else if ([character isEqualToString:@"-"]) {
                for (NSString *operator in [self arrayOfOperators]) {
                    if ([operator isEqualToString:previousCharacter]) {
                        return NO;
                    }
                }
            }
            return YES;
        }
    }
    return NO;
}

+ (NSArray *)arrayOfOperators {
    return @[@"^", @"*", @"/", @"+", @"-", @"%"];
}

+ (NSString *)expressionForTokenArray:(NSArray *)parserTokens {
    NSMutableString *expression = [NSMutableString string];
    for (NSString *token in parserTokens) {
        [expression appendString:token];
    }
    return [expression copy];
}

@end
