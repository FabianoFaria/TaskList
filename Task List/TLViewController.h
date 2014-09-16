//
//  TLViewController.h
//  Task List
//
//  Created by JoissDev on 26/08/14.
//  Copyright (c) 2014 joiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLCreateTaskViewController.h"
#import "TLDetailViewController.h"

@interface TLViewController : UIViewController <TLCreateTaskViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, TLDetailViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *taskObjects;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)reorderBtn:(UIBarButtonItem *)sender;
- (IBAction)createTaskBtn:(UIBarButtonItem *)sender;
@end
