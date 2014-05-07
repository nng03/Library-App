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
    [self loadDbResources];
    self.indexLabels = [[NSMutableArray alloc] init];
    self.indexLabels = [self getFirstLetters:self.databases];
    for (NSString *string in self.indexLabels)
    {
        NSLog(@"%@", string);
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
    return [self.indexLabels count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *headerTitle = [self tableView:(self.tableView) titleForHeaderInSection:section];
    int counter = 0;
    for (DatabaseResource *dbr in self.databases)
    {
        if ([[dbr.title substringToIndex:1] isEqualToString:headerTitle])
        {
            ++counter;
        }
    }
    if (counter == 0)
    {
        return 1;
    } else
    {
        return counter;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.indexLabels objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    DatabaseResource *dbr = [self.databases objectAtIndex:indexPath.row];
    cell.textLabel.text = dbr.title;
    
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
    return [self getFirstLetters:self.databases];
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
    NSMutableSet *set = [NSMutableSet set];
    NSMutableArray *returnValue = [[NSMutableArray alloc] init];
    for (DatabaseResource *temp in array)
    {
        NSString *string = [temp.title substringToIndex:1];
        if (![set containsObject:string])
        {
            [set addObject:string];
            [returnValue addObject:string];
        }
    }
    [returnValue sortUsingSelector:@selector(caseInsensitiveCompare:)];
    return returnValue;
}

@end
