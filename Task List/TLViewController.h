//
//  TLViewController.h
//  Task List
//
//  Created by JoissDev on 26/08/14.
//  Copyright (c) 2014 joiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)reorderBtn:(UIBarButtonItem *)sender;
- (IBAction)createTaskBtn:(UIBarButtonItem *)sender;
@end
