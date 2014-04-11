//
//  Course_Textbook.h
//  Library App
//
//  Created by fp on 4/11/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Courses, Textbook;

@interface Course_Textbook : NSManagedObject

@property (nonatomic, retain) NSNumber * class_id;
@property (nonatomic, retain) NSNumber * idd;
@property (nonatomic, retain) NSNumber * textbook_id;
@property (nonatomic, retain) Courses *course;
@property (nonatomic, retain) Textbook *textbook;

@end
