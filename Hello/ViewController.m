//
//  ViewController.m
//  Hello
//
//  Created by Anchu Lee on 1/27/19.
//  Copyright © 2019 Anchu Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize button;

static NSArray *greetings;
static int counter;

- (void)viewDidLoad {
    [super viewDidLoad];
    greetings = [NSArray arrayWithObjects:@"Hello!", @"¡Hola!", @"مرحبا!", @"שלום!", @"你好!", @"Hallo!", @"こんにちは!", @"สวัสดี!", @"여보세요!", @"Здравствуйте!", nil];
    counter = 0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)changeMessage:(id)sender {
    
    [button setTitle:[greetings objectAtIndex:counter] forState:UIControlStateNormal];
    counter++;
    if (counter >= [greetings count]) {
        counter = 0;
    }
}

- (IBAction)dropText:(id)sender {
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,303, 375, 60)];
    [newLabel setText: [button titleForState:UIControlStateNormal]];
    [newLabel setFont:[UIFont systemFontOfSize:40]];
    newLabel.textAlignment = NSTextAlignmentCenter;
    [[self view] addSubview:newLabel];
    [self nextMessage];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    [UIView animateWithDuration:0.5 animations:^{
        [newLabel setCenter:CGPointMake(screenWidth/2, screenHeight + 60)];
    } completion:^(BOOL finished) {
        [newLabel removeFromSuperview];
    }];
}

- (void) nextMessage {
    [button setTitle:[greetings objectAtIndex:counter] forState:UIControlStateNormal];
    counter++;
    if (counter >= [greetings count]) {
        counter = 0;
    }
}

- (IBAction)spinButton:(id)sender {
    
    CABasicAnimation *fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    fullRotation.byValue = @(M_PI*2);
    //fullRotation.fromValue = self.view.layer.presentationLayer;
    fullRotation.duration = 0.5;
    
    //button.transform = CGAffineTransformMakeRotation(M_PI / -4);
    
    [self.button.layer addAnimation:fullRotation forKey:@"myRotationAnimation"];
}

@end
