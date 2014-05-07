//
//  DatabaseVC.m
//  Library App
//
//  Created by fp on 4/18/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import "DatabaseVC.h"
#import "DatabaseResource.h"

@interface DatabaseVC ()

@property (strong, nonatomic) NSMutableArray *indexLabels;
@property (strong, nonatomic) NSMutableArray *links;
@property (strong, nonatomic) NSMutableArray *databases;

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
    self.databases = [[NSMutableArray alloc] init];
    self.title = @"Frequently Asked Questions";
    self.links = [[NSMutableArray alloc] init];
    [self.links addObject:@"Do I have acces to NYU's Bobst Library?"];
    [self.links addObject:@"How do I access online resources off campus?"];
    [self.links addObject:@"Now do I log in to BobCat?"];
    [self.links addObject:@"What if the book I want to borrow is not on the shelf?"];
    self.indexLabels = [[NSMutableArray alloc] init];
    self.indexLabels = [self getFirstLetters:self.links];
    [self loadDbResources];
    for (DatabaseResource *temp in self.databases)
    {
        NSLog(@"%@", temp.URL);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)loadDbResources
{
    dispatch_sync(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: @"http://api.researcher.poly.edu/dbresources"]];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)responseData
{
    NSError *error;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&error];
    
    for (NSDictionary *temp in json)
    {
        DatabaseResource *dbr = [[DatabaseResource alloc] init];
        dbr.URL = [temp objectForKey:@"url"];
        dbr.title = [temp objectForKey:@"title"];
        dbr.description = [temp objectForKey:@"description"];
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        dbr.hasApp = [[f numberFromString:[temp objectForKey:@"hasApp"]] boolValue];
        dbr.hasFullText = [[f numberFromString:[temp objectForKey:@"hasFullText"]] boolValue];
        dbr.loginOffCampus = [[f numberFromString:[temp objectForKey:@"loginOffCampus"]] boolValue];
        [self.databases addObject:dbr];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.indexLabels objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = @"Do I have acces to NYU's Bobst Library?";
            cell.detailTextLabel.text = @"287 Views | 67+ 66- | Last updated on March 14, 2014";
            break;
        case 1:
            cell.textLabel.text = @"How do I access online resources off campus?";
            cell.detailTextLabel.text = @"337 Views | 58+ 73- | Last updated on Nov. 20, 2013";
            break;
        case 2:
            cell.textLabel.text = @"Now do I log in to BobCat?";
            cell.detailTextLabel.text = @"269 Views | 61+ 80- | Last updated on March 14, 2014";
            break;
        case 3:
            cell.textLabel.text = @"What if the book I want to borrow is not on the shelf?";
            cell.detailTextLabel.text = @"270 Views | 52+ 70- | Last updated on Dec 17, 2012";
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < [self.databases count]; ++i)
    {
        if (indexPath.row == i)
        {
            DatabaseResource *temp = [self.databases objectAtIndex:i];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:temp.URL]];
        }
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *temp = [NSMutableArray array];
    return temp;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    for (int i = 0; i < [self.indexLabels count]; ++i)
    {
        NSString *position = [[self.indexLabels objectAtIndex:i] substringToIndex:1];
        if ([position isEqualToString:title])
        {
            return i;
        }
    }
    return 0;
}

- (NSMutableArray *)getFirstLetters:(NSArray *)array
{
    NSMutableArray *returnValue = [NSMutableArray array];
    NSMutableSet *set = [NSMutableSet set];
    for (NSString *string in array)
    {
        NSString *temp = [string substringToIndex:1];
        if (![set containsObject:temp])
        {
            [set addObject:temp];
            [returnValue addObject:temp];
        }
    }
    [returnValue sortUsingSelector:@selector(caseInsensitiveCompare:)];
    return returnValue;
}

@end
