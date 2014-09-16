//
//  TLDetailViewController.h
//  Task List
//
//  Created by JoissDev on 28/08/14.
//  Copyright (c) 2014 joiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTasks.h"
#import "TLUpdateTaskViewController.h"

@protocol TLDetailViewControllerDelegate <NSObject>

-(void)updateTask;

@end

@interface TLDetailViewController : UIViewController <TLUpdateTaskViewControllerDelegate>

@property (strong, nonatomic) TLTasks *task;
@property (weak, nonatomic) id <TLDetailViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *taskLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewLabel;

- (IBAction)editiBtn:(id)sender;
@end
