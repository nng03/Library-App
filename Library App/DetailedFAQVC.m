//
//  DetailedFAQVC.m
//  Library App
//
//  Created by fp on 5/8/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import "DetailedFAQVC.h"

@interface DetailedFAQVC ()

@property (weak, nonatomic) IBOutlet UITextView *faqAnswer;

@end

@implementation DetailedFAQVC

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
    self.title = self.faq.title;
    self.faqAnswer.text = self.faq.description;
    self.faqAnswer.editable = NO;
    self.faqAnswer.textAlignment = NSTextAlignmentCenter;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
