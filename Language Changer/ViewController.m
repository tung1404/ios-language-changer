//
//  ViewController.m
//  Language Changer
//
//  Created by Alan Chung on 25/11/2014.
//  Copyright (c) 2014 Alan Chung. All rights reserved.
//

#import "ViewController.h"
#import "LanguageManager.h"
#import "Localisation.h"
#import "Constants.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.flagImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    LanguageManager *languageManager = [LanguageManager sharedLanguageManager];
    
    NSInteger selectedIndex = 0;
    
    Localisation *selectedLocalisation = [languageManager getSelectedLocalisation];
    
    selectedIndex = [languageManager.availableLocalisations indexOfObject:selectedLocalisation];
    
    // Move the picker to match what was selected previously.
    [self.localisationPicker selectRow:selectedIndex inComponent:0 animated:YES];
    
    [self setupLocalisableElements];
}

- (void)viewDidAppear:(BOOL)animated {
    
    self.textView.contentOffset = CGPointZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Localisation

- (void)setupLocalisableElements {
    
    self.title = CustomLocalisedString(@"Title", @"The string to display in the navigation bar.");
    
    self.textView.text = CustomLocalisedString(@"Text", @"The string to display in the text view.");
    self.textView.contentOffset = CGPointZero;
    
    UIImage *flagImage = [UIImage imageNamed:[[LanguageManager sharedLanguageManager] getSelectedLocalisation].countryCode];
    [self.flagImageView setImage:flagImage];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [LanguageManager sharedLanguageManager].availableLocalisations.count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    Localisation *localisationForRow = [LanguageManager sharedLanguageManager].availableLocalisations[row];
    
    return localisationForRow.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    LanguageManager *languageManager = [LanguageManager sharedLanguageManager];
    
    Localisation *localisationForRow = languageManager.availableLocalisations[row];
    
    NSLog(@"Language selected: %@", localisationForRow.name);
    
    [languageManager setLanguageWithLocalisation:localisationForRow];
    
    [self setupLocalisableElements];
}

@end
