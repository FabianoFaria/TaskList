//
//  TLUpdateTaskViewController.h
//  Task List
//
//  Created by JoissDev on 28/08/14.
//  Copyright (c) 2014 joiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLUpdateTaskViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *taskNameField;
@property (strong, nonatomic) IBOutlet UITextView *viewTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)saveTaskBtnPress:(id)sender;

@end
