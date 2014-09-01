//
//  TLTasks.m
//  Task List
//
//  Created by JoissDev on 01/09/14.
//  Copyright (c) 2014 joiss. All rights reserved.
//

#import "TLTasks.h"

@interface TLTasks ()

@end

@implementation TLTasks

-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if(self)
    {
        self.title = data[TASK_TITLE];
        self.description = data[TASK_DESCRIPTION];
        self.date = data[TASK_DATE];
        self.isCompleted = [data[TASK_COMPLETION] boolValue];
    }
    return self;
}

-(id)init
{
    self = [self initWithData:nil];
    return self;
}


@end
