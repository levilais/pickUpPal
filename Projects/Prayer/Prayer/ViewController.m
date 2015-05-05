//
//  ViewController.m
//  Prayer
//
//  Created by Levi on 4/20/15.
//  Copyright (c) 2015 App Volks. All rights reserved.
//

#import "ViewController.h"
#import "SaveViewController.h"
#import "EvernoteLoginViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITextView appearance] setTintColor:[UIColor blackColor]];
    [self howToIntroAnimation];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:1.7f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [self moveButton:self.settingsButton delay:1 duration:2];
}


# pragma mark - Actions

- (IBAction)settingsButtonDidPress:(id)sender {
    
    UIImage *highlightedImage = [UIImage imageNamed:@"settingsIconSelected"];
    [self.settingsButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [self.settingsButton setImage:highlightedImage forState:UIControlStateSelected];

    [self toggleShowSettings];
}

- (IBAction)dismissSettingsPopUpButton:(id)sender {
    [self toggleShowSettings];
}
- (IBAction)dismissSettingsPopUpBackgroundTwoDidPress:(id)sender {
    [self toggleShowSettings];
}
- (IBAction)dismissSettingsPopUpBackgroundThreeDidPress:(id)sender {
    [self toggleShowSettings];
}
- (IBAction)dismissSettingsPopUpBackgroundFourDidPress:(id)sender {
    [self toggleShowSettings];
}

- (IBAction)evernoteLogin:(id)sender {
    float loggedIn = 8;
    if (loggedIn == 8) {
        // login
    } else {
        // logout
    }
}








- (IBAction)swipeRight:(id)sender {
    float eight = 7;
    
    if (eight == 8) {
        [self performSegueWithIdentifier:@"showSaveViewController" sender:self];
    } else {
        [self performSegueWithIdentifier:@"showEvernoteLoginViewController" sender:self];
    }
}

# pragma mark - Intro Animations

- (void)howToIntroAnimation {
    // Animate Prayer image exit
    UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"prayerLaunchScreenImage"]];
    titleImage.alpha = 1.0f;
    [UIImageView animateWithDuration:1.0f
                               delay:1.0f
                             options:UIViewAnimationOptionCurveEaseIn
                          animations:^{ _titleImage.alpha = 0.0f; }
                          completion:^(BOOL finished){}
     ];
    
    UIImageView *swipeToSave =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"swipeToSave"]];
    swipeToSave.frame = CGRectMake(self.view.frame.size.width/2 - swipeToSave.frame.size.width/2, -20, 150, 20);
    [self.view addSubview:swipeToSave];
    
    // Animate swipeToSave enter
    [self moveImage:swipeToSave duration:1.5f
              delay:4 x:0 y:30.0];
    
    // Animate swipeToSave exit
    [self moveImage:swipeToSave duration:1.8f
              delay:7 x: -self.view.frame.size.width - swipeToSave.frame.size.width y:30];
    

    UIImageView *swipeToSend =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"swipeToSend"]];
    swipeToSend.frame = CGRectMake(self.view.frame.size.width/2 - swipeToSend.frame.size.width/2, -20, 150, 20);
    [self.view addSubview:swipeToSend];
    
    // Animate swipeToSend enter
    [self moveImage:swipeToSend duration:1.5f
              delay:8 x:0 y:30.0];
    
    // Animate swipeToSend exit
    [self moveImage:swipeToSend duration:1.8f
              delay:11 x: + self.view.frame.size.width + swipeToSend.frame.size.width y:30];
    
    UIImageView *shakeToUndo =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shakeToUndo"]];
    shakeToUndo.frame = CGRectMake(self.view.frame.size.width/2 - shakeToUndo.frame.size.width/2, -20, 150, 20);
    [self.view addSubview:shakeToUndo];
    
    // Animate shakeToUndo enter
    [self moveImage:shakeToUndo duration:1.5f
              delay:12 x:0 y:30.0];
    
    // Animate shake
    
    // Animate shakeToUndo exit
    [self moveImage:shakeToUndo duration:1.5f
              delay:15 x:0 y:-20.0];
}

# pragma mark - Helper Methods

- (void)toggleShowSettings {
    if (self.settingsButton.isSelected == YES) {
        self.settingsPopUpBackground.hidden = YES;
        self.settingsBelowTheFoldView.hidden = YES;
        [self.settingsButton setSelected:NO];
        [self closeViewAnimation:self.settingsPopUp];
        self.settingsPopUpBackground.hidden = YES;
        [self.textView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
        
    } else {
        [self.settingsButton setSelected:YES];
        self.settingsBelowTheFoldView.hidden = NO;
        self.settingsPopUpBackground.hidden = NO;
        [self popUpViewAnimation:self.settingsPopUp];
        self.settingsPopUpBackground.hidden = NO;
        [self.textView resignFirstResponder];
    }
}

- (void)moveImage:(UIImageView *)image duration:(NSTimeInterval)duration
            delay:(NSTimeInterval)delay x:(CGFloat)x y:(CGFloat)y
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:delay];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
}

- (void)moveButton:(UIButton *)button delay:(NSTimeInterval)delay duration:(NSTimeInterval)duration {
    
    [UIView animateWithDuration:duration animations:^{
    [UIView setAnimationDelay:delay];
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 40);
    [button setTransform:transform];
    }];
}

- (void)popUpViewAnimation:(UIView *)popUpView  {
    
    popUpView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    
    [UIView animateWithDuration:0.5f delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.4f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        popUpView.hidden = NO;
        popUpView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
}
     
- (void)closeViewAnimation:(UIView *)popUpView {
    [UIView animateWithDuration:0.2 animations:^{
        popUpView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        popUpView.hidden = YES;
    }];
}





@end
