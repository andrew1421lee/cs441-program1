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
@synthesize greetLabel, tapLabel, tapCounter, speedometer, speedoLabel;

static NSArray *greetings;
static NSArray *colors;
static NSTimer *idleTimer;
static int greetingIndex;
static int colorCounter;
static int tapTotal;

static int tapsInLastSecond;
static float avgTapsPerSecond;
static int secondsElapsed;

- (void)viewDidLoad {
    [super viewDidLoad];
    greetings = [NSArray arrayWithObjects:@"Hello!", @"¡Hola!", @"مرحبا!", @"שלום!", @"你好!", @"Hallo!", @"こんにちは!", @"สวัสดี!", @"여보세요!", @"звать!", @"Salut!", @"Witaj!", @"Cheerio!", @"o/", @"Wassup!", @"Zdravo!", @"Привіт!", @"ဟယ်လို!", @"Xin Chào!", @"Olá!", @"Ahoj!", @"سلام!", @"Dia Dhuit!", @"Hej!", @"nuqneH!", @"G'day Mate!", @"\\(•◡•)/", @"HEWWO!!?", nil];
    colors = [NSArray arrayWithObjects: [UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor], nil];
    greetingIndex = 1;
    colorCounter = 1;
    tapTotal = 0;
    
    tapsInLastSecond = 0;
    avgTapsPerSecond = 0;
    secondsElapsed = 0;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFunction) userInfo:Nil repeats:YES];
    
    //[NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(speedometerUpdate) userInfo:Nil repeats:YES];
    
    // Set up tap detector
    // Using long press gesture set to 0 to grab press-down
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [tap setMinimumPressDuration:0];
    [self.view addGestureRecognizer:tap];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void) resetSpeedometerTimer {
    if(!idleTimer) {
        idleTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(idleTimerExceeded) userInfo:Nil repeats:NO];
    }
    else {
        if (fabs([idleTimer.fireDate timeIntervalSinceNow]) < 3-1.0) {
            [idleTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3]];
        }
    }
}

- (void)idleTimerExceeded {
    idleTimer = nil;
    //[self startScreenSaverOrSomethingInteresting];
    secondsElapsed = 0;
    avgTapsPerSecond = 0;
    [self->speedometer setText:@"0.00"];
    //[self animateSPEED];
    [self resetSpeedometerTimer];
}

/*
- (void) speedometerUpdate {
    [self->speedometer setText:[NSString stringWithFormat:@"%.02f", avgTapsPerSecond]];
}
*/

- (void) timerFunction {
    secondsElapsed++;
    avgTapsPerSecond = (avgTapsPerSecond * (secondsElapsed - 1) + tapsInLastSecond) / secondsElapsed;
    tapsInLastSecond = 0;
    [self->speedometer setText:[NSString stringWithFormat:@"%.02f", avgTapsPerSecond]];
    if(avgTapsPerSecond >= 5) {
        [self animateSPEED];
    }
}

// Method called when tapped
- (void)onTap:(UITapGestureRecognizer *)recognizer {
    // Check if call is from initial touch
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self resetSpeedometerTimer];
        
        // Tap counter code
        tapTotal++;
        tapsInLastSecond++;
        if(tapTotal >= 10 && [tapLabel isHidden])
        {
            [tapLabel setHidden:false];
            [tapCounter setHidden:false];
        }
        if(tapTotal >= 20 && [speedometer isHidden])
        {
            [speedoLabel setHidden:false];
            [speedometer setHidden:false];
            secondsElapsed = 0;
            avgTapsPerSecond = 0;
            [self animateSpeedometerAppear];
            [self animateSPEED];
        }
        
        // Animate labels
        [UIView animateWithDuration:0.1 animations:^{
            self->greetLabel.transform = CGAffineTransformScale(self->greetLabel.transform, 0.75, 0.75);
            self->tapCounter.transform = CGAffineTransformScale(self->tapCounter.transform, 0.90, 0.90);
        
        } completion:^(BOOL finished) {
            // Update counter
            [self->tapCounter setText:[NSString stringWithFormat:@"%d", tapTotal]];
            
            // Continue animation
            [UIView animateWithDuration:0.1 animations:^{
                self->greetLabel.transform = CGAffineTransformScale(self->greetLabel.transform, 1/0.75, 1/0.75);
                self->tapCounter.transform = CGAffineTransformScale(self->tapCounter.transform, 1/0.90, 1/0.90);
            }];
        }];
        
        // Drop animation
        [self dropText];
    }
}

- (void) animateSpeedometerAppear {
    UILabel *explosiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 212, 375, 21)];
    [explosiveLabel setText: [speedoLabel text]];
    [explosiveLabel setTextColor: [UIColor redColor]];
    [explosiveLabel setFont:[UIFont systemFontOfSize:17]];
    explosiveLabel.textAlignment = NSTextAlignmentCenter;
    
    [[self view] addSubview:explosiveLabel];
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        explosiveLabel.transform = CGAffineTransformScale(explosiveLabel.transform, 2, 2);
        [explosiveLabel setAlpha:0.0f];
    } completion:^(BOOL finished) {
        //
    }];
}

- (void) animateSPEED {
    UILabel *explosiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 241, 375, 42)];
    [explosiveLabel setText: [speedometer text]];
    [explosiveLabel setTextColor: [UIColor redColor]];
    [explosiveLabel setFont:[UIFont systemFontOfSize:35]];
    explosiveLabel.textAlignment = NSTextAlignmentCenter;
    
    [[self view] addSubview:explosiveLabel];
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        explosiveLabel.transform = CGAffineTransformScale(explosiveLabel.transform, 2, 2);
        [explosiveLabel setAlpha:0.0f];
    } completion:^(BOOL finished) {
        //
    }];
}

- (void) dropText {
    // Get screen dimensions
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    // find left/right adjustment for new label
    int adjustment = arc4random_uniform(100) - 50;
    
    // Create Label right on top of the greet label
    UILabel *fallLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 + adjustment,303, 375, 60)];
    // Make it the content as the greet label
    [fallLabel setText: [greetLabel text]];
    [fallLabel setTextColor:[greetLabel textColor]];
    fallLabel.textAlignment = NSTextAlignmentCenter;
    // Set font to be smaller
    [fallLabel setFont:[UIFont systemFontOfSize:40]];
    // Add label to the view
    [[self view] addSubview:fallLabel];
    
    // Set button to next message
    [self nextMessage];
    
    // Play falling animation, then remove
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [fallLabel setCenter:CGPointMake(screenWidth/2 + adjustment, screenHeight+60)];
        [fallLabel setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [fallLabel removeFromSuperview];
    }];
}

- (void) nextMessage {
    // Set title to a variable in the array
    [greetLabel setText:[greetings objectAtIndex:greetingIndex]];
    // Set colors of the labels
    [greetLabel setTextColor:[colors objectAtIndex:colorCounter]];
    [tapLabel setTextColor:[colors objectAtIndex:colorCounter]];
    [tapCounter setTextColor:[colors objectAtIndex:colorCounter]];
    
    // Choose the next index, dont allow the same one twice
    int newIndex = arc4random_uniform((uint32_t) [greetings count]);
    while(greetingIndex == newIndex)
    {
        newIndex = arc4random_uniform((uint32_t) [greetings count]);
    }
    greetingIndex = newIndex;
    
    // Choose next color
    colorCounter++;
    if(colorCounter >= [colors count])
    {
        colorCounter = 0;
    }
}

@end
