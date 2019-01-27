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
@synthesize greetLabel;

static NSArray *greetings;
static int counter;

- (void)viewDidLoad {
    [super viewDidLoad];
    greetings = [NSArray arrayWithObjects:@"Hello!", @"¡Hola!", @"مرحبا!", @"שלום!", @"你好!", @"Hallo!", @"こんにちは!", @"สวัสดี!", @"여보세요!", @"звать!", @"Salut!", @"Witaj!", @"Cheerio!", @"o/", @"Wassup!", nil];
    counter = 0;
    
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [tap setMinimumPressDuration:0];
    [self.view addGestureRecognizer:tap];

    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)changeMessage:(id)sender {
    
    [greetLabel setText:[greetings objectAtIndex:counter]];
    counter++;
    if (counter >= [greetings count]) {
        counter = 0;
    }
}

- (void)onTap:(UITapGestureRecognizer *)recognizer {
    //button.titleLabel.font = [UIFont systemFontOfSize:40];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.1 animations:^{
            //[self->greetLabel setFont:[UIFont systemFontOfSize:40]];
            self->greetLabel.transform = CGAffineTransformScale(self->greetLabel.transform, 0.75, 0.75);
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self->greetLabel.transform = CGAffineTransformScale(self->greetLabel.transform, 1/0.75, 1/0.75);
            }];
        }];
        
        [self dropText];
        //[greetLabel setFont:[UIFont systemFontOfSize:40]];
        //[greetLabel setText:@"what"];
    }
    /*else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        [self dropText];
    }*/
}

- (void)dropText {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    // Create Label that falls directly from the button
    UILabel *fallLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,303, 375, 60)];
    [fallLabel setText: [greetLabel text]];
    [fallLabel setFont:[UIFont systemFontOfSize:40]];
    fallLabel.textAlignment = NSTextAlignmentCenter;
    [[self view] addSubview:fallLabel];
    
    // Set button to next message
    [self nextMessage];
    
    // Play falling animation, then remove
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [fallLabel setCenter:CGPointMake(screenWidth/2, screenHeight+300)];
    } completion:^(BOOL finished) {
        [fallLabel removeFromSuperview];
    }];
}

- (void) nextMessage {
    // Set title to a variable in the array
    [greetLabel setText:[greetings objectAtIndex:counter]];
    [greetLabel setFont:[UIFont systemFontOfSize:70]];
    //button.titleLabel.font = [UIFont systemFontOfSize:70];
    
    // Choose the next index
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
    
    [self.greetLabel.layer addAnimation:fullRotation forKey:@"myRotationAnimation"];
}

@end
