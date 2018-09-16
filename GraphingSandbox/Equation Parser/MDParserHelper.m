//
//  MDParserHelper.m
//  MDParser
//
//  Created by Mark on 8/1/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import "MDParserHelper.h"
#import "MDParser.h"
#import "NSString+Refined.h"

@implementation MDParserHelper

+ (long double)parseStringToLongDouble:(NSString *)value {
    value = [MDParserHelper parseNegativeSign:value];
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    BOOL isDecimal = [nf numberFromString:value] != nil;
    if (isDecimal) {
        return [value doubleValue];
    } else {
        [NSException raise:@"Improper Parse" format:@"Value parsed is not numeric."];
        return [value floatValue];
    }
}

+ (NSString *)parseNegativeSign:(NSString *)exp {
    while ([exp containsString:@"--"]) {
        NSInteger firstN = [exp indexOf:@"--" after:0];
        NSInteger lastN = [MDParserHelper findNextNumberStartingAt:firstN inExpression:exp];
        NSString *nString = [exp substringFrom:firstN to:lastN];
        NSInteger numberOfNs = nString.length;
        NSInteger multiplier = 1;
        for (NSInteger i = 0; i < numberOfNs; i++)
            multiplier *= -1;
        
        NSString *begin = [exp substringToIndex:firstN];
        NSString *end = [exp substringFromIndex:lastN];
        
        NSString *signToInsert = @"";
        if (begin.length > 0) {
            NSString *charToLeft = [begin substringFrom:begin.length-1 to:begin.length];
            BOOL doesNotNeedOp = [MDParserHelper checkIfOperator:charToLeft];
            if (!doesNotNeedOp)
                signToInsert = @"+";
        }
        
        if (multiplier < 0)
            exp = [NSString stringWithFormat:@"%@%@-%@", begin,signToInsert, end];
        else
            exp = [NSString stringWithFormat:@"%@%@%@", begin, signToInsert, end];
    }
    return exp;
}

+ (BOOL)checkIfNumberWithDec:(NSString *)s {
    if ([s isEqualToString:@"."]) return YES;
    if ([s isEqualToString:@"E"]) return YES;
    return [NSString checkIfNumber:s];
}

+ (BOOL)checkIfFuncCharacter:(char)c {
    return (c != 'E') && ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'));
}

#pragma mark - Parenthesis Validation and Correction

+ (BOOL)validateParenPairing:(NSString *)s {
    NSInteger numOpen = [s countNumberOf:@"("];
    NSInteger numClosed = [s countNumberOf:@")"];
    if (numOpen != numClosed)
        return NO;
    return YES;
}

+ (NSString *)balanceClosingParen:(NSString *)s {
    NSInteger numOpen = [s countNumberOf:@"("];
    NSInteger numClosed = [s countNumberOf:@")"];
    NSInteger numMissing = numOpen - numClosed;
    NSString *extraClosing = @"";
    for (NSInteger i = 0; i < numMissing; i++)
        extraClosing = [NSString stringWithFormat:@"%@%@", extraClosing, @")"];
    s = [NSString stringWithFormat:@"%@%@", s, extraClosing];
    return s;
}

#pragma mark - Find Location of Corresponding Parenthesis (Open/Closed)

+ (NSInteger)positionOfCorrespondingClosedParen:(NSInteger)n in:(NSArray *)s {
    NSInteger openParenCounter = 0;
    NSInteger closedParenCounter = 0;
    for (NSInteger i = n; i < s.count; i++) {
        NSString *current = [s objectAtIndex:i];
        BOOL isOpenParen = [current isEqualToString:@"("];
        BOOL isClosedParen = [current isEqualToString:@")"];
        if (isOpenParen)
            openParenCounter++;
        else if (isClosedParen) {
            closedParenCounter++;
            if (openParenCounter == closedParenCounter)
                return i;
        }
    }
    return -1;
}

#pragma mark - Operator Searching

+ (NSInteger)findNextNumberStartingAt:(NSInteger)n inExpression:(NSString *)str {
    for (NSInteger i = n; i < str.length; i++) {
        NSString *current = [str substringWithRange:NSMakeRange(i, 1)];
        BOOL isNumber = [NSString checkIfNumber:current];
        if (isNumber)
            return i;
    }
    return -1;
}

+ (NSInteger)findNextNumberOrOperator:(NSInteger)n in:(NSString*)s {
    for (NSInteger i = n; i >= 0; i--) {
        NSString *current = [s substringWithRange:NSMakeRange(i, 1)];
        BOOL isNumber = [NSString checkIfNumber:current];
        if (isNumber)
            return i;
        else if ([current isEqualToString:@"+"])
            return i;
        else if ([current isEqualToString:@"-"])
            return i;
        else if ([current isEqualToString:@"*"])
            return i;
        else if ([current isEqualToString:@"/"])
            return i;
        else if ([current isEqualToString:@"%"])
            return i;
        else if ([current isEqualToString:@")"])
            return i;
        else if ([current isEqualToString:@"π"])
            return i;
    }
    return -1;
}

+ (BOOL)checkIfOperator:(NSString*)current {
    if ([current isEqualToString:@"+"])
        return YES;
    else if ([current isEqualToString:@"-"])
        return YES;
    else if ([current isEqualToString:@"*"])
        return YES;
    else if ([current isEqualToString:@"%"])
        return YES;
    else if ([current isEqualToString:@"/"])
        return YES;
    else if ([current isEqualToString:@")"])
        return YES;
    else if ([current isEqualToString:@"π"])
        return YES;
    return NO;
}

#pragma mark - Parsing Assistance

+ (NSDictionary *)replacementValsForFunc:(NSString *)func in:(NSArray *)expTokens {
    NSInteger funcLocation = [expTokens indexOfObject:func];
    NSInteger correspondingOpenParen = funcLocation + 1;
    NSInteger correspondingCloseParen = [self positionOfCorrespondingClosedParen:correspondingOpenParen in:expTokens];
    
    NSArray *subsetTokens = [expTokens subarrayWithRange:NSMakeRange(correspondingOpenParen+1, correspondingCloseParen - (correspondingOpenParen+1))];
    
    if (subsetTokens.count < 1) {
        [NSException raise:@"Unacceptable Parameters" format:@"An empty string is not proper input."];
    }
    
    subsetTokens = [MDParser parseEquationPart:subsetTokens];
    
    NSArray *begin = [expTokens subarrayWithRange:NSMakeRange(0, funcLocation)];
    NSArray *end = [expTokens subarrayWithRange:NSMakeRange(correspondingCloseParen + 1, expTokens.count - (correspondingCloseParen + 1))];
    
    NSDictionary *vals = @{ @"before" : begin, @"after" : end, @"val" : [subsetTokens objectAtIndex:0] };
    return vals;
}

+ (NSDictionary *)replacementValsForFuncWithParamList:(NSString*)func inExpression:(NSArray *)expTokens {
    NSInteger funcLocation = [expTokens indexOfObject:func];
    NSInteger correspondingOpenParen = funcLocation + 1;
    NSInteger correspondingCloseParen = [self positionOfCorrespondingClosedParen:correspondingOpenParen in:expTokens];
    
    NSArray *subsetTokens = [expTokens subarrayWithRange:NSMakeRange(correspondingOpenParen+1, correspondingCloseParen - (correspondingOpenParen+1))];
    
    if (subsetTokens.count < 1) {
        [NSException raise:@"Unacceptable Parameters" format:@"An empty string is not proper input."];
    }
    
    NSArray<NSArray *> *arguments = [MDParserHelper argumentsForParameterPass:subsetTokens];
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSArray *argumentTokens in arguments) {
        NSArray *evaled = [MDParser parseEquationPart:argumentTokens];
        [array addObject:[evaled objectAtIndex:0]];
    }

    NSArray *begin = [expTokens subarrayWithRange:NSMakeRange(0, funcLocation)];
    NSArray *end = [expTokens subarrayWithRange:NSMakeRange(correspondingCloseParen + 1, expTokens.count - (correspondingCloseParen + 1))];
    
    NSDictionary *vals = @{ @"before" : begin, @"after" : end, @"val" : [array copy] };
    return vals;
}

+ (NSArray<NSArray *> *)argumentsForParameterPass:(NSArray *)tokens {
    NSMutableArray<NSArray *> *allArgs = [NSMutableArray array];
    
    NSMutableArray *anArg = [NSMutableArray array];
    for (NSString *token in tokens) {
        if (![token isEqualToString:@","]) {
            [anArg addObject:token];
        } else {
            [allArgs addObject:[anArg copy]];
            anArg = [NSMutableArray array];
        }
    }
    [allArgs addObject:[anArg copy]];
    return [allArgs copy];
}

@end
