//
//  ViewController.m
//  Converter
//
//  Created by Oliver Foggin on 20/01/2015.
//  Copyright (c) 2015 Oliver Foggin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *fahrenheitTextField;
@property (weak, nonatomic) IBOutlet UITextField *celsiusTextField;

@property (nonatomic, strong) UITextField *currentTextField;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fahrenheitTextFieldChanged
{
    CGFloat fahrenheit = [self.fahrenheitTextField.text floatValue];
    
    CGFloat celsius = [self convertFahrenheitToCelsius:fahrenheit];
    
    self.celsiusTextField.text = [NSString stringWithFormat:@"%.2f", celsius];
}

- (IBAction)celsiusTextFieldChanged
{
    CGFloat celsius = [self.celsiusTextField.text floatValue];
    
    CGFloat fahrenheit = [self convertCelsiusToFahrenheit:celsius];
    
    self.fahrenheitTextField.text = [NSString stringWithFormat:@"%.2f", fahrenheit];
}

- (CGFloat)convertFahrenheitToCelsius:(CGFloat)fahrenheit
{
    return (fahrenheit - 32) * 5/9;
}

- (CGFloat)convertCelsiusToFahrenheit:(CGFloat)celsius
{
    return celsius * 9/5 + 32;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currentTextField = textField;
}

- (UIView *)inputAccessoryView
{
    UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64)];
    accessoryView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"+/-" forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 10, 44, 44);
    [button setTintColor:[UIColor blackColor]];
    button.backgroundColor = [UIColor colorWithHue:0.09 saturation:0.84 brightness:0.94 alpha:1];
    button.layer.cornerRadius = 8;
    [button addTarget:self action:@selector(changeNumberPolarity) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView addSubview:button];
    
    return accessoryView;
}

- (void)changeNumberPolarity
{
    NSString *currentString = self.currentTextField.text;
    
    if ([currentString rangeOfString:@"-"].location == NSNotFound) {
        self.currentTextField.text = [NSString stringWithFormat:@"-%@", currentString];
    } else {
        self.currentTextField.text = [currentString substringFromIndex:1];
    }
    
    if (self.currentTextField == self.fahrenheitTextField) {
        [self fahrenheitTextFieldChanged];
    } else {
        [self celsiusTextFieldChanged];
    }
}

@end
