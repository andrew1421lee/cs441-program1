//
//  ViewController.h
//  Hello
//
//  Created by Anchu Lee on 1/27/19.
//  Copyright © 2019 Anchu Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

#import <stdlib.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *greetLabel;
@property (nonatomic, strong) IBOutlet UILabel *tapLabel;
@property (nonatomic, strong) IBOutlet UILabel *tapCounter;
@property (nonatomic, strong) IBOutlet UILabel *speedometer;
@property (nonatomic, strong) IBOutlet UILabel *speedoLabel;
@property (nonatomic, readwrite) UIGestureRecognizerState state;

@end

