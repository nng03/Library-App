//
//  CreateTextbookVC.m
//  Library App
//
//  Created by fp on 3/14/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import "CreateTextbookVC.h"
#import "AppDelegate.h"

@interface CreateTextbookVC ()

@property (nonatomic) BOOL isBeingEdited;

@end

@implementation CreateTextbookVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add Textbook";
    self.textbookNameTextField.delegate = self;
    self.isbnNumberTextField.delegate = self;
    self.authorNameTextField.delegate = self;
    self.courseCodeTextField.delegate = self;
    self.courseNameTextField.delegate = self;
//    [self.tableView setContentInset:UIEdgeInsetsMake(25, 0, 0, 0)];
//    [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(25, 0, 0, 0)];
}

- (IBAction)done:(id)sender
{
    if (([self.textbookNameTextField.text length] > 0 &&
          [self.authorNameTextField.text length] > 0 &&
          [self.isbnNumberTextField.text length] > 0 &&
          [self.courseCodeTextField.text length] > 0 &&
          [self.courseNameTextField.text length] > 0))
    {
        Textbook *text = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
                                                       inManagedObjectContext:self.managedObjectContext];
        Authors *author = [NSEntityDescription insertNewObjectForEntityForName:@"Authors"
                                                        inManagedObjectContext:self.managedObjectContext];
        Courses *course = [NSEntityDescription insertNewObjectForEntityForName:@"Courses"
                                                        inManagedObjectContext:self.managedObjectContext];
        Author_Textbook *author_book = [NSEntityDescription insertNewObjectForEntityForName:@"Author_Textbook"
                                                                     inManagedObjectContext:self.managedObjectContext];
        Course_Textbook *course_book = [NSEntityDescription insertNewObjectForEntityForName:@"Course_Textbook"
                                                                     inManagedObjectContext:self.managedObjectContext];
        text.title = self.textbookNameTextField.text;
        text.isbn = self.isbnNumberTextField.text;
        text.course = course_book;
        text.author = author_book;
        text.idd = [[NSNumber alloc] initWithInt:1];
        text.cover_image = @"hi";
        author.name = self.authorNameTextField.text;
        author.textbook = author_book;
        course.course_code = self.courseCodeTextField.text;
        course.course_name = self.courseNameTextField.text;
        course.textbook = course_book;
        author_book.textbook = text;
        author_book.author = author;
        course_book.textbook = text;
        course_book.course = course;
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        [self.delegate createTextbookVC:self didAddTextbook:text];
    } else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[self emptyStrings] message:[self returnWhichEmptyStrings] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
}

- (NSString *)emptyStrings
{
    int counter = 0;
    if (!([self.textbookNameTextField.text length] > 0))
    {
        ++counter;
    }
    if (!([self.isbnNumberTextField.text length] > 0))
    {
        ++counter;
    }
    if (!([self.authorNameTextField.text length] > 0))
    {
        ++counter;
    }
    if (!([self.courseNameTextField.text length] > 0))
    {
        ++counter;
    }
    if (!([self.courseCodeTextField.text length] > 0))
    {
        ++counter;
    }
    if (counter > 1)
    {
        return @"Empty Strings!";
    } else
    {
        return @"Empty String!";
    }
}

- (NSString *)returnWhichEmptyStrings
{
    NSMutableString *string = [[NSMutableString alloc] init];
    [string appendString:@"The following fields are empty:\r"];
    if (!([self.textbookNameTextField.text length] > 0))
    {
        [string appendString:@"Textbook Name\r"];
    }
    if (!([self.isbnNumberTextField.text length] > 0))
    {
        [string appendString:@"ISBN\r"];
    }
    if (!([self.authorNameTextField.text length] > 0))
    {
        [string appendString:@"Author Name\r"];
    }
    if (!([self.courseNameTextField.text length] > 0))
    {
        [string appendString:@"Course Name\r"];
    }
    if (!([self.courseCodeTextField.text length] > 0))
    {
        [string appendString:@"Course Code\r"];
    }
    NSString *toBeReturned = [[NSString alloc] initWithString:string];
    return toBeReturned;
}

- (IBAction)cancel:(id)sender
{
    [self.delegate createTextbookVCDidCancel:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [self.textbookNameTextField becomeFirstResponder];
    }
    else if (indexPath.section == 1)
    {
        [self.isbnNumberTextField becomeFirstResponder];
    }
    else if (indexPath.section == 2)
    {
        [self.authorNameTextField becomeFirstResponder];
    }
    else if (indexPath.section == 3)
    {
        [self.courseNameTextField becomeFirstResponder];
    } else
    {
        [self.courseCodeTextField becomeFirstResponder];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ((textView == self.courseCodeTextField.textInputView) || (textView == self.courseNameTextField.textInputView))
    {
        self.isBeingEdited = YES;
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.isbnNumberTextField)
    {
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789-"];
        set = [set invertedSet];
        NSRange range = [textField.text rangeOfCharacterFromSet:set];
        if (range.location != NSNotFound)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid ISBN" message:@"Please type in a valid ISBN" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            self.isbnNumberTextField.text = @"";
        }
        else if (self.isbnNumberTextField.text.length != 10)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid ISBN" message:@"Please type in a valid ISBN" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            self.isbnNumberTextField.text = @"";
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textbookNameTextField endEditing:YES];
    [self.isbnNumberTextField endEditing:YES];
    [self.courseCodeTextField endEditing:YES];
    [self.courseNameTextField endEditing:YES];
    [self.authorNameTextField endEditing:YES];
    self.isBeingEdited = NO;
    [super touchesBegan:touches withEvent:event];
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
