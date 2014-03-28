//
//  Textbook.h
//  Library App
//
//  Created by fp on 3/7/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Author_Textbook, Course_Textbook;

@interface Textbook : NSManagedObject

@property (nonatomic, retain) NSString * cover_image;
@property (nonatomic, retain) NSNumber * idd;
@property (nonatomic, retain) NSNumber * isbn;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Course_Textbook *course;
@property (nonatomic, retain) Author_Textbook *author;

@end
