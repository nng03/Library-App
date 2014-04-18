//
//  TextbookC.m
//  Library App
//
//  Created by fp on 3/7/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import "TextbookC.h"
#import "AppDelegate.h"
#import "Textbook.h"
#import "Author_Textbook.h"
#import "Course_Textbook.h"
#import "Courses.h"
#import "Authors.h"
#import "CreateTextbookVC.h"
#import "viewTextbook.h"

@interface TextbookC ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSMutableArray *textbooks;
@property (strong, nonatomic) NSMutableArray *differentClasses;
@property (strong, nonatomic) NSMutableArray *booksForClasses;
@property (strong, nonatomic) Textbook *currentBook;

@end

@implementation TextbookC

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
    self.title = @"Textbooks";
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    self.textbooks = [appDelegate getAllTextbooks];
    self.differentClasses = [self removeDuplicatesFromArray:[appDelegate getAllCourses]];
    self.booksForClasses = [self fillBooksForClasses];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [self.textbooks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Textbook *text = [self.textbooks objectAtIndex:indexPath.row];
    cell.textLabel.text = text.title;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    editingStyle = UITableViewCellEditingStyleDelete;
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSString *entityDescription = @"Textbook";
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:_managedObjectContext];
        [fetchRequest setEntity:entity];
        NSError *error;
        NSArray *items = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
        for (NSManagedObject *managedObject in items)
        {
            Textbook *text = [self.textbooks objectAtIndex:indexPath.row];
            if (managedObject == text)
            {
                [_managedObjectContext deleteObject:text.course.course];
                [_managedObjectContext deleteObject:text.author.author];
                [_managedObjectContext deleteObject:text.course];
                [_managedObjectContext deleteObject:text.author];
                [_managedObjectContext deleteObject:text];
                NSLog(@"%@", [NSString stringWithFormat:@"deleted"]);
            }
            if (![_managedObjectContext save:&error])
            {
                NSLog(@"Error deleting %@ - error:%@", entityDescription, error);
            }
        }
    }
    [self.textbooks removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    self.currentBook = [self.textbooks objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"viewbook" sender:cell];
}

- (void)prepareViewTextbookVC:(viewTextbook *)vc forText:(Textbook *)text
{
    vc.text = text;
    vc.managedObjectContext = self.managedObjectContext;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addtext"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        CreateTextbookVC *createTextbookVC = [navigationController viewControllers][0];
        createTextbookVC.delegate = self;
        createTextbookVC.managedObjectContext = self.managedObjectContext;
    }
    if ([segue.identifier isEqualToString:@"viewbook"])
    {
        [self prepareViewTextbookVC:segue.destinationViewController forText:self.currentBook];
    }
}

- (void)createTextbookVCDidCancel:(CreateTextbookVC *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createTextbookVC:(CreateTextbookVC *)controller didAddTextbook:(Textbook *)text
{
    [self.textbooks addObject:text];
    Courses *course = text.course.course;
    if (![self.differentClasses containsObject:course])
    {
        [self.differentClasses addObject:course];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.textbooks count] - 1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSMutableArray *)removeDuplicatesFromArray:(NSMutableArray *)array
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    NSMutableSet *set = [NSMutableSet set];
    for (Courses *course in array)
    {
        if (![set containsObject:course.course_name])
        {
            [set addObject:course.course_name];
            [temp addObject:course];
        }
    }
    return temp;
}

- (NSMutableArray *)fillBooksForClasses
{
    NSMutableArray *result = [NSMutableArray array];
    for (Courses *thing in self.differentClasses)
    {
        NSMutableArray *temp = [NSMutableArray array];
        for (Textbook *text in self.textbooks)
        {
            if ([text.course.course.course_name isEqualToString:thing.course_name])
            {
                [temp addObject:text];
            }
        }
    }
    return result;
}

@end
