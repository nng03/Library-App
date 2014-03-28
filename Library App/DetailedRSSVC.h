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

@property (nonatomic, strong) MWFeedItem *item;
@property (nonatomic, strong) NSString *dateString, *summaryString;

@end
