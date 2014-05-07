//
//  DatabaseResource.h
//  Library App
//
//  Created by fp on 5/6/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseResource : NSObject

@property (strong, nonatomic) NSString *URL;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (nonatomic) BOOL hasApp;
@property (nonatomic) BOOL hasFullText;
@property (nonatomic) BOOL loginOffCampus;

@end
