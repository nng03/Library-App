//
//  HoursVC.h
//  Library App
//
//  Created by Nicholas Ng on 1/27/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

#import <Foundation/NSJSONSerialization.h>
#import <UIKit/UIKit.h>
#import "GoogleCal.h"
#import <EventKit/EventKit.h>

@interface HoursVC : UITableViewController <UIActionSheetDelegate>

@property (strong, nonatomic) NSMutableArray *calendarArr;

- (void)LoadCalendarData;
+ (NSString *)convertDate:(NSString *)date;
+ (NSString *)convertDay:(NSString *)day;

@end
