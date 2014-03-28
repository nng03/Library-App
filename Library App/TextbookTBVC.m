////
////  TextbookTBVC.m
////  Library App
////
////  Created by fp on 2/28/14.
////  Copyright (c) 2014 Nick. All rights reserved.
////
//
//#import "TextbookTBVC.h"
//#import "Textbook.h"
//
//@interface TextbookTBVC ()
//
//@end
//
//@implementation TextbookTBVC
//
//- (void)viewDidLoad
//{
//    
//	// Do any additional setup after loading the view.
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [self.textbooks count];
//}
//
////-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
////{
////    Textbook *text = [self.textbooks objectAtIndex:indexPath.row];
////    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:text.name message:[NSString stringWithFormat:@"Class: %@\r Subject: %@", text.class0, text.subject] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
////    [alert show];
////    return;
////}
//
////- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
////{
////    static NSString *CellIdentifier = @"cell";
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
////    Textbook *text = [self.textbooks objectAtIndex:indexPath.row];
////    cell.textLabel.text = text.name;
////    return cell;
////}
//
//@end
