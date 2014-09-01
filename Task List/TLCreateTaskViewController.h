//
//  TLCreateTaskViewController.h
//  Task List
//
//  Created by JoissDev on 28/08/14.
//  Copyright (c) 2014 joiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTasks.h"

@protocol TLCreateTaskViewControllerDelegate <NSObject>

-(void)Cancel;
-(void)createTask:(TLTasks *)task;

@end


@interface TLCreateTaskViewController : UIViewController

@property (weak, nonatomic) id <TLCreateTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)createTaskBtnPress:(UIButton *)sender;
- (IBAction)cancelBtnPress:(UIButton *)sender;

@end
