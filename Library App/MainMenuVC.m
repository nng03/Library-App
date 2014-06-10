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
#import "FAQ.h"

@interface MainMenuVC ()

@property (weak, nonatomic) IBOutlet UIButton *linkToCal;
@property (weak, nonatomic) IBOutlet UIButton *linkToNewsFeed;
@property (weak, nonatomic) IBOutlet UIButton *linkToFeedback;
@property (weak, nonatomic) IBOutlet UIButton *linkToTextbooks;
@property (weak, nonatomic) IBOutlet UIButton *linkToDatabases;
@property (weak, nonatomic) IBOutlet UIButton *linkToFAQs;
@property (strong, nonatomic) NSMutableData *responseData;

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
    [self testFunc];
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
    NSString *searchQuery = @"itaque ut";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.researcher.poly.edu/test"]];
    [request setHTTPMethod:@"POST"];
    NSString *temp = [NSString stringWithFormat:@"searchQuery=%@", searchQuery];
    NSData *postData = [NSData dataWithBytes:[temp UTF8String] length:[temp length]];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    [conn start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"response data - %@", [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding]);
    
}

@end