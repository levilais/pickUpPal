//
//  ViewController.h
//  Prayer
//
//  Created by Levi on 4/20/15.
//  Copyright (c) 2015 App Volks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIView *settingsPopUp;
@property (weak, nonatomic) IBOutlet UIButton *settingsPopUpBackground;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *loginPopUp;
@property (weak, nonatomic) IBOutlet UIView *settingsBelowTheFoldView;

- (IBAction)swipeRight:(id)sender;


@end

