//
//  FeedbackVC.m
//  Library App
//
//  Created by Nicholas Ng on 2/7/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import "FeedbackVC.h"

@interface FeedbackVC ()

@property (weak, nonatomic) IBOutlet UITextView *senderEmail;
@property (weak, nonatomic) IBOutlet UITextView *emailTextBody;
@property (nonatomic) BOOL isBeingEdited;

@end

@implementation FeedbackVC

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
    self.title = @"Library Feedback";
    [self.view addSubview:self.senderEmail];
    self.senderEmail.delegate = self;
    [self.view addSubview:self.emailTextBody];
    self.emailTextBody.delegate = self;
    self.senderEmail.text = @"Input your email here (optional)";
    self.senderEmail.textAlignment = NSTextAlignmentCenter;
    self.emailTextBody.text = @"Write your feedback here:";
    self.emailTextBody.textAlignment = NSTextAlignmentJustified;
    [self addInputAccessoryViewForTextView:self.emailTextBody];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)addInputAccessoryViewForTextView:(UITextView *)textView{
    
    //Create the toolbar for the inputAccessoryView
    UIToolbar* toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    [toolbar sizeToFit];
    toolbar.barStyle = UIBarStyleDefault;
    
    //Add the done button and set its target:action: to call the method returnTextView:
    toolbar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                     [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(returnBreakdown:)],
                     nil];
    
    //Set the inputAccessoryView
    [textView setInputAccessoryView:toolbar];
    
}

- (void)returnBreakdown:(UIButton *)sender{
    
    [self.emailTextBody resignFirstResponder];
    self.isBeingEdited = NO;
}

- (IBAction)sendFeedback:(id)sender {
    MCOSMTPSession *session = [[MCOSMTPSession alloc] init];
    session.hostname = @"smtp.gmail.com";
    session.port = 465;
    session.username = @"thehithere5@gmail.com";
    session.password = @"Nick is the man!";
    session.connectionType = MCOConnectionTypeTLS;
    MCOMessageBuilder *builder = [[MCOMessageBuilder alloc] init];
    MCOAddress *from = [MCOAddress addressWithDisplayName:@"Feedback"
                                                  mailbox:@"thehitthere5@gmail.com"];
    MCOAddress *to = [MCOAddress addressWithDisplayName:nil
                                                mailbox:@"nn733@nyu.edu"];
    [[builder header] setFrom:from];
    [[builder header] setTo:@[to]];
    [[builder header] setSubject:@"Feedback"];
    if ([self.senderEmail.text isEqualToString:@"Input your email here (optional)"])
    {
        [builder setHTMLBody:self.emailTextBody.text];
    } else
    {
        [builder setHTMLBody:[self.emailTextBody.text stringByAppendingString:[NSString stringWithFormat:@"\n From: %@", self.senderEmail.text]]];
        NSLog(@"%@", [NSString stringWithFormat:@"%@", self.emailTextBody.text]);
    }
    NSData *rfc822Data = [builder data];
    MCOSMTPSendOperation *sendOperation = [session sendOperationWithData:rfc822Data];
    [sendOperation start:^(NSError *error) {
        if(error) {
            NSLog(@"Error sending email: %@", error);
        } else {
            NSLog(@"Successfully sent email!");
        }
    }];
    self.senderEmail.text = @"Input your email here (optional)";
    self.emailTextBody.text = @"Write your feedback here:";
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:[NSString stringWithFormat:@"Input your email here (optional)"]] || [textView.text isEqualToString:[NSString stringWithFormat:@"Write your feedback here:"]]) {
        textView.text = @"";
    }
    textView.textAlignment = NSTextAlignmentJustified;
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == self.emailTextBody)
    {
        self.isBeingEdited = YES;
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    if([[textView.text stringByTrimmingCharactersInSet:set] length] == 0) {
        if(textView == self.senderEmail) {
            textView.text = [NSString stringWithFormat:@"Input your email here (optional)"];
            textView.textAlignment = NSTextAlignmentJustified;
        }
        else if(textView == self.emailTextBody) {
            textView.text = [NSString stringWithFormat:@"Write your feedback here:"];
        }
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == self.senderEmail)
    {
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        if ([emailTest evaluateWithObject:self.senderEmail.text] == NO) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Not Valid!" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.senderEmail endEditing:YES];
    [self.emailTextBody endEditing:YES];
    self.isBeingEdited = NO;
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text hasSuffix:@"\n"]) {
        [self.senderEmail endEditing:YES];
        if (self.isBeingEdited)
        {
            return YES;
        }
        return NO;
    }
    return YES;
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.isBeingEdited)
    {
        if (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
        else if (self.view.frame.origin.y < 0)
        {
            [self setViewMovedUp:NO];
        }
    }
}

-(void)keyboardWillHide {
    if (self.isBeingEdited)
    {
        if (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
        else if (self.view.frame.origin.y < 0)
        {
            [self setViewMovedUp:NO];
        }
    }
}

#define kOFFSET_FOR_KEYBOARD 80.0

-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

@end
