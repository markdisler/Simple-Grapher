//
//  CCFunctions.m
//  CapCalc
//
//  Created by Mark on 6/6/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import "CCFunctions.h"
#import "MDParserHelper.h"
#import "TrigFunctions.h"
#import "FunctionLibrary.h"

@implementation CCFunctions

#pragma mark - Core Math Functions

+ (NSArray *)fixRoots:(NSArray *)expTokens {
    
    for (NSInteger i = 0; i < expTokens.count; i++) {
        NSString *token = [expTokens objectAtIndex:i];
        
        if ([token isEqualToString:@"root"] || [token isEqualToString:@"cbrt"]) {
            NSDictionary *vals = [MDParserHelper replacementValsForFuncWithParamList:token inExpression:expTokens];
            NSArray *begin = [vals valueForKey:@"before"];
            NSArray *end = [vals valueForKey:@"after"];
            NSArray *data = [vals valueForKey:@"val"];
            
            NSString *replacement;
            
            if ([token isEqualToString:@"root"]) {
                if (data.count == 1) {  // Regular sqrt with index of 2 (only one parameter)
                    NSString *numInRad = [data objectAtIndex:0];
                    replacement = [NSString stringWithFormat:@"%LG", sqrtl([MDParserHelper parseStringToLongDouble:numInRad])];
                } else if (data.count == 2) {
                    NSString *numInRad = [data objectAtIndex:0];
                    NSString *index = [data objectAtIndex:1];
                    replacement = [NSString stringWithFormat:@"%LG", powl([MDParserHelper parseStringToLongDouble:numInRad], 1.0/[MDParserHelper parseStringToLongDouble:index])];
                } else {
                    [NSException raise:@"Invalid Parameters" format:@"Too many parameters."];
                }
            } else {
                NSString *numInRad = [data objectAtIndex:0];
                replacement = [NSString stringWithFormat:@"%LG", cbrtl([MDParserHelper parseStringToLongDouble:numInRad])];
            }
            NSMutableArray *rebuildingArray = [NSMutableArray arrayWithArray:begin];
            [rebuildingArray addObject:replacement];
            [rebuildingArray addObjectsFromArray:end];
            
            expTokens = rebuildingArray.copy;
        }
    }
    return expTokens;
}

+ (NSArray *)fixTrigFunctions:(NSArray *)expTokens {
    
    for (NSInteger i = 0; i < expTokens.count; i++) {
        NSString *token = [expTokens objectAtIndex:i];
        
        if ([token isEqualToString:@"sin"] || [token isEqualToString:@"cos"] || [token isEqualToString:@"tan"] || [token isEqualToString:@"arcsin"] || [token isEqualToString:@"arccos"] || [token isEqualToString:@"arctan"]) {
            
            NSDictionary *vals = [MDParserHelper replacementValsForFunc:token in:expTokens];
            NSArray *begin = [vals valueForKey:@"before"];
            NSArray *end = [vals valueForKey:@"after"];
            NSString *value = [vals valueForKey:@"val"];
            
            NSString *replacement;
            
            if ([token isEqualToString:@"sin"])
                replacement = [NSString stringWithFormat:@"%LG", sinFunction([MDParserHelper parseStringToLongDouble:value])];
            else if ([token isEqualToString:@"cos"])
                replacement = [NSString stringWithFormat:@"%LG", cosFunction([MDParserHelper parseStringToLongDouble:value])];
            else if ([token isEqualToString:@"tan"])
                replacement = [NSString stringWithFormat:@"%LG", tanFunction([MDParserHelper parseStringToLongDouble:value])];
            else if ([token isEqualToString:@"arcsin"])
                replacement = [NSString stringWithFormat:@"%LG", arcsinFunction([MDParserHelper parseStringToLongDouble:value])];
            else if ([token isEqualToString:@"arccos"])
                replacement = [NSString stringWithFormat:@"%LG", arccosFunction([MDParserHelper parseStringToLongDouble:value])];
            else if ([token isEqualToString:@"arctan"])
                replacement = [NSString stringWithFormat:@"%LG", arctanFunction([MDParserHelper parseStringToLongDouble:value])];
            
            NSMutableArray *rebuildingArray = [NSMutableArray arrayWithArray:begin];
            [rebuildingArray addObject:replacement];
            [rebuildingArray addObjectsFromArray:end];
            expTokens = rebuildingArray.copy;
            
        }
    }
    return expTokens;
}

+ (NSArray *)fixLogarithms:(NSArray *)expTokens {
    
    for (NSInteger i = 0; i < expTokens.count; i++) {
        NSString *token = [expTokens objectAtIndex:i];
        
        if ([token isEqualToString:@"log"] || [token isEqualToString:@"ln"]) {
            NSDictionary *vals = [MDParserHelper replacementValsForFunc:token in:expTokens];
            NSArray *begin = [vals valueForKey:@"before"];
            NSArray *end = [vals valueForKey:@"after"];
            NSString *log = [vals valueForKey:@"val"];
            
            NSString *replacement;
            
            if ([token isEqualToString:@"log"])
                replacement = [NSString stringWithFormat:@"%LG", log10l([MDParserHelper parseStringToLongDouble:log])];
            else
                replacement = [NSString stringWithFormat:@"%LG", logl([MDParserHelper parseStringToLongDouble:log])];
            
            NSMutableArray *rebuildingArray = [NSMutableArray arrayWithArray:begin];
            [rebuildingArray addObject:replacement];
            [rebuildingArray addObjectsFromArray:end];
            expTokens = rebuildingArray.copy;
            
        }
    }
    return expTokens;
}

#pragma mark - Extra Functions

+ (NSArray *)fixExtraFunctions:(NSArray *)expTokens {
    expTokens = [CCFunctions evaluateStatFunctions:expTokens];
    expTokens = [CCFunctions evaluateOtherFunctions:expTokens];
    expTokens = [CCFunctions evaluateBinFunctions:expTokens];
    return expTokens;
}

+ (NSArray *)evaluateBinFunctions:(NSArray *)expTokens {
    
    for (NSInteger i = 0; i < expTokens.count; i++) {
        NSString *token = [expTokens objectAtIndex:i];
        
        if ([token isEqualToString:@"dec"] || [token isEqualToString:@"bin"]) {
            NSDictionary *vals = [MDParserHelper replacementValsForFunc:token in:expTokens];
            NSArray *begin = [vals valueForKey:@"before"];
            NSArray *end = [vals valueForKey:@"after"];
            NSString *arg = [vals valueForKey:@"val"];
            NSString *replacement = [token isEqualToString:@"dec"] ? [FunctionLibrary binToDec:arg] : [FunctionLibrary decToBin:[arg integerValue]];
            
            NSMutableArray *rebuildingArray = [NSMutableArray arrayWithArray:begin];
            [rebuildingArray addObject:replacement];
            [rebuildingArray addObjectsFromArray:end];
            expTokens = rebuildingArray.copy;
            
        }
    }
    return expTokens;
}


+ (NSArray *)evaluateStatFunctions:(NSArray *)expTokens {
    
    for (NSInteger i = 0; i < expTokens.count; i++) {
        NSString *token = [expTokens objectAtIndex:i];
        
        if ([token isEqualToString:@"min"] || [token isEqualToString:@"max"] || [token isEqualToString:@"med"] || [token isEqualToString:@"avg"]) {
            
            NSDictionary *vals = [MDParserHelper replacementValsForFuncWithParamList:token inExpression:expTokens];
            NSArray *begin = [vals valueForKey:@"before"];
            NSArray *end = [vals valueForKey:@"after"];
            NSArray *data = [vals valueForKey:@"val"];
            
            float value;
            
            if ([token isEqualToString:@"min"])
                value = [FunctionLibrary minimum:data];
            else if ([token isEqualToString:@"max"])
                value = [FunctionLibrary maximum:data];
            else if ([token isEqualToString:@"med"])
                value = [FunctionLibrary median:data];
            else
                value = [FunctionLibrary average:data];
            
            NSMutableArray *rebuildingArray = [NSMutableArray arrayWithArray:begin];
            [rebuildingArray addObject:[NSString stringWithFormat:@"%G", value]];
            [rebuildingArray addObjectsFromArray:end];
            expTokens = rebuildingArray.copy;
            
        }
    }
    return expTokens;
}

+ (NSArray *)evaluateOtherFunctions:(NSArray *)expTokens {
    
    for (NSInteger i = 0; i < expTokens.count; i++) {
        NSString *token = [expTokens objectAtIndex:i];
        
        if ([token isEqualToString:@"ceil"] || [token isEqualToString:@"floor"] || [token isEqualToString:@"int"]) {
            
            NSDictionary *vals = [MDParserHelper replacementValsForFunc:token in:expTokens];
            NSArray *begin = [vals valueForKey:@"before"];
            NSArray *end = [vals valueForKey:@"after"];
            NSString *parameter = [vals valueForKey:@"val"];
            
            float value;
            
            if ([token isEqualToString:@"ceil"])
                value = [FunctionLibrary ceiling:[parameter floatValue]];
            else if ([token isEqualToString:@"floor"])
                value = [FunctionLibrary floorRound:[parameter floatValue]];
            else
                value = [FunctionLibrary greatestInteger:[parameter floatValue]];
            
            NSMutableArray *rebuildingArray = [NSMutableArray arrayWithArray:begin];
            [rebuildingArray addObject:[NSString stringWithFormat:@"%G", value]];
            [rebuildingArray addObjectsFromArray:end];
            expTokens = rebuildingArray.copy;
            
        }
    }
    return expTokens;
}



@end
