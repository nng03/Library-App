//
//  FAQVC.m
//  Library App
//
//  Created by fp on 5/7/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import "FAQVC.h"
#import "FAQ.h"
#import "DetailedFAQVC.h"

@interface FAQVC ()

@property (strong, nonatomic) NSMutableArray *faqs;
@property (strong, nonatomic) NSMutableArray *indexLabels;
@property (strong, nonatomic) FAQ *currentFaq;

@end

@implementation FAQVC

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
    self.faqs = [[NSMutableArray alloc] init];
    [self loadFaqs];
    self.indexLabels = [[NSMutableArray alloc] init];
    self.indexLabels = [self getFirstLetters:self.faqs];
    self.currentFaq = [[FAQ alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)loadFaqs
{
    dispatch_sync(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: @"http://api.researcher.poly.edu/faqs"]];
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
        FAQ *faq = [[FAQ alloc] init];
        faq.title = [temp objectForKey:@"title"];
        faq.description = [temp objectForKey:@"description"];
        [self.faqs addObject:faq];
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
    for (FAQ *faq in self.faqs)
    {
        if ([[faq.title substringToIndex:1] isEqualToString:headerTitle])
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
    FAQ *faq = [self.faqs objectAtIndex:indexPath.row];
    cell.textLabel.text = faq.title;
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexLabels;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    self.currentFaq = [self.faqs objectAtIndex:indexPath.row];
    self.currentFaq.description = @"lakjsdflkajskldfjlkajsdfljalksdjflkajdlfkjaklsdjf";
    [self performSegueWithIdentifier:@"detailedfaq" sender:cell];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailedfaq"])
    {
        [self prepareDetailedFAQVC:segue.destinationViewController forFaq:self.currentFaq];
    }
}

- (void)prepareDetailedFAQVC:(DetailedFAQVC *)dfaqvc forFaq:(FAQ *)faq
{
    dfaqvc.faq = self.currentFaq;
}

- (NSMutableArray *)getFirstLetters:(NSArray *)array
{
    NSMutableSet *set = [NSMutableSet set];
    NSMutableArray *returnValue = [[NSMutableArray alloc] init];
    for (FAQ *temp in array)
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
