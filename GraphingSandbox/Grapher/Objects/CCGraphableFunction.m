//
//  CCGraphableFunction.m
//  CapCalc Pro
//
//  Created by Mark on 6/28/16.
//  Copyright © 2016 mark. All rights reserved.
//

#import "CCGraphableFunction.h"

@implementation CCGraphableFunction

- (id)initWithFunction:(NSString *)function {
    self = [super init];
    if (self) {
        self.functionInputTokens = [NSMutableArray array];
        self.functionString = function;
        self.scaledCoordinates = [NSMutableArray array];
        self.rawCoordinates = [NSMutableArray array];
        self.functionHexColor = @"#000000";
        self.maxDomainRestrictionExists = NO;
        self.minDomainRestrictionExists = NO;
        
        [self.path setLineWidth:2.0];
    }
    return self;
}

#pragma mark - Reset Methods

- (void)clearInputTokens {
    [self.functionInputTokens removeAllObjects];
}

- (void)clearScaledCoordinates {
    [self.scaledCoordinates removeAllObjects];
}

- (void)clearPath {
    self.path = nil;
}

- (void)clearRawCoordinates {
    [self.rawCoordinates removeAllObjects];
}

- (void)resetGraphableFunction {
    [self clearInputTokens];
    [self clearScaledCoordinates];
    [self clearRawCoordinates];
    self.functionHexColor = @"#000000";
    self.maxDomainRestrictionExists = NO;
    self.minDomainRestrictionExists = NO;
}

#pragma mark - Getter Methods

- (UIBezierPath *)path {
    if (!_path) {
        _path = [UIBezierPath bezierPath];
        [_path setLineWidth:2.0];
    }
    return _path;
}

- (NSMutableArray *)allCoordinates {
    if (!_scaledCoordinates) {
        _scaledCoordinates = [NSMutableArray array];
    }
    return _scaledCoordinates;
}

- (NSMutableArray *)rawCoordinates {
    if (!_rawCoordinates) {
        _rawCoordinates = [NSMutableArray array];
    }
    return _rawCoordinates;
}

@end
