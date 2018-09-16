//
//  CCKeypad.h
//  CapCalc Pro
//
//  Created by Mark on 7/17/16.
//  Copyright © 2016 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCKeypad;

@protocol CCKeypadDelegate
- (void)sendInput:(CCKeypad *)keypad keyText:(NSString *)keyText;
@end

@interface CCKeypad : UIView

- (id)initMathKeypadForField:(UITextField *)field;

@property (nonatomic, weak) id <CCKeypadDelegate> delegate;
@property (nonatomic, strong) UITextField *textField;

@end
