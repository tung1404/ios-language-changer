//
//  ViewController.h
//  Language Changer
//
//  Created by Alan Chung on 25/11/2014.
//  Copyright (c) 2014 Alan Chung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UIPickerView *localisationPicker;
@property (nonatomic, weak) IBOutlet UIImageView *flagImageView;
@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

