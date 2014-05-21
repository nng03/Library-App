//
//  MainMenuVC.m
//  Library App
//
//  Created by fp on 2/21/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import "MainMenuVC.h"
#import "HoursVC.h"
#import "RSSVC.h"
#import "FeedbackVC.h"

@interface MainMenuVC ()
@property (weak, nonatomic) IBOutlet UIButton *linkToCal;
@property (weak, nonatomic) IBOutlet UIButton *linkToNewsFeed;
@property (weak, nonatomic) IBOutlet UIButton *linkToFeedback;
@property (weak, nonatomic) IBOutlet UIButton *linkToTextbooks;
@property (weak, nonatomic) IBOutlet UIButton *linkToDatabases;
@property (weak, nonatomic) IBOutlet UIButton *linkToFAQs;

@end

@implementation MainMenuVC

// Prelimary menu to help with testing

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
    self.title = @"Bern Dibner Library";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:@"http://api.researcher.poly.edu/test"]];
    [request setHTTPMethod:@"post"];
    [request setValue:@"text/xml"
   forHTTPHeaderField:@"Content-type"];
    NSString *xmlString = @"<data><item>Item 1</item><item>Item 2</item></data>";
    [request setValue:[NSString stringWithFormat:@"%d",
                       [xmlString length]]
   forHTTPHeaderField:@"Content-length"];
    [request setHTTPBody:[xmlString
                          dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    if(conn)
    {
        NSLog(@"%@", @"Connection Successful");
    }
    else
    {
        NSLog(@"%@", @"Connection could not be made");
    }
    NSLog(@"%@", xmlString);
//    [self testFunc];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)linkToCal:(id)sender
{
    [self performSegueWithIdentifier:@"calendarsegue" sender:sender];
}

- (IBAction)linkToNewsFeed:(id)sender
{
    [self performSegueWithIdentifier:@"newsfeedsegue" sender:sender];
}

- (IBAction)linkToFeedback:(id)sender
{
    [self performSegueWithIdentifier:@"feedbacksegue" sender:sender];
}

- (IBAction)linkToTextbooks:(id)sender
{
    [self performSegueWithIdentifier:@"textbooksegue" sender:sender];
}

- (IBAction)linkToDatabases:(id)sender
{
    [self performSegueWithIdentifier:@"showdb" sender:sender];
}

- (IBAction)linkToFAQs:(id)sender
{
    [self performSegueWithIdentifier:@"showfaqs" sender:sender];
}

- (void)testFunc
{
//    NSURL *url = [NSURL URLWithString:@"http://api.researcher.poly.edu/test"];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"ret=%@", ret);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:@"http://api.researcher.poly.edu/test"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml"
   forHTTPHeaderField:@"Content-type"];
    NSString *xmlString = @"<data><item>Item 1</item><item>Item 2</item></data>";
    [request setValue:[NSString stringWithFormat:@"%d",
                       [xmlString length]]
    forHTTPHeaderField:@"Content-length"];
    [request setHTTPBody:[xmlString 
                          dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    if(conn)
    {
        NSLog(@"%@", @"Connection Successful");
    }
    else
    {
        NSLog(@"%@", @"Connection could not be made");
    }
}

@end
