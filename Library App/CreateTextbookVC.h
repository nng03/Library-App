//
//  CreateTextbookVC.h
//  Library App
//
//  Created by fp on 3/14/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Textbook.h"
#import "Authors.h"
#import "Courses.h"
#import "Course_Textbook.h"
#import "Author_Textbook.h"

@class CreateTextbookVC;

@protocol CreateTextbookVCDelegate <NSObject>

- (void)createTextbookVCDidCancel:(CreateTextbookVC *)controller;
- (void)createTextbookVC:(CreateTextbookVC *)controller didAddTextbook:(Textbook *)text;

@end

@interface CreateTextbookVC : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) id <CreateTextbookVCDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *textbookNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *isbnNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *courseNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *courseCodeTextField;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
