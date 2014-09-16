//
//  TLUpdateTaskViewController.m
//  Task List
//
//  Created by JoissDev on 28/08/14.
//  Copyright (c) 2014 joiss. All rights reserved.
//

#import "TLUpdateTaskViewController.h"

@interface TLUpdateTaskViewController ()

@end

@implementation TLUpdateTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.taskNameField.text = self.task.title;
    self.viewTextView.text = self.task.description;
    self.datePicker.date = self.task.date;
    
    self.taskNameField.delegate = self;
    self.viewTextView.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveTaskBtnPress:(id)sender
{
    [self updateTask];
    [self.delegate didUpdateTask];
}

-(void)updateTask
{
    self.task.title = self.taskNameField.text;
    self.task.description = self.viewTextView.text;
    self.task.date = self.datePicker.date;
}

#pragma  mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskNameField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITableView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [self.viewTextView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
