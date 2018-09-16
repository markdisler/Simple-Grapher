//
//  NSString+Refined.m
//  CapCalc
//
//  Created by Mark on 2/11/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import "NSString+Refined.h"

@implementation NSString (Refined)

- (NSString*)substringFrom:(NSInteger)start to:(NSInteger)end {
    return [self substringWithRange:NSMakeRange(start, end-start)];
}

- (NSInteger)indexOf:(NSString *)str {
    return [self indexOf:str after:0];
}

- (NSInteger)indexOf:(NSString *)inStr after:(NSInteger)start {
    NSInteger len = inStr.length;
    
    for (NSInteger i = start; i <= self.length - len; i++) {
        NSString *current = [self substringWithRange:NSMakeRange(i, len)];
        if ([current isEqualToString:inStr]) {
            return i;
        }
    }
    return -1;
}

- (NSInteger)indexOfAnOptionIn:(NSArray *)options after:(NSInteger)start {
    NSInteger index = -1;
    
    for (NSInteger i = 0; i < options.count; i++) {
        NSInteger idx = [self indexOf:options[i] after:start];
        if (index == -1 || (idx != -1 && idx < index)) {
            index = idx;
        }
    }
    return index;
}

- (NSInteger)indexOf:(NSString *)str atParenthesisNestDepth:(NSInteger)depth {
    NSInteger nestDepth = 0;
    
    for (NSInteger i = 0; i <= self.length - str.length; i++) {
        NSString *current = [self substringWithRange:NSMakeRange(i, str.length)];
        
        if (nestDepth == depth && [current isEqualToString:str]) {
            return i;
        }
        
        if ([current isEqualToString:@"("]) {
            nestDepth++;
        } else if ([current isEqualToString:@")"]) {
            nestDepth--;
        }
    }
    return -1;
}

- (NSInteger)countNumberOf:(NSString*)c {
    NSInteger count = 0;
    for (NSInteger i = 0; i < [self length]; i++) {
        NSString *current = [self substringWithRange:NSMakeRange(i, 1)];
        if ([current isEqualToString:c]) {
            count++;
        }
    }
    return count;
}

- (void)replaceAll:(NSString*)str with:(NSString*)s {
    [self stringByReplacingOccurrencesOfString:str withString:s];
}

+ (BOOL)checkIfNumber:(NSString*)s {
    for (NSInteger i = 0; i < 10; i++) {
        NSString *num = [NSString stringWithFormat:@"%ld", (long)i];
        if ([s isEqualToString:num]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)insert:(NSString *)str at:(NSInteger)index {
    NSMutableString *mutblFull = [self mutableCopy];
    [mutblFull insertString:str atIndex:index];
    return [mutblFull copy];
}

- (NSInteger)indexOfCorrespondingClosedBracketAt:(NSInteger)index  {
    NSInteger open = 0, closed = 0;
    for (NSInteger i = index; i < self.length; i++) {
        NSString *current = [self substringWithRange:NSMakeRange(i, 1)];
        BOOL isOpenParen = [current isEqualToString:@"("];
        BOOL isClosedParen = [current isEqualToString:@")"];
        if (isOpenParen)
            open++;
        else if (isClosedParen) {
            closed++;
            if (open == closed)
                return i;
        }
    }
    return -1;
}
@end
