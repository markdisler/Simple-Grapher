//
//  MDReplacement.m
//  MDParser
//
//  Created by Mark on 8/2/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import "MDReplacement.h"
#import "MDParserHelper.h"
#import "NSString+Refined.h"

@implementation MDReplacement

+ (NSString *)replaceConstants:(NSString *)expression {
    NSString *exp = [expression stringByReplacingOccurrencesOfString:@"π" withString:@"(3.14159265358979)"];  //3.14159265358979323846264338327950288
    exp = [exp stringByReplacingOccurrencesOfString:@"E+" withString:@"E"];

    NSMutableString *tempString = [NSMutableString string];
    for (NSInteger i = 0; i < exp.length; i++) {
        NSString *character = [exp substringFrom:i to:i+1];
        NSString *previous = i == 0 ? @"" : [exp substringFrom:i-1 to:i];
        char previousAsChar = previous.length > 0 ? [previous UTF8String][0] : ' ';

        if ([character isEqualToString:@"e"]) {
            if ([MDParserHelper checkIfFuncCharacter:previousAsChar]) {
                [tempString appendString:character];
            } else {
                [tempString appendString:@"(2.718281828459)"];
            }
        } else {
            [tempString appendString:character];
        }
        
    }
    return [tempString copy];
}

+ (NSString *)replaceExponents:(NSString *)expression {
    NSString *expression1 = [expression stringByReplacingOccurrencesOfString:@"²" withString:@"^2"];
    NSString *expression2 = [expression1 stringByReplacingOccurrencesOfString:@"³" withString:@"^3"];
    NSString *expression3 = [expression2 stringByReplacingOccurrencesOfString:@"**" withString:@"^"];
    return expression3;
}

+ (NSString *)initialExpressionReplacements:(NSString *)expression {
    expression = [expression stringByReplacingOccurrencesOfString:@"³√" withString:@"cbrt"];
    expression = [expression stringByReplacingOccurrencesOfString:@"√" withString:@"root"];
    expression = [MDReplacement replaceExponents:expression];
    expression = [MDReplacement replaceConstants:expression];
    expression = [expression stringByReplacingOccurrencesOfString:@"sin⁻¹" withString:@"arcsin"];
    expression = [expression stringByReplacingOccurrencesOfString:@"cos⁻¹" withString:@"arccos"];
    expression = [expression stringByReplacingOccurrencesOfString:@"tan⁻¹" withString:@"arctan"];

    return expression;
}

@end
