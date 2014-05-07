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

@end
