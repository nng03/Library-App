//
//  Courses.h
//  Library App
//
//  Created by fp on 3/7/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course_Textbook;

@interface Courses : NSManagedObject

@property (nonatomic, retain) NSString * course_code;
@property (nonatomic, retain) NSString * course_name;
@property (nonatomic, retain) NSNumber * idd;
@property (nonatomic, retain) Course_Textbook *textbook;

@end
