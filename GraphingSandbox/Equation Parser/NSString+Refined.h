//
//  NSString+Refined.h
//  CapCalc
//
//  Created by Mark on 2/11/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Refined)
- (NSString *)substringFrom:(NSInteger)start to:(NSInteger)end;
- (NSInteger)indexOf:(NSString *)str;
- (NSInteger)indexOf:(NSString*)inStr after:(NSInteger)start;
- (NSInteger)countNumberOf:(NSString*)c;
- (void)replaceAll:(NSString*)str with:(NSString*)s;
- (NSString *)insert:(NSString *)str at:(NSInteger)index;
+ (BOOL)checkIfNumber:(NSString*)s;
- (NSInteger)indexOfCorrespondingClosedBracketAt:(NSInteger)index;
- (NSInteger)indexOfAnOptionIn:(NSArray *)options after:(NSInteger)start;
- (NSInteger)indexOf:(NSString *)str atParenthesisNestDepth:(NSInteger)depth;
@end
