//
//  MCButton.m
//  MathCruncher
//
//  Created by Mark on 9/24/14.
//  Copyright (c) 2014 mark. All rights reserved.
//

#import "MCButton.h"

@implementation MCButton

- (id)initAsKeyWithFrame:(CGRect)frame img:(UIImage *)img {
    self = [super initWithFrame:frame];
    if (self) {
        self.insideView = [[UIImageView alloc] initWithImage:img];
        [self addSubview:self.insideView];
        
        self.insideView.translatesAutoresizingMaskIntoConstraints = NO;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.insideView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:21];
        
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.insideView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:16];
        
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.insideView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        
        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.insideView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        
        [self addConstraints:@[width, height, centerX, centerY]];

    }
    return self;
}

- (void)setDesign {
    //sets the design of the button (bg color, text color, roundness, text justification)
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:150/255.0 blue:136/255.0 alpha:1.0];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0];
    self.layer.cornerRadius = 10;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setTitle:(NSString *)text {
    //set the title of the button with the title (text) passed in (from blueprints, retrieved by another class)
    [self setTitle:text forState:UIControlStateNormal];
}

@end
