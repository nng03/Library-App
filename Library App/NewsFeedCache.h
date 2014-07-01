//
//  NewsFeedCache.h
//  Library App
//
//  Created by fp on 6/18/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NewsFeedCache : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * timeStamp;
@property (nonatomic, retain) NSString * newsBody;

@end
