//
//  DetailedRSSVC.h
//  Library App
//
//  Created by Nicholas Ng on 2/5/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedItem.h"
#import "NSString+HTML.h"

@interface DetailedRSSVC : UITableViewController
{
	MWFeedItem *item;
	NSString *dateString, *summaryString;
}

@property (strong, nonatomic) MWFeedItem *item;
@property (strong, nonatomic) NSString *dateString, *summaryString;

@end
