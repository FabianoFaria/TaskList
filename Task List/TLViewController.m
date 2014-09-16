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
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSArray *taskAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY];
    
    for(NSDictionary *dictionary in taskAsPropertyLists)
    {
        TLTasks *taskObject = [self taskObjectForDictionary:dictionary];
        [self.taskObjects addObject:taskObject];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[TLCreateTaskViewController class]])
    {
        TLCreateTaskViewController *addTaskViewController = segue.destinationViewController;
        addTaskViewController.delegate = self;
    }
    else if ([segue.destinationViewController isKindOfClass:[TLDetailViewController class]])
    {
        TLDetailViewController *detailTaskViewController = segue.destinationViewController;
        NSIndexPath *path = sender;
        TLTasks *taskObject = self.taskObjects[path.row];
        detailTaskViewController.task = taskObject;
        detailTaskViewController.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderBtn:(UIBarButtonItem *)sender {
    
    if (self.tableView.editing == YES)
    {
        [self.tableView setEditing:NO animated:YES];
    }else{
        [self.tableView setEditing:YES animated:YES];
    }
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

#pragma mark - TLDetailViewControllerDelegate

-(void)updateTask
{
    [self saveTasks];
    [self.tableView reloadData];
}

#pragma mark - Helper Methods

-(NSDictionary *)taskObjectAsPropertyList:(TLTasks *)taskObject
{
    NSDictionary *dictionary = @{TASK_TITLE : taskObject.title, TASK_DESCRIPTION : taskObject.description, TASK_DATE : taskObject.date, TASK_COMPLETION : @(taskObject.isCompleted)};
    return dictionary;
}

-(TLTasks *)taskObjectForDictionary:(NSDictionary *)dictinary
{
    TLTasks *taskObject = [[TLTasks alloc] initWithData:dictinary];
    return taskObject;
}

-(BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    
    if(dateInterval > toDateInterval)
    {
        return YES;
    }
    else return NO;
}

-(void)updateCompletionOfTask:(TLTasks *)task forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *taskObjectAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    
    if(!taskObjectAsPropertyLists)
    {
        taskObjectAsPropertyLists = [[NSMutableArray alloc ] init];
        [taskObjectAsPropertyLists removeObjectAtIndex:indexPath.row];
    }
    
    if(task.isCompleted == YES) task.isCompleted = NO;
    else task.isCompleted =YES;
    
    [taskObjectAsPropertyLists insertObject:[self taskObjectAsPropertyList:task] atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}

-(void)saveTasks
{
    NSMutableArray *taskObjectsASPropertyLists = [[NSMutableArray alloc] init];
    for (int x = 0; x < [self.taskObjects count]; x ++)
    {
        [taskObjectsASPropertyLists addObject:[self taskObjectAsPropertyList:self.taskObjects[x]]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsASPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma UItableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.taskObjects count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Configurar cell
    
    TLTasks *task = self.taskObjects[indexPath.row];
    cell.textLabel.text = task.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:task.date];
    cell.detailTextLabel.text = stringFromDate;
    
    BOOL isOverDue = [self isDateGreaterThanDate:[NSDate date] and:task.date];
    
    if(task.isCompleted == YES) cell.backgroundColor = [UIColor greenColor];
    else
    if(isOverDue == YES)
    {
        cell.backgroundColor = [UIColor redColor];
    }else
        cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLTasks *task = self.taskObjects[indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newTaskObjectData = [[NSMutableArray alloc] init];
        
        for (TLTasks *task in self.taskObjects)
        {
            [newTaskObjectData addObject:[self taskObjectAsPropertyList:task]];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:newTaskObjectData forKey:TASK_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
}


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetailTask" sender:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    TLTasks *taskObject = self.taskObjects[sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:taskObject atIndex:destinationIndexPath.row];
    [self saveTasks];
    
}

@end
