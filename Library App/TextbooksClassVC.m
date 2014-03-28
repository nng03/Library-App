////
////  TextbooksClassVC.m
////  Library App
////
////  Created by fp on 2/28/14.
////  Copyright (c) 2014 Nick. All rights reserved.
////
//
//#import "TextbooksClassVC.h"
//#import "Textbook.h"
//#import "TextbookTBVC.h"
//
//@interface TextbooksClassVC ()
//
//@property (nonatomic, strong) NSArray *classes;
//
//@end
//
//@implementation TextbooksClassVC
//
//- (void)viewDidLoad
//{
////    self.classes = [self returnClasses];
////    for (Textbook *text in self.fetchedBooks)
////    {
////        NSLog(@"%@", [NSString stringWithFormat:@"%@", text.name]);
////    }
//    // Uncomment the following line to preserve selection between presentations.
//    // self.clearsSelectionOnViewWillAppear = NO;
// 
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//}
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return [self.classes count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    cell.textLabel.text = [self.classes objectAtIndex:indexPath.row];
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    self.currentSubject = cell.textLabel.text;
//    [self performSegueWithIdentifier:@"actualbook" sender:cell];
//}
//
//- (void)prepareTextbookTBVC:(TextbookTBVC *)tbvc forString:(NSString *)subject forBooks:(NSArray *)textbooks
//{
//    tbvc.title = subject;
////    tbvc.textbooks = [[NSArray alloc] initWithArray:[self textbooksBySubject:subject textbooks:textbooks]];
//}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    [self prepareTextbookTBVC:segue.destinationViewController
//                    forString:self.currentSubject
//                     forBooks:self.fetchedBooks];
//}
//
////- (NSArray *)returnClasses
////{
////    NSMutableArray *newArray = [[NSMutableArray alloc] init];
////    for (Textbook *text in self.fetchedBooks)
////    {
////        [newArray addObject:[NSString stringWithString:text.class0]];
////    }
////    NSMutableSet *existingClasses = [NSMutableSet set];
////    NSMutableArray *classes = [NSMutableArray array];
////    for (NSString *string in newArray)
////    {
////        if (![existingClasses containsObject:string])
////        {
////            [existingClasses addObject:string];
////            [classes addObject:string];
////        }
////    }
////    return classes;
////}
//
////- (NSMutableArray *)textbooksBySubject:(NSString *)sort textbooks:(NSArray *)textbooks
////{
////    NSMutableArray *newArray = [[NSMutableArray alloc] init];
////    for (Textbook *text in textbooks)
////    {
////        if ([text.class0 isEqualToString:sort])
////        {
////            [newArray addObject:text];
////        }
////    }
////    return newArray;
////}
//
//@end
