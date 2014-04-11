//
//  Authors.h
//  Library App
//
//  Created by fp on 4/11/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Author_Textbook;

@interface Authors : NSManagedObject

@property (nonatomic, retain) NSString * idd;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Author_Textbook *textbook;

@end
