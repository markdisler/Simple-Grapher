//
//  TrigFunctions.m
//  CapCalc
//
//  Created by Mark on 2/6/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import "TrigFunctions.h"

@implementation TrigFunctions

long double degreesToRadians (long double degrees) {
    return degrees * (M_PI/180.0);
}

long double radiansToDegrees (long double radians) {
    return radians * (180.0 / M_PI);
}


long double sinFunction (long double a) {
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"angUnit"] isEqualToString:@"Deg"])
        return sind(a);
    else
        return sinl(a);
}

long double cosFunction (long double a) {
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"angUnit"] isEqualToString:@"Deg"])
        return cosd(a);
    else
        return cosl(a);
}

long double tanFunction (long double a) {
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"angUnit"] isEqualToString:@"Deg"])
        return tand(a);
    else
        return sinl(a) / cosl(a);
}

long double arcsinFunction (long double a) {
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"angUnit"] isEqualToString:@"Deg"])
        return arcsinD(a);
    else
        return asinl(a);
}

long double arccosFunction (long double a) {
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"angUnit"] isEqualToString:@"Deg"])
        return arccosD(a);
    else
        return acosl(a);
}

long double arctanFunction (long double a) {
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"angUnit"] isEqualToString:@"Deg"])
        return arctanD(a);
    else
        return atanl(a);
}


#pragma mark - Helpers

long double sind (long double a) {
    return sinl(degreesToRadians(a));
}

long double cosd (long double a) {
    return cosl(degreesToRadians(a));
}

long double tand (long double a) {

    if (a > 0)
        while (a > 360)
            a -= 360;
    
    if (a < 0)
        while (a < -360)
            a += 360;
        
    
    long double bottom;
    if (a == 90 || a == 270 || a == -270 || a == -90) {
        [NSException raise:@"Function Undefined" format:@"The function is undefined at this value for theta."];
        bottom = 0;
    } else
        bottom = cosl(degreesToRadians(a));
    long double t = sinl(degreesToRadians(a)) / bottom;
    return t;
}

long double arcsinD (long double a) {
    long double angle = asinl(a);
    angle = radiansToDegrees(angle);
    return angle;
}

long double arccosD (long double a) {
    long double angle = acosl(a);
    angle = radiansToDegrees(angle);
    return angle;
}

long double arctanD (long double a) {
    long double angle = atanl(a);
    angle = radiansToDegrees(angle);
    return angle;
}

@end
