//
//  FAQVCc.m
//  Library App
//
//  Created by fp on 5/29/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import "FAQVCc.h"
#import "FAQ.h"
#import "DetailedFAQVC.h"

@interface FAQVCc ()

@property (strong, nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) FAQ *currentFaq;

@end

@implementation FAQVCc

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
    self.title = @"Frequently Asked Questions";
    self.searchResults = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
//    [self sendSearchToServer:searchString];
    [self.tableView reloadData];
    return YES;
}

- (void)sendSearchToServer:(NSString *)searchText
{
    NSString *searchQuery = searchText;
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
    NSError *error;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:self.responseData
                                                    options:kNilOptions
                                                      error:&error];
    for (NSDictionary *dict in json)
    {
        FAQ *faq = [[FAQ alloc] init];
        faq.title = [dict objectForKey:@"title"];
        faq.description = [dict objectForKey:@"description"];
        [self.searchResults addObject:faq];
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if ([searchText hasSuffix:@"\r"])
    {
        [self sendSearchToServer:searchText];
        [self.tableView reloadData];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self sendSearchToServer:searchBar.text];
    [self.tableView reloadData];
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
    return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        FAQ *faq = [self.searchResults objectAtIndex:indexPath.row];
        cell.textLabel.text = faq.title;
    } else
    {
        FAQ *faq = [self.searchResults objectAtIndex:indexPath.row];
        cell.textLabel.text = faq.title;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    self.currentFaq = [self.searchResults objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detailedfaq" sender:cell];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailedfaq"])
    {
        NSIndexPath *indexPath;
        FAQ *faq;
        if (self.searchDisplayController.active)
        {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            faq = [self.searchResults objectAtIndex:indexPath.row];
        } else
        {
            indexPath = [self.tableView indexPathForSelectedRow];
            faq = [self.searchResults objectAtIndex:indexPath.row];
        }
        DetailedFAQVC *dfaq = segue.destinationViewController;
        dfaq.faq = faq;
    }
}

@end
