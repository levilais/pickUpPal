//
//  saveViewController.m
//  Prayer
//
//  Created by Levi on 5/1/15.
//  Copyright (c) 2015 App Volks. All rights reserved.
//

#import "EvernoteLoginViewController.h"

@interface EvernoteLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *loginPopUpView;

@end

@implementation EvernoteLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated {
    [self popUpViewAnimation:self.loginPopUpView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Actions
- (IBAction)cancelButtonPressed:(id)sender {
    [self closeViewAnimation:self.loginPopUpView];
    [self.navigationController popToRootViewControllerAnimated:YES];

//    [self dismissViewControllerAnimated:YES completion:nil];

    //    [self performSegueWithIdentifier:@"returnToMainView" sender:self];
    
    
}


# pragma mark - Helper Methods

//- (void)toggleShowLogin {
//    if (self.loginPopUp.hidden == YES) {
//        [self popUpViewAnimation:self.loginPopUp];
//        self.evernoteLoginBackground.alpha = 1;
//    } else {
//        [self closeViewAnimation:self.loginPopUp];
//        self.evernoteLoginBackground.alpha = 0;
//        [self.textView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
//    }
//}

// NEED TO EDIT FOR EVERNOTE POP UP

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
