//
//  MDParserHelper.h
//  MDParser
//
//  Created by Mark on 8/1/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDParserHelper : NSObject

#pragma mark - General Important Stuff
+ (long double)parseStringToLongDouble:(NSString *)value;
+ (BOOL)checkIfNumberWithDec:(NSString *)s;
+ (BOOL)checkIfFuncCharacter:(char)c;

#pragma mark - Parenthesis Validation and Correction
+ (BOOL)validateParenPairing:(NSString *)s;
+ (NSString *)balanceClosingParen:(NSString *)s;

#pragma mark - Find Location of Corresponding Parenthesis (Open/Closed)
+ (NSInteger)positionOfCorrespondingClosedParen:(NSInteger)n in:(NSArray *)s;

#pragma mark - Parsing Assistance
+ (NSDictionary *)replacementValsForFunc:(NSString *)func in:(NSArray *)expTokens;
+ (NSDictionary *)replacementValsForFuncWithParamList:(NSString*)func inExpression:(NSArray *)expTokens;

@end
