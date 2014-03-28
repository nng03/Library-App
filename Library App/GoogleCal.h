//
//  GoogleCal.h
//  Library App
//
//  Created by Nicholas Ng on 1/31/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoogleCal : NSObject

{
    NSString *timeRange;
    NSString *day;
    NSString *date;
}

@property (nonatomic, retain) NSString *timeRange;
@property (nonatomic, retain) NSString *day;
@property (nonatomic, retain) NSString *date;

@end
