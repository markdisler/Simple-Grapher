//
//  MDParser.m
//  MDParser
//
//  Created by Mark on 8/1/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import "MDParser.h"
#import "CCFunctions.h"
#import "TrigFunctions.h"
#import "MDReplacement.h"
#import "CCExpressionParser.h"
#import "CCExpressionBreakdown.h"

@implementation MDParser

+ (NSString *)parseEquation:(NSString *)expression {

    NSString *finalAnswer = @"";
    expression = [MDParserHelper balanceClosingParen:expression];
    
    if ([MDParserHelper validateParenPairing:expression]) {
        @try {
            //Split into tokens
            expression = [MDReplacement initialExpressionReplacements:expression];
            NSArray *tokens = [CCExpressionBreakdown buildArrayOfTokensForExpression:expression];
        //    NSLog(@"%@", tokens);
            
            //Begin parsing
            NSArray *endTokens = [self parseEquationPart:tokens];
            finalAnswer = [endTokens objectAtIndex:0];
            
            //Get the final answer
            long double final = [MDParserHelper parseStringToLongDouble:finalAnswer];
            finalAnswer = [NSString stringWithFormat:@"%LG", final];
            finalAnswer = [finalAnswer stringByReplacingOccurrencesOfString:@"E+" withString:@"E"];
        }
        @catch (NSException *exception) {
            if ([exception.name isEqualToString:@"Function Undefined"])
                return @"Undefined";
            else if ([exception.name isEqualToString:@"Invalid Parameters"])
                return @"InvalidParamError";
            return @"Error"; //Just in case there was a major input issue
        }
        return finalAnswer;
    }
    return @"Error";
}

+ (NSArray *)parseEquationPart:(NSArray *)expressionTokens {

    // Helpers called to clean up the equation for basic evaluation.  Takes care of functions, roots, exponents,...
    expressionTokens = [CCFunctions fixExtraFunctions:expressionTokens];
    expressionTokens = [CCFunctions fixRoots:expressionTokens];
    expressionTokens = [CCFunctions fixLogarithms:expressionTokens];
    expressionTokens = [CCFunctions fixTrigFunctions:expressionTokens];
            
    // Final evaluation of basic math ( (), ^, +, -, *, / )
    expressionTokens = [CCExpressionParser parseExpression:expressionTokens];
    
    //Return the final answer
    return expressionTokens;
}

@end
