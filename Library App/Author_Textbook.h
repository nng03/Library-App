//
//  Author_Textbook.h
//  Library App
//
//  Created by fp on 3/7/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Authors, Textbook;

@interface Author_Textbook : NSManagedObject

@property (nonatomic, retain) NSNumber * author_id;
@property (nonatomic, retain) NSNumber * idd;
@property (nonatomic, retain) NSNumber * textbook_id;
@property (nonatomic, retain) Textbook *textbook;
@property (nonatomic, retain) Authors *author;

@end
