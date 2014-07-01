//
//  AppDelegate.h
//  Library App
//
//  Created by Nicholas Ng on 1/27/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSMutableArray *)getAllTextbooks;
- (NSMutableArray *)getAllAuthors;
- (NSMutableArray *)getAllCourses;
- (NSMutableArray *)getAllCourse_Books;
- (NSMutableArray *)getAllAuthor_Books;
- (NSMutableArray *)getAllHoursCache;
- (NSMutableArray *)getAllNewsFeedCache;

@end
