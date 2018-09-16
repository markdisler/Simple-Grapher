//
//  UIColor+CCColors.m
//  CapCalc
//
//  Created by Mark on 5/19/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import "UIColor+CCColors.h"

@implementation UIColor (CCColors)

#pragma mark - Reds
+ (UIColor *)CCRed1 { return [UIColor colorWithHex:@"#EF9A9A"]; }
+ (UIColor *)CCRed2 { return [UIColor colorWithHex:@"#F44336"]; }
+ (UIColor *)CCRed3 { return [UIColor colorWithHex:@"#C62828"]; }

#pragma mark - Oranges
+ (UIColor *)CCOrange1 { return [UIColor colorWithHex:@"#FFCC80"]; }
+ (UIColor *)CCOrange2 { return [UIColor colorWithHex:@"#FF9800"]; }
+ (UIColor *)CCOrange3 { return [UIColor colorWithHex:@"#EF6C00"]; }

#pragma mark - Yellows
+ (UIColor *)CCYellow1 { return [UIColor colorWithHex:@"#FFF59D"]; }
+ (UIColor *)CCYellow2 { return [UIColor colorWithHex:@"#FFEB3B"]; }
+ (UIColor *)CCYellow3 { return [UIColor colorWithHex:@"#FBC02D"]; }

#pragma mark - Greens
+ (UIColor *)CCGreen1 { return [UIColor colorWithHex:@"#A5D6A7"]; }
+ (UIColor *)CCGreen2 { return [UIColor colorWithHex:@"#4CAF50"]; }
+ (UIColor *)CCGreen3 { return [UIColor colorWithHex:@"#2E7D32"]; }

#pragma mark - Blues
+ (UIColor *)CCBlue1 { return [UIColor colorWithHex:@"#90CAF9"]; }
+ (UIColor *)CCBlue2 { return [UIColor colorWithHex:@"#2196F3"]; }
+ (UIColor *)CCBlue3 { return [UIColor colorWithHex:@"#1565C0"]; }

#pragma mark - Indigos
+ (UIColor *)CCIndigo1 { return [UIColor colorWithHex:@"#9FA8DA"]; }
+ (UIColor *)CCIndigo2 { return [UIColor colorWithHex:@"#3F51B5"]; }
+ (UIColor *)CCIndigo3 { return [UIColor colorWithHex:@"#283593"]; }

#pragma mark - Purples
+ (UIColor *)CCPurple1 { return [UIColor colorWithHex:@"#B39DDB"]; }
+ (UIColor *)CCPurple2 { return [UIColor colorWithHex:@"#673AB7"]; }
+ (UIColor *)CCPurple3 { return [UIColor colorWithHex:@"#4527A0"]; }

#pragma mark - Pinks
+ (UIColor *)CCPink1 { return [UIColor colorWithHex:@"#F48FB1"]; }
+ (UIColor *)CCPink2 { return [UIColor colorWithHex:@"#E91E63"]; }
+ (UIColor *)CCPink3 { return [UIColor colorWithHex:@"#AD1457"]; }

#pragma mark - Blue Grays
+ (UIColor *)CCBlueGray1 { return [UIColor colorWithHex:@"#B0BEC5"]; }
+ (UIColor *)CCBlueGray2 { return [UIColor colorWithHex:@"#607D8B"]; }
+ (UIColor *)CCBlueGray3 { return [UIColor colorWithHex:@"#37474F"]; }

#pragma mark - Browns
+ (UIColor *)CCBrown1 { return [UIColor colorWithHex:@"#BCAAA4"]; }
+ (UIColor *)CCBrown2 { return [UIColor colorWithHex:@"#795548"]; }
+ (UIColor *)CCBrown3 { return [UIColor colorWithHex:@"#4E342E"]; }

#pragma mark - Grays
+ (UIColor *)CCGray1 { return [UIColor colorWithHex:@"#EEEEEE"]; }
+ (UIColor *)CCGray2 { return [UIColor colorWithHex:@"#9E9E9E"]; }
+ (UIColor *)CCGray3 { return [UIColor colorWithHex:@"#424242"]; }

#pragma mark - Teals
+ (UIColor *)CCTeal1 { return [UIColor colorWithHex:@"#80CBC4"]; }
+ (UIColor *)CCTeal2 { return [UIColor colorWithHex:@"#009688"]; }
+ (UIColor *)CCTeal3 { return [UIColor colorWithHex:@"#00695C"]; }

#pragma mark - Colors Used In App
+ (UIColor *)CCDarkTableViewBackgroundColor     { return [UIColor colorWithHex:@"#181818"]; }
+ (UIColor *)CCDarkTableViewCellColor           { return [UIColor colorWithHex:@"#474747"]; }
+ (UIColor *)CCDarkTableViewSeparatorColor      { return [UIColor colorWithHex:@"#9E9E9E"]; }

+ (UIColor *)CCDarkViewColor                    { return [UIColor colorWithHex:@"#474747"]; }
+ (UIColor *)CCLightViewColor                   { return [UIColor colorWithHex:@"#EFEFF4"]; }

+ (UIColor *)CCLightTableViewBackgroundColor    { return [UIColor colorWithHex:@"#EFEFF4"]; }

+ (UIColor *)CCRedTintColor                     { return [UIColor colorWithHex:@"#EF5350"]; } //#EF9A9A
+ (UIColor *)CCBlueTintColor                    { return [UIColor colorWithHex:@"#29B6F6"]; } // 42A5F5 64B5F6

#pragma mark - Methods

+ (NSArray *)allCCColors {
    NSMutableArray *colors = [NSMutableArray array];
    
    [colors addObject:[UIColor CCGray1]];
    [colors addObject:[UIColor CCGray2]];
    [colors addObject:[UIColor colorWithHex:@"#000000"]];
    [colors addObject:[UIColor CCGray3]];
    
    [colors addObject:[UIColor CCRed1]];
    [colors addObject:[UIColor CCRed2]];
    [colors addObject:[UIColor CCRed3]];
    
    [colors addObject:[UIColor CCOrange1]];
    [colors addObject:[UIColor CCOrange2]];
    [colors addObject:[UIColor CCOrange3]];
    
    [colors addObject:[UIColor CCYellow1]];
    [colors addObject:[UIColor CCYellow2]];
    [colors addObject:[UIColor CCYellow3]];
    
    [colors addObject:[UIColor CCGreen1]];
    [colors addObject:[UIColor CCGreen2]];
    [colors addObject:[UIColor CCGreen3]];
    
    [colors addObject:[UIColor CCBlue1]];
    [colors addObject:[UIColor CCBlue2]];
    [colors addObject:[UIColor CCBlue3]];
    
    [colors addObject:[UIColor CCIndigo1]];
    [colors addObject:[UIColor CCIndigo2]];
    [colors addObject:[UIColor CCIndigo3]];
    
    [colors addObject:[UIColor CCPurple1]];
    [colors addObject:[UIColor CCPurple2]];
    [colors addObject:[UIColor CCPurple3]];
    
    [colors addObject:[UIColor CCPink1]];
    [colors addObject:[UIColor CCPink2]];
    [colors addObject:[UIColor CCPink3]];
    
    [colors addObject:[UIColor CCBlueGray1]];
    [colors addObject:[UIColor CCBlueGray2]];
    [colors addObject:[UIColor CCBlueGray3]];
    
    [colors addObject:[UIColor CCBrown1]];
    [colors addObject:[UIColor CCBrown2]];
    [colors addObject:[UIColor CCBrown3]];
    
    [colors addObject:[UIColor CCTeal1]];
    [colors addObject:[UIColor CCTeal2]];
    [colors addObject:[UIColor CCTeal3]];
    
    return [colors copy];
}

+ (UIColor *)textColorForBG:(UIColor *)c {
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [c getRed:&red green:&green blue:&blue alpha:&alpha];
    
    red *= 255;
    green *= 255;
    blue *= 255;
    
    float threshold = 200;
    float brightness = sqrtf((0.241 * red * red) + (0.691 * green  * green) + (0.068 * blue * blue));
    
    if (brightness > threshold) {
        return [UIColor blackColor];
    } else {
        return [UIColor whiteColor];
    }
}

+ (NSString *)textHexForBackgroundHex:(NSString *)backgroundHex {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:backgroundHex];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    CGFloat red = ((rgbValue & 0xFF0000) >> 16);
    CGFloat green = ((rgbValue & 0xFF00) >> 8);
    CGFloat blue = (rgbValue & 0xFF);
    
    float threshold = 200;
    float brightness = sqrtf((0.241 * red * red) + (0.691 * green  * green) + (0.068 * blue * blue));
    return (brightness > threshold) ? @"#000000" : @"FFFFFF";
}

+ (NSInteger)indexOfColorInArray:(NSString*)hexColor {
    for (NSInteger i = 0; i < [[UIColor allCCColors] count]; i++) {
        UIColor *color = [[UIColor allCCColors] objectAtIndex:i];
        NSString *currentHex = [UIColor hexStringForColor:color];
        if ([hexColor isEqualToString:currentHex])
            return i;
    }
    return 0;
}

+ (NSString *)hexStringForColor:(UIColor*)c {
    const CGFloat *components = CGColorGetComponents(c.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString = [NSString stringWithFormat:@"#%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
    return hexString;
}

+ (UIColor *)colorWithHex:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    CGFloat r = ((rgbValue & 0xFF0000) >> 16);
    CGFloat g = ((rgbValue & 0xFF00) >> 8);
    CGFloat b = (rgbValue & 0xFF);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

UIColor* colorRGB (int r, int g, int b){
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0f];
}

@end
