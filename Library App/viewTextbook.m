//
//  viewTextbook.m
//  Library App
//
//  Created by fp on 3/28/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import "viewTextbook.h"
#import "TextbookC.h"
#import "AppDelegate.h"
#import "YOSSocial.h"

@implementation viewTextbook

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.text.title;
    [self loadTextbookImage];
}

- (void)loadTextbookImage
{
    dispatch_sync(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:[self queryURLForTextbook]]];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)fetchedData
{
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:fetchedData options:kNilOptions error:nil];
    NSDictionary *dict2 = [dict valueForKeyPath:@"query"];
    NSDictionary *dict3 = [dict2 valueForKeyPath:@"results"];
    NSDictionary *dict4 = [dict3 valueForKeyPath:@"json"];
    NSDictionary *dict5 = [dict4 valueForKeyPath:@"items"];
    NSDictionary *dict6 = [dict5 valueForKeyPath:@"volumeInfo"];
    NSDictionary *dict7 = [dict6 valueForKeyPath:@"imageLinks"];
    
}

- (NSString *)queryURLForTextbook
{
    NSString *queryPart1 = @"http://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20google.books%20WHERE%20q%3D%22";
    NSString *queryPart2 = @"%22%20AND%20maxResults%3D1&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=";
    NSString *result = queryPart1;
    NSString *isbn = [self.text.isbn stringValue];
    result = [result stringByAppendingString:isbn];
    result = [result stringByAppendingString:queryPart2];
    return result;
}

@end
