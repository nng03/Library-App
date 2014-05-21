//
//  HoursVC.m
//  Library App
//
//  Created by Nicholas Ng on 1/27/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import "HoursVC.h"

@implementation HoursVC

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
    self.title = @"Library Hours";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self checkIfInternet])
    {
        [self LoadCalendarData];
    } else
    {
        
    }
    self.tableView.rowHeight = 55;
}

- (BOOL)checkIfInternet
{
    NSURL *url = [[NSURL alloc] initWithString:@"http://www.google.com"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (data)
    {
        return true;
    } else
    {
        return false;
    }
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
    return [_calendarArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    GoogleCal *eventLcl = (GoogleCal *)[_calendarArr objectAtIndex:[indexPath row]];
    cell.textLabel.text = eventLcl.day;
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:16]];
    cell.detailTextLabel.text = eventLcl.date;
    UILabel *sideLabel = [[UILabel alloc] init];
    sideLabel.text = eventLcl.timeRange;
    sideLabel.frame = CGRectMake(240.0, 0.0, 100, 38);
    sideLabel.font = [UIFont systemFontOfSize:12];
    [cell addSubview:sideLabel];
    return cell;
}

- (void)LoadCalendarData
{
    dispatch_sync(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: @"https://www.google.com/calendar/feeds/9var82lp3jhu0eeu5cqthc2bd8%40group.calendar.google.com/public/basic?alt=jsonc&orderby=starttime&max-results=7&singleevents=true&sortorder=ascending&futureevents=true"]];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

+ (NSString *)convertDate:(NSString *)date
{
    NSArray *days = [date componentsSeparatedByString:@"<"];
    NSString *day = [days firstObject];
    days = [day componentsSeparatedByString:@":"];
    day = [days lastObject];
    NSArray *temp = [day componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *realDate = [[temp[2] stringByAppendingString:[[@" " stringByAppendingString:temp[3]] stringByAppendingString:@" "]] stringByAppendingString:temp[4]];
    return realDate;
}

+ (NSString *)convertDay:(NSString *)day
{
    NSArray *days = [day componentsSeparatedByString:@"<"];
    day = [days firstObject];
    days = [day componentsSeparatedByString:@":"];
    day = [days lastObject];
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    NSArray *dayOfWeek = [day componentsSeparatedByCharactersInSet:set];
    NSString *whatDayIsIt = dayOfWeek[1];
    dayOfWeek = [whatDayIsIt componentsSeparatedByCharactersInSet:set];
    whatDayIsIt = dayOfWeek[0];
    if ([whatDayIsIt isEqualToString:@"Sun"] || ([whatDayIsIt isEqualToString:@"Mon" ]) || ([whatDayIsIt isEqualToString:@"Fri"]))
    {
        whatDayIsIt = [whatDayIsIt stringByAppendingString:@"day"];
    }
    else if ([whatDayIsIt isEqualToString:@"Wed"])
    {
        whatDayIsIt = [whatDayIsIt stringByAppendingString:@"nesday"];
    }
    else if ([whatDayIsIt isEqualToString:@"Sat"])
    {
        whatDayIsIt = [whatDayIsIt stringByAppendingString:@"urday"];
    }
    else if ([whatDayIsIt isEqualToString:@"Thu"])
    {
        whatDayIsIt = [whatDayIsIt stringByAppendingString:@"rsday"];
    } else
    {
        whatDayIsIt = [whatDayIsIt stringByAppendingString:@"sday"];
    }
    return whatDayIsIt;
}

- (void)fetchedData:(NSData *)responseData {
    _calendarArr = [[NSMutableArray alloc] init];
    
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    NSDictionary *days = [json objectForKey:@"data"]; //2d
    NSArray *items = [days objectForKey:@"items"];
    NSInteger counter = 0;
    for (NSDictionary *event in items)
    {
        GoogleCal *cal = [[GoogleCal alloc] init];
        if (counter == 0)
        {
            cal.day = @"Today";
        }
        else if (counter == 1)
        {
            cal.day = @"Tomorrow";
        }
        cal.timeRange = [event objectForKey:@"title"];
        NSString *day = [HoursVC convertDay:[event objectForKey:@"details"]];
        if ([cal.day isEqualToString:@"Today"] || ([cal.day isEqualToString:@"Tomorrow"])) {}
        else
        {
            cal.day = day;
        }
        NSString *realDate = [HoursVC convertDate:[event objectForKey:@"details"]];
        cal.date = realDate;
        [_calendarArr addObject:cal];
        counter++;
    }
}

@end
