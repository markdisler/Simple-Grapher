//
//  MCButton.h
//  MathCruncher
//
//  Created by Mark on 9/24/14.
//  Copyright (c) 2014 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCButton : UIButton

- (id)initAsKeyWithFrame:(CGRect)frame img:(UIImage *)img;
- (void)setTitle:(NSString *)text;
- (void)setDesign;

@property (nonatomic, strong) UIImageView *insideView;

@end
