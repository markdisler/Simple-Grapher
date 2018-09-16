//
//  CCExpressionParser.h
//  CapCalc Pro
//
//  Created by Mark on 7/15/16.
//  Copyright © 2016 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCExpressionParser : NSObject

+ (NSArray *)parseExpression:(NSArray *)tokens;

@end
