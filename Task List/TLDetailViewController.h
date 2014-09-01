//
//  TLDetailViewController.h
//  Task List
//
//  Created by JoissDev on 28/08/14.
//  Copyright (c) 2014 joiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *taskLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewLabel;

- (IBAction)editiBtn:(id)sender;
@end
