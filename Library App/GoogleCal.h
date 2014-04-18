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

@property (strong, nonatomic) NSString *timeRange;
@property (strong, nonatomic) NSString *day;
@property (strong, nonatomic) NSString *date;

@end
