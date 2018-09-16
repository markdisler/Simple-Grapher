//
//  CCInput.m
//  CapCalc
//
//  Created by Mark on 5/6/15.
//  Copyright (c) 2015 mark. All rights reserved.
//

#import "CCInputField.h"
#import "UIColor+CCColors.h"

@interface CCInputField ()
@property (nonatomic, strong) UILabel *caption;
@end

@implementation CCInputField

- (id)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
    
        UILabel *lbl = [UILabel new];
        [lbl setText:title];
        [lbl setTextColor:[UIColor CCGray1]];
        [lbl setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:28]];
        [lbl sizeToFit];
        [lbl setFrame:CGRectMake(12, 0, lbl.frame.size.width, frame.size.height)];
        [self addSubview:lbl];
        self.caption = lbl;
    
        [self.layer setBorderColor:[UIColor blackColor].CGColor];
        [self.layer setBorderWidth:2.0];
    
        [self setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:48]];
        [self setAdjustsFontSizeToFitWidth:YES];
        [self setUserInteractionEnabled:YES];
        [self setBackgroundColor:[UIColor darkGrayColor]];
        
        self.inputAssistantItem.leadingBarButtonGroups = @[];
        self.inputAssistantItem.trailingBarButtonGroups = @[];
        
        [self setTextColor:[UIColor whiteColor]];
        [self setTintColor:[UIColor whiteColor]];
        
        [self setTextAlignment:NSTextAlignmentLeft];
        [self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self setAutocorrectionType:UITextAutocorrectionTypeNo];
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGFloat wid = self.caption.frame.size.width + self.caption.frame.origin.x;
    return CGRectMake(bounds.origin.x + wid, bounds.origin.y,
                     bounds.size.width - wid, bounds.size.height);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
