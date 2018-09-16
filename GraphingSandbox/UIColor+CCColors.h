//
//  UIColor+CCColors.h
//  CapCalc
//
//  Created by Mark on 5/19/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CCColors)

#pragma mark - Reds
+ (UIColor *)CCRed1;
+ (UIColor *)CCRed2;
+ (UIColor *)CCRed3;

#pragma mark - Oranges
+ (UIColor *)CCOrange1;
+ (UIColor *)CCOrange2;
+ (UIColor *)CCOrange3;

#pragma mark - Yellows
+ (UIColor *)CCYellow1;
+ (UIColor *)CCYellow2;
+ (UIColor *)CCYellow3;

#pragma mark - Greens
+ (UIColor *)CCGreen1;
+ (UIColor *)CCGreen2;
+ (UIColor *)CCGreen3;

#pragma mark - Blues
+ (UIColor *)CCBlue1;
+ (UIColor *)CCBlue2;
+ (UIColor *)CCBlue3;

#pragma mark - Indigos
+ (UIColor *)CCIndigo1;
+ (UIColor *)CCIndigo2;
+ (UIColor *)CCIndigo3;

#pragma mark - Purples
+ (UIColor *)CCPurple1;
+ (UIColor *)CCPurple2;
+ (UIColor *)CCPurple3;

#pragma mark - Pinks
+ (UIColor *)CCPink1;
+ (UIColor *)CCPink2;
+ (UIColor *)CCPink3;

#pragma mark - Blue Grays
+ (UIColor *)CCBlueGray1;
+ (UIColor *)CCBlueGray2;
+ (UIColor *)CCBlueGray3;

#pragma mark - Browns
+ (UIColor *)CCBrown1;
+ (UIColor *)CCBrown2;
+ (UIColor *)CCBrown3;

#pragma mark - Grays
+ (UIColor *)CCGray1;
+ (UIColor *)CCGray2;
+ (UIColor *)CCGray3;

#pragma mark - Teals
+ (UIColor *)CCTeal1;
+ (UIColor *)CCTeal2;
+ (UIColor *)CCTeal3;

#pragma mark - Colors Used In App
+ (UIColor *)CCDarkTableViewBackgroundColor;
+ (UIColor *)CCDarkTableViewCellColor;
+ (UIColor *)CCDarkTableViewSeparatorColor;

+ (UIColor *)CCDarkViewColor;
+ (UIColor *)CCLightViewColor;

+ (UIColor *)CCLightTableViewBackgroundColor;

+ (UIColor *)CCRedTintColor;
+ (UIColor *)CCBlueTintColor;


+ (NSArray *)allCCColors;
+ (UIColor *)textColorForBG:(UIColor*)c;
+ (NSString *)hexStringForColor:(UIColor*)c;
+ (NSInteger)indexOfColorInArray:(NSString*)hexColor;

+ (UIColor *)colorWithHex:(NSString *)hexString;

@end
