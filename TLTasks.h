//
//  TLTasks.h
//  Task List
//
//  Created by JoissDev on 01/09/14.
//  Copyright (c) 2014 joiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLTasks : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL isCompleted;

-(id)initWithData:(NSDictionary *)data;


@end
