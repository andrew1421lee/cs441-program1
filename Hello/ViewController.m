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

- (IBAction)spinButton:(id)sender {
    
    CABasicAnimation *fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotate"];
    fullRotation.byValue = @(M_PI*2);
    fullRotation.fromValue = self.view.layer.presentationLayer;
    fullRotation.duration = 30.0;
    
    //button.transform = CGAffineTransformMakeRotation(M_PI / -4);
    
    [self.button.layer addAnimation:fullRotation forKey:@"myRotationAnimation"];
}

@end
