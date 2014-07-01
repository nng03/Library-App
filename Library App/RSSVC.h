//
//  RSSVC.h
//  Library App
//
//  Created by Nicholas Ng on 2/3/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"
#import "MWFeedInfo.h"
#import "NSString+HTML.h"
#import "DetailedRSSVC.h"

@interface RSSVC : UITableViewController <MWFeedParserDelegate>
{
	MWFeedParser *feedParser;
	NSMutableArray *parsedItems;
	NSArray *itemsToDisplay;
	NSDateFormatter *formatter;
}

@property (strong ,nonatomic) NSArray *itemsToDisplay;

@end