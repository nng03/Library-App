//
//  viewTextbook.h
//  Library App
//
//  Created by fp on 3/28/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Textbook.h"

@interface viewTextbook : UIViewController

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@property (strong, nonatomic) Textbook *text;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
