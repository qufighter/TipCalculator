//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Sam Larison on 9/21/15.
//  Copyright (c) 2015 SamLarison@Vidsbee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipPercent;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.



}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");


    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int intValue = [defaults integerForKey:@"saved_tip_percent"];

    self.defaultTipPercent.selectedSegmentIndex = intValue;


}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");


    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.defaultTipPercent.selectedSegmentIndex forKey:@"saved_tip_percent"];
    [defaults synchronize];
}

@end