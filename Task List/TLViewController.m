//
//  TLViewController.m
//  Task List
//
//  Created by JoissDev on 26/08/14.
//  Copyright (c) 2014 joiss. All rights reserved.
//

#import "TLViewController.h"

@interface TLViewController ()

@end

@implementation TLViewController

-(NSMutableArray *)taskObjects
{
    if(!_taskObjects)
    {
        _taskObjects = [[NSMutableArray alloc] init];
    }
    
    return _taskObjects;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[TLCreateTaskViewController class]])
    {
        TLCreateTaskViewController *addTaskViewController = segue.destinationViewController;
        addTaskViewController.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderBtn:(UIBarButtonItem *)sender {
}

- (IBAction)createTaskBtn:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toCreateTask" sender:nil];
}


#pragma mark - TLCreateTaskViewControllerDelegate

-(void)createTask:(TLTasks *)task
{
    [self.taskObjects addObject:task];
    
    NSLog(@"%@", task.title);
    
    NSMutableArray *taskObjectAsPropertyList = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    
    if(!taskObjectAsPropertyList)
    {
        taskObjectAsPropertyList = [[NSMutableArray alloc] init];
    }
    
    [taskObjectAsPropertyList addObject:[self taskObjectAsPropertyList:task]];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectAsPropertyList forKey:TASK_OBJECTS_KEY];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
    
}

-(void)Cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper Methods

-(NSDictionary *)taskObjectAsPropertyList:(TLTasks *)taskObject
{
    NSDictionary *dictionary = @{TASK_TITLE : taskObject.title, TASK_DESCRIPTION : taskObject.description, TASK_DATE : taskObject.date, TASK_COMPLETION : @(taskObject.isCompleted)};
    return dictionary;
}

@end
