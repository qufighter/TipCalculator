//
//  ViewController.m
//  TipCalculator
//
//  Created by Sam Larison on 9/21/15.
//  Copyright (c) 2015 SamLarison@Vidsbee. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (strong, nonatomic) IBOutlet UIView *myView;
@property (nonatomic, strong) NSNumberFormatter *currencyFormatter;
@property (weak, nonatomic) IBOutlet UILabel *currencyFormat;

- (IBAction)billAmountChanged:(id)sender;
- (IBAction)onTap:(id)sender;

- (IBAction)clearBill:(id)sender;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    
    if (self) {
        self.title = @"Tip Calculator";


        self.currencyFormatter = [[NSNumberFormatter alloc] init];
        [self.currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];

    [self updateValues];
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int intValue = [defaults integerForKey:@"saved_tip_percent"];
    self.tipControl.selectedSegmentIndex = intValue;

    [self.billTextField becomeFirstResponder];

    [self updateValues];

    // Optionally initialize the property to a desired starting value
    self.myView.alpha = 0.25;

}

- (void)viewDidAppear:(BOOL)animated {
    [UIView animateWithDuration:0.4 animations:^{
        // This causes first view to fade in and second view to fade out
        self.myView.alpha = 1;
    } completion:^(BOOL finished) {
        // Do something here when the animation finishes.
    }];

    [self updateValues];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    //[self.view endEditing:YES]; // if portrait
    [self updateValues];
}

- (IBAction)billAmountChanged:(id)sender {
    //[self.view endEditing:YES];
    [self updateValues];
}


- (IBAction)clearBill:(id)sender {
    self.billTextField.text = @"";
    [self updateValues];
}

- (void)updateValues{
    float billAmt = [self.billTextField.text floatValue];

    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];

    float tipAmount = billAmt * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];

    float total = tipAmount + billAmt;


    self.tipLabel.text = [self.currencyFormatter stringFromNumber:[NSNumber numberWithFloat:tipAmount]];
    self.totalLabel.text = [self.currencyFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
//    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
//    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", total];
    self.currencyFormat.text = [self.currencyFormatter currencySymbol];

}


@end
