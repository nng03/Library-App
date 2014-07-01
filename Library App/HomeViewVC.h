//
//  HomeViewVC.h
//  Library App
//
//  Created by fp on 6/10/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"
#import "MWFeedInfo.h"
#import "NSString+HTML.h"

@interface HomeViewVC : UIViewController <MWFeedParserDelegate>
{
	MWFeedParser *feedParser;
	NSMutableArray *parsedItems;
	NSArray *itemsToDisplay;
	NSDateFormatter *formatter;
}

@property (strong ,nonatomic) NSArray *itemsToDisplay;

@end
