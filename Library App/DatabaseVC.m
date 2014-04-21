//
//  DatabaseVC.m
//  Library App
//
//  Created by fp on 4/18/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import "DatabaseVC.h"

@interface DatabaseVC ()

@end

@implementation DatabaseVC

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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"How do I access online resources off campus?";
            cell.detailTextLabel.text = @"337 Views | 58+ 73- | Last updated on Nov. 20, 2013";
            break;
            
        case 1:
            cell.textLabel.text = @"Do I have acces to NYU's Bobst Library?";
            cell.detailTextLabel.text = @"287 Views | 67+ 66- | Last updated on March 14, 2014";
            break;
        case 2:
            cell.textLabel.text = @"What if the book I want to borrow is not on the shelf?";
            cell.detailTextLabel.text = @"270 Views | 52+ 70- | Last updated on Dec 17, 2012";
            break;
        case 3:
            cell.textLabel.text = @"How do I log in to BobCat?";
            cell.detailTextLabel.text = @"269 Views | 61+ 80- | Last updated on March 14, 2014";
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
    }
}

@end
