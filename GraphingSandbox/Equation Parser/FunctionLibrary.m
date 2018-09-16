//
//  FunctionLibrary.m
//  MDParserIOD
//
//  Created by Mark on 8/25/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import "FunctionLibrary.h"
#import "MDParser.h"
#import "NSString+Refined.h"

@implementation FunctionLibrary

#pragma mark - General

+ (float)factorial:(float)n {
    NSInteger product = n;
    if (product == 0)
        return 1;
    
    for (NSInteger i = n-1; i > 0; i--)
        product *= i;
    
    return product;
}

#pragma mark - Binary

+ (NSString *)binToDec:(NSString *)binary {
    long double decimal = 0.0;
    NSInteger power = binary.length - 1;
    for (NSInteger i = 0; i < binary.length; i++) {
        NSInteger bit = [[binary substringFrom:i to:i+1] integerValue];
        if (bit == 1) {
            decimal += powl(2, power);
        }
        power--;
    }
    return [NSString stringWithFormat:@"%LG", decimal];
}

+ (NSString *)decToBin:(long)decimal {
    NSMutableString *binary = [NSMutableString string];
    
    NSInteger power = 0;
    while (powl(2, power) < decimal) {
        power++;
    }
    
    while (power >= 0) {
        long val = powl(2, power);
        if (val <= decimal) {
            decimal -= val;
            [binary appendString:@"1"];
        } else if (binary.length > 0) {
            [binary appendString:@"0"];
        }
        power--;
    }
    return [binary copy];
}


#pragma mark - Rounding Functions

+ (float)ceiling:(float)num {
    return ceilf(num);
}

+ (float)floorRound:(float)num {
    return floorf(num);
}

+ (float)greatestInteger:(float)num {
    num = floorf(num);
    return num;
}

#pragma mark - Statistics Functions

+ (float)minimum:(NSArray *)data {
    if (data.count != 0) {
        float smallest = [[data objectAtIndex:0] floatValue];
        for (NSInteger i = 1; i < data.count; i++) {
            NSString *value = [data objectAtIndex:i];
            value = [[MDParser parseEquationPart:@[value]] objectAtIndex:0];
            float num = [value floatValue];
            if (num < smallest)
                smallest = num;
        }
        return smallest;
    }
    //THROW EXCEPTION
    return 0.0f;
}

+ (float)maximum:(NSArray *)data {
    if (data.count != 0) {
        float largest = [[data objectAtIndex:0] floatValue];
        for (NSInteger i = 1; i < data.count; i++) {
            NSString *value = [data objectAtIndex:i];
            value = [[MDParser parseEquationPart:@[value]] objectAtIndex:0];
            float num = [value floatValue];
            if (num > largest)
                largest = num;
        }
        return largest;
    }
    //THROW EXCEPTION
    return 0.0f;
}

+ (float)median:(NSArray *)data {
    if (data.count != 0) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0; i < data.count; i++) {
            NSString *num = [data objectAtIndex:i];
            num = [[MDParser parseEquationPart:@[num]] objectAtIndex:0];
            [array addObject:num];
        }
        data = [array copy];
        data = [data sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"doubleValue" ascending:YES]]];
        float median;
        if (data.count % 2 == 0) {
            NSInteger firstMiddleIndex = data.count / 2;
            NSInteger secondMiddleIndex = firstMiddleIndex + 1;
            
            NSString *value1 = [data objectAtIndex:firstMiddleIndex];
            NSString *value2 = [data objectAtIndex:secondMiddleIndex];
            
            float firstNum = [value1 floatValue];
            float secondNum = [value2 floatValue];
            median = (firstNum + secondNum) / 2;
        } else {
            NSInteger middleIndex = (data.count - 1) / 2;
            NSString *value = [data objectAtIndex:middleIndex];
            value = [[MDParser parseEquationPart:@[value]] objectAtIndex:0];
            median = [value floatValue];
        }
        return median;
    }
    //THROW EXCEPTION
    return 0.0f;
}

+ (float)average:(NSArray *)data {
    if (data.count != 0) {
        float sum = 0.0f;
        for (NSInteger i = 0; i < data.count; i++) {
            NSString *numAsStr = [data objectAtIndex:i];
            numAsStr = [[MDParser parseEquationPart:@[numAsStr]] objectAtIndex:0];
            float num = [numAsStr floatValue];
            sum += num;
        }
        return sum / data.count;
    }
    //THROW EXCEPTION
    return 0.0f;
}

@end
