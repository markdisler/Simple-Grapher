//
//  ViewController.m
//  GraphingSandbox
//
//  Created by Mark Disler on 7/6/17.
//  Copyright © 2017 Mark. All rights reserved.
//

#import "ViewController.h"
#import "GraphView.h"
#import "CCInputField.h"
#import "CCGraphableFunction.h"
#import "UIColor+CCColors.h"

@interface ViewController ()

@property (nonatomic, strong) GraphView *graph;

@property (nonatomic, strong) CCInputField *field1;
@property (nonatomic, strong) CCInputField *field2;
@property (nonatomic, strong) CCInputField *field3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // CREATE textfields for equations
    CGFloat w = self.view.frame.size.width + 8;
    self.field1 = [[CCInputField alloc] initWithFrame:CGRectMake(-4, 60,  w, 80) title:@"Y₁ = "];
    self.field2 = [[CCInputField alloc] initWithFrame:CGRectMake(-4, 138, w, 80) title:@"Y₂ = "];
    self.field3 = [[CCInputField alloc] initWithFrame:CGRectMake(-4, 216, w, 80) title:@"Y₃ = "];
    [self.view addSubview:self.field1];
    [self.view addSubview:self.field2];
    [self.view addSubview:self.field3];
    
    // Set constant edit textfield to custom keyboard
    CCKeypad *keypad1 = [[CCKeypad alloc] initMathKeypadForField:self.field1];
    CCKeypad *keypad2 = [[CCKeypad alloc] initMathKeypadForField:self.field2];
    CCKeypad *keypad3 = [[CCKeypad alloc] initMathKeypadForField:self.field3];
    keypad1.delegate = self;
    keypad2.delegate = self;
    keypad3.delegate = self;
    
    
    UIButton *graphBtn = [[UIButton alloc] initWithFrame:CGRectMake(-4, 294, w, 45)];
    [graphBtn setTitle:@"Graph" forState:UIControlStateNormal];
    [graphBtn setBackgroundColor:[UIColor lightGrayColor]];
    [graphBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:22]];
    [graphBtn.layer setBorderWidth:2];
    [graphBtn.layer setBorderColor:[UIColor blackColor].CGColor];
    [graphBtn addTarget:self action:@selector(showGraphedEquations) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:graphBtn];
    
}


#pragma mark - Graphing


- (void)showGraphedEquations {
    
    // Resign keypads
    [self.field1 resignFirstResponder];
    [self.field2 resignFirstResponder];
    [self.field3 resignFirstResponder];
    
    // Build array of all functions to graph
    NSMutableArray *funcs = [NSMutableArray array];
    if (self.field1.text.length != 0) {
        [funcs addObject:[[CCGraphableFunction alloc] initWithFunction:self.field1.text]];
    }
    if (self.field2.text.length != 0) {
        [funcs addObject:[[CCGraphableFunction alloc] initWithFunction:self.field2.text]];
    }
    if (self.field3.text.length != 0) {
        [funcs addObject:[[CCGraphableFunction alloc] initWithFunction:self.field3.text]];
    }
    
    // Create the back button
    UIButton *backBtn = [ViewController closeGraphButton];
    [backBtn addTarget:self action:@selector(hideGrapher) forControlEvents:UIControlEventTouchUpInside];
    
    // Create the grapher
    self.graph = [[GraphView alloc] initWithAxisLength:self.view.frame.size.width];
    self.graph.backgroundColor = [UIColor CCGray1];
    self.graph.clipsToBounds = YES;
    self.graph.alpha = 0.0;
    [self.view addSubview:self.graph];
    [self.graph addSubview:backBtn];
    self.graph.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    [self.graph clearGraph];
    [self.graph createGeneralGraph];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.graph.alpha = 1.0;
    } completion:^(BOOL completed) {
    }];
    
    for (CCGraphableFunction *eq in funcs) {
        [self.graph graphEquation:eq];
    }
}

- (void)hideGrapher {
    [UIView animateWithDuration:0.3 animations:^{
        self.graph.alpha = 0.0;
    } completion:^(BOOL finished){
        [self.graph removeFromSuperview];
        self.graph = nil;
    }];
}

#pragma mark - Delegate Methods

- (void)sendInput:(CCKeypad *)keypad keyText:(NSString *)keyText {
    if ([keyText isEqualToString:@"bkspc"]) {
        [keypad.textField deleteBackward];
    } else {
        [keypad.textField insertText:keyText];
    }
}

#pragma mark - Misc

+ (UIButton *)closeGraphButton {
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(6, 6, 36, 36)];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f];
    backBtn.layer.cornerRadius = backBtn.frame.size.width/2;
    backBtn.layer.borderColor = [UIColor blackColor].CGColor;
    backBtn.layer.borderWidth = 1.2f;
    backBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    backBtn.layer.shadowRadius = 4;
    backBtn.layer.shadowOpacity = 0.35;
    backBtn.layer.shadowOffset = CGSizeMake(0, 0);
    [backBtn setImage:[[UIImage imageNamed:@"Cancel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(5,5,5,5);
    return backBtn;
}


@end
