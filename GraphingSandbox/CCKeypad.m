//
//  CCKeypad.m
//  CapCalc Pro
//
//  Created by Mark on 7/17/16.
//  Copyright © 2016 mark. All rights reserved.
//

#import "CCKeypad.h"
#import "MCButton.h"

@interface CCKeypad ()
@property (nonatomic, assign, getter=isSimple) BOOL simple;
@property (nonatomic, assign) BOOL constraintsHaveBeenCreated;
@property (nonatomic, strong) NSArray *keyboardButtons;
@end

@implementation CCKeypad

- (id)initMathKeypadForField:(UITextField *)field {
    self = [super init];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.backgroundColor = [UIColor lightGrayColor];
        self.constraintsHaveBeenCreated = NO;
        [self buildMathKeypad];
        field.inputView = self;
        self.textField = field;
    }
    return self;
}

- (void)buildMathKeypad {
    self.simple = NO;
    NSArray *gridText = @[  @[@"x", @"(", @")", @"^"],
                            @[@"7", @"8", @"9", @"/"],
                            @[@"4", @"5", @"6", @"*"],
                            @[@"1", @"2", @"3", @"-"],
                            @[@"0", @".", @"bkspc",@"+"]
                            ];
    [self buildButtonGrid:gridText];
}

- (void)buildButtonGrid:(NSArray *)gridText {
    
    
    NSMutableArray *mutableButtons = [NSMutableArray array];
    for (NSInteger i = 0; i < gridText.count; i++) {
        NSMutableArray *buttonRow = [NSMutableArray array];
        NSArray *btnRow = [gridText objectAtIndex:i];
        for (NSInteger j = 0; j < btnRow.count; j++) {
            MCButton *btn;
            NSString *title = [[gridText objectAtIndex:i] objectAtIndex:j];
            
            if ([title isEqualToString:@"bkspc"]) {
                UIImage *btnImage = [UIImage imageNamed:@"backspace-black.png"];
                btn = [[MCButton alloc] initAsKeyWithFrame:CGRectZero img:btnImage];
                btn.tag = -1;
            } else {
                btn = [[MCButton alloc] initWithFrame:CGRectZero];
                [btn setTitle:title forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
                [btn setEnabled:![title isEqualToString:@""]];
                btn.tag = 1;
            }
            [btn setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0f]];  //217
            [btn setTranslatesAutoresizingMaskIntoConstraints:NO];
            [btn addTarget:self action:@selector(keyDown:) forControlEvents:UIControlEventTouchDown];
            [btn addTarget:self action:@selector(keyUp:) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(keyUpWithoutAction:) forControlEvents:UIControlEventTouchUpOutside];
            [buttonRow addObject:btn];
            [self addSubview:btn];
        }
        [mutableButtons addObject:buttonRow];
    }
    self.keyboardButtons = [mutableButtons copy];
}

- (void)updateConstraints {
    [super updateConstraints];
    if (!self.constraintsHaveBeenCreated) {
        self.constraintsHaveBeenCreated = YES;
        
        float widthMult = 1.0/((NSArray *)[self.keyboardButtons objectAtIndex:0]).count;
 
        for (NSInteger j = 0; j < self.keyboardButtons.count; j++) {
            NSArray *buttonRow = [self.keyboardButtons objectAtIndex:j];
            
            for (NSInteger i = 0; i < buttonRow.count; i++) {
                MCButton *btn = [buttonRow objectAtIndex:i];
                
                
                float multiplier = widthMult;
               // if (j == self.keyboardButtons.count - 1) {
                  //  multiplier = self.simple ? widthMult : 2 * widthMult;
                //}
    
                [btn.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:multiplier constant:-1.25].active = YES;
                [btn.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:0.2 constant:-1.25].active = YES;
          
                if (i == 0) {
                    [btn.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:1].active = YES;
                } else {
                    UIButton *btnToLeft = [buttonRow objectAtIndex:i - 1];
                    [btn.leftAnchor constraintEqualToAnchor:btnToLeft.rightAnchor constant:1].active = YES;
                }
                
                if (j == 0) {
                    [btn.topAnchor constraintEqualToAnchor:self.topAnchor constant:1].active = YES;
                } else {
                    if ([[self.keyboardButtons objectAtIndex:j - 1] count] >= i) {
                        NSArray *aboveRow = [self.keyboardButtons objectAtIndex:j - 1];
                        UIButton *btnAbove = [aboveRow objectAtIndex:aboveRow.count-1];
                        [btn.topAnchor constraintEqualToAnchor:btnAbove.bottomAnchor constant:1].active = YES;
                    } else {
                        UIButton *btnAbove = [[self.keyboardButtons objectAtIndex:j - 1] objectAtIndex:i];
                        [btn.topAnchor constraintEqualToAnchor:btnAbove.bottomAnchor constant:1].active = YES;
                    }
                }
            }
        }
    }
}

- (void)keyDown:(id)sender {
    MCButton *button = (MCButton *)sender;
    button.backgroundColor = [UIColor darkGrayColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if (button.tag == -1) {
        UIImage *btnImage = [UIImage imageNamed:@"backspace-white.png"];
        [button.insideView setImage:btnImage];
    }
}

- (void)keyUp:(id)sender {
    MCButton *button = (MCButton *)sender;
    button.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0f];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSString *keyText = [button titleForState:UIControlStateNormal];
    
    if (button.tag == -1) {
        UIImage *btnImage = [UIImage imageNamed:@"backspace-black.png"];
        [button.insideView setImage:btnImage];
        keyText = @"bkspc";
    }
    
    [self.delegate sendInput:self keyText:keyText];
}

- (void)keyUpWithoutAction:(id)sender {
    MCButton *button = (MCButton *)sender;
    button.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0f];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSString *keyText = [button titleForState:UIControlStateNormal];
    
    if (button.tag == -1) {
        UIImage *btnImage = [UIImage imageNamed:@"backspace-black.png"];
        [button.insideView setImage:btnImage];
        keyText = @"bkspc";
    }
}

@end
