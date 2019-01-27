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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)changeMessage:(id)sender {
    [button setTitle:@"Ni Hao" forState:UIControlStateNormal];
}

- (IBAction)dropText:(id)sender {
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,303, 375, 60)];
    [newLabel setText: [button titleForState:UIControlStateNormal]];
    [newLabel setFont:[UIFont systemFontOfSize:40]];
    newLabel.textAlignment = NSTextAlignmentCenter;
    [[self view] addSubview:newLabel];
    
    
    CABasicAnimation *fallDown = [CABasicAnimation animationWithKeyPath:@"position"];
    fallDown.duration = 0.5;
    fallDown.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    [newLabel.layer addAnimation:fallDown forKey:@"falling"];
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
