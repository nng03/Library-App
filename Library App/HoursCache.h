//
//  HoursCache.h
//  Library App
//
//  Created by fp on 6/18/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HoursCache : NSManagedObject

@property (nonatomic, retain) NSString * todayHours;

@end
