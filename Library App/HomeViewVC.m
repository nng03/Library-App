//
//  HomeViewVC.m
//  Library App
//
//  Created by fp on 6/10/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import "HomeViewVC.h"
#import "GoogleCal.h"
#import "HoursCache.h"
#import "NewsFeedCache.h"
#import "AppDelegate.h"
#import "Reachability.h"

@interface HomeViewVC ()
@property (weak, nonatomic) IBOutlet UIButton *linkToCall;
@property (weak, nonatomic) IBOutlet UIImageView *movingImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIButton *cancelMenu;
@property (weak, nonatomic) IBOutlet UIButton *linkToHours;
@property (weak, nonatomic) IBOutlet UIImageView *gradientView;
@property (weak, nonatomic) IBOutlet UILabel *todayHours;
@property (weak, nonatomic) IBOutlet UILabel *currentDay;
@property (weak, nonatomic) IBOutlet UILabel *currentDate;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsTimeStamp;
@property (weak, nonatomic) IBOutlet UITextView *news;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSMutableArray *hoursCache;
@property (strong, nonatomic) NSMutableArray *newsFeedCache;
@property (nonatomic) BOOL movedUp;
@property (nonatomic) BOOL menuButtonPressed;
@property (nonatomic) BOOL shouldCache;
@property (strong, nonatomic) Reachability *internetReachableFoo;

@end

@implementation HomeViewVC

@synthesize itemsToDisplay, internetReachableFoo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadNewsAndCalendar
{
    __weak typeof(self) weakSelf = self;
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf loadCalendarData];
            [weakSelf loadNewsFeed];
        });
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf loadCalendarNoInternet];
            [weakSelf loadNewsFeedNoInternet];
        });
    };
    
    [internetReachableFoo startNotifier];
}

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Cache Setup
    
    self.hoursCache = [[NSMutableArray alloc] init];
    self.newsFeedCache = [[NSMutableArray alloc] init];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    self.hoursCache = [appDelegate getAllHoursCache];
    self.newsFeedCache = [appDelegate getAllNewsFeedCache];
    
    // Current Date
    
    NSDate *now = [[NSDate alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE"];
    NSString* currentDayName = [dateFormat stringFromDate:now];
    [dateFormat setDateFormat:@"MMMM dd, yyyy"];
    NSString* currentDayDate = [dateFormat stringFromDate:now];
    UIFont *currentDayNameFont = [UIFont fontWithName:@"Helvetica-Neue-Condensed-Black" size:12.0];
    UIFont *currentDayDateFont = [UIFont fontWithName:@"Helvetica-Neue-Condensed-Bold" size:24.0];
    UIColor *dateColor = [UIColor whiteColor];
    UIColor *currentDateColor = UIColorFromRGB(0xcca6da);
    NSDictionary *dayAttributes = [NSDictionary dictionaryWithObjectsAndKeys:currentDayDateFont, NSFontAttributeName, dateColor, NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *day = [[NSMutableAttributedString alloc] initWithString:currentDayName attributes:dayAttributes];
    [self.currentDay setAttributedText:day];
    NSDictionary *dateAttributes = [NSDictionary dictionaryWithObjectsAndKeys:currentDayNameFont, NSFontAttributeName, currentDateColor, NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *date = [[NSMutableAttributedString alloc] initWithString:currentDayDate attributes:dateAttributes];
    [self.currentDate setAttributedText:date];
    
    // Parallax Effects
    
    [self.movingImage addSubview:self.gradientView];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.hidden = YES;
    self.menuButtonPressed = NO;
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-50);
    horizontalMotionEffect.maximumRelativeValue = @(50);
    UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-25);
    verticalMotionEffect.maximumRelativeValue = @(25);
    [self.movingImage addMotionEffect:horizontalMotionEffect];
    [self.movingImage addMotionEffect:verticalMotionEffect];
    
    // Swipe and Touch Gestures
    
    self.movedUp = NO;
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedUpGesture:)];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.scrollView addGestureRecognizer:swipeUp];
    UISwipeGestureRecognizer *swipedDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedDownGesture:)];
    [swipedDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.scrollView addGestureRecognizer:swipedDown];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self.scrollView addGestureRecognizer:singleTap];
    UISwipeGestureRecognizer *swipeUpMenu = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenu:)];
    [swipeUpMenu setDirection:UISwipeGestureRecognizerDirectionUp];
    UISwipeGestureRecognizer *swipeDownMenu = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenu:)];
    [swipeDownMenu setDirection:UISwipeGestureRecognizerDirectionDown];
    UISwipeGestureRecognizer *swipeRightMenu = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenu:)];
    [swipeRightMenu setDirection:UISwipeGestureRecognizerDirectionRight];
    UISwipeGestureRecognizer *swipeLeftMenu = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenu:)];
    [swipeLeftMenu setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.menuView addGestureRecognizer:swipeUpMenu];
    [self.menuView addGestureRecognizer:swipeDownMenu];
    [self.menuView addGestureRecognizer:swipeLeftMenu];
    [self.menuView addGestureRecognizer:swipeRightMenu];
    
    // Load Calendar and News Data
    
    [self loadNewsAndCalendar];

}

- (void)loadCalendarData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *hoursData = [NSData dataWithContentsOfURL: [NSURL URLWithString: @"https://www.google.com/calendar/feeds/9var82lp3jhu0eeu5cqthc2bd8%40group.calendar.google.com/public/basic?alt=jsonc&orderby=starttime&max-results=7&singleevents=true&sortorder=ascending&futureevents=true"]];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:hoursData waitUntilDone:YES];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
        });
    });
}

- (void)feedParserDidStart:(MWFeedParser *)parser
{
	NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info
{
	NSLog(@"Parsed Feed Info: “%@”", info.title);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item
{
    NSLog(@"Parsed Feed Item: “%@”", item.title);
	if (item) [parsedItems addObject:item];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser
{
    NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
    
    // Delete old news cache
    
    NSString *entityDescription = @"NewsFeedCache";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *items = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ([items count] != 0)
    {
        [_managedObjectContext deleteObject:[items firstObject]];
        if (![_managedObjectContext save:&error])
        {
            NSLog(@"Error deleting %@ - error:%@", entityDescription, error);
        }
    }
    
    // Set up labels
    
    MWFeedItem *item = [parsedItems firstObject];
    self.itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
						   [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date"
                                                                            ascending:NO]]];
    UIFont *newsTitleFont = [UIFont fontWithName:@"Helvetica-Nueu-Bold" size:15.0];
    UIColor *newsTitleColor = [UIColor blackColor];
    NSDictionary *newsTitleAttributes = [NSDictionary dictionaryWithObjectsAndKeys:newsTitleFont, NSFontAttributeName, newsTitleColor, NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *newsTitle = [[NSMutableAttributedString alloc] initWithString:item.title attributes:newsTitleAttributes];
    [self.newsTitle setAttributedText:newsTitle];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM d, y, h:ss a"];
    UIFont *newsTimeStampFont = [UIFont fontWithName:@"Helvetica-Neueu" size:10.0];
    UIColor *newsTimeStampColor = UIColorFromRGB(0x808080);
    NSDictionary *newsTimeStampAttributes = [NSDictionary dictionaryWithObjectsAndKeys:newsTimeStampFont, NSFontAttributeName, newsTimeStampColor, NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *newsTimeStamp = [[NSMutableAttributedString alloc] initWithString:[dateFormatter stringFromDate:item.date] attributes:newsTimeStampAttributes];
    [self.newsTimeStamp setAttributedText:newsTimeStamp];
    UIFont *newsFont = [UIFont fontWithName:@"Helvetica-Neueu" size:12.0];
    UIColor *newsColor = [UIColor blackColor];
    NSMutableParagraphStyle *newsParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    newsParagraphStyle.alignment = NSTextAlignmentLeft;
    newsParagraphStyle.minimumLineHeight = 15.0;
    NSDictionary *newsAttributes = [NSDictionary dictionaryWithObjectsAndKeys:newsFont, NSFontAttributeName, newsColor, NSForegroundColorAttributeName, newsParagraphStyle, NSParagraphStyleAttributeName, nil];
    NSMutableAttributedString *news = [[NSMutableAttributedString alloc] initWithString:[item.summary stringByConvertingHTMLToPlainText] attributes:newsAttributes];
    self.news.contentMode = UIViewContentModeTop;
    self.news.textAlignment = NSTextAlignmentLeft;
    [self.news setAttributedText:news];
    
    // Create new cache
    
    NewsFeedCache *cache = [NSEntityDescription insertNewObjectForEntityForName:@"NewsFeedCache"
                                                         inManagedObjectContext:self.managedObjectContext];
    cache.title = item.title;
    cache.timeStamp = [dateFormatter stringFromDate:item.date];
    cache.newsBody = [item.summary stringByConvertingHTMLToPlainText];
    NSError *error1;
    if (![self.managedObjectContext save:&error1]) {
        NSLog(@"Whoops, couldn't save: %@", [error1 localizedDescription]);
    }
    
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
	NSLog(@"Finished Parsing With Error: %@", error);
    if (parsedItems.count == 0) {}
    else {
        // Failed but some items parsed, so show and inform of error
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parsing Incomplete"
                                                        message:@"There was an error during the parsing of this feed. Not all of the feed items could parsed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)fetchedData:(NSData *)data
{
    // Delete Previous Cache
    
    NSString *entityDescription = @"HoursCache";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *items = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ([items count] != 0)
    {
        [_managedObjectContext deleteObject:[items firstObject]];
        if (![_managedObjectContext save:&error])
        {
            NSLog(@"Error deleting %@ - error:%@", entityDescription, error);
        }
    }
    
    // New Data
    
    NSError *jsonError;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                    options:kNilOptions
                                                      error:&jsonError];
    NSDictionary *temp = [json objectForKey:@"data"];
    NSArray *days = [temp objectForKey:@"items"];
    NSDictionary *temp2 = [days firstObject];
    NSString *hours = [temp2 objectForKey:@"title"];
    UIFont *todaysHoursFont = [UIFont fontWithName:@"Helvetica-Nueu-Condensed-Bold" size:24.0];
    UIColor *todaysHoursColor = [UIColor whiteColor];
    NSDictionary *todaysHoursAttributes = [NSDictionary dictionaryWithObjectsAndKeys:todaysHoursFont, NSFontAttributeName, todaysHoursColor, NSForegroundColorAttributeName, nil];
    if ([hours isEqualToString:@"9 am-8 pm"])
    {
        NSString *string = @"9AM - 8PM";
        NSMutableAttributedString *todaysHours = [[NSMutableAttributedString alloc] initWithString:string attributes:todaysHoursAttributes];
        [self.todayHours setAttributedText:todaysHours];
        HoursCache *hour = [NSEntityDescription insertNewObjectForEntityForName:@"HoursCache"
                                                         inManagedObjectContext:self.managedObjectContext];
        hour.todayHours = string;
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    } else if ([hours isEqualToString:@"noon-6pm"])
    {
        NSString *string = @"12PM - 6PM";
        NSMutableAttributedString *todaysHours = [[NSMutableAttributedString alloc] initWithString:string attributes:todaysHoursAttributes];
        [self.todayHours setAttributedText:todaysHours];
        HoursCache *hour = [NSEntityDescription insertNewObjectForEntityForName:@"HoursCache"
                                                         inManagedObjectContext:self.managedObjectContext];
        hour.todayHours = string;
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    } else if ([hours isEqualToString:@"CLOSED"])
    {
        NSString *string = @"CLOSED";
        NSMutableAttributedString *todaysHours = [[NSMutableAttributedString alloc] initWithString:string attributes:todaysHoursAttributes];
        [self.todayHours setAttributedText:todaysHours];
        HoursCache *hour = [NSEntityDescription insertNewObjectForEntityForName:@"HoursCache"
                                                         inManagedObjectContext:self.managedObjectContext];
        hour.todayHours = string;
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

- (void)loadNewsFeed
{
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    itemsToDisplay = [[NSArray alloc] init];
    parsedItems = [[NSMutableArray alloc] init];
    NSURL *feedURL = [NSURL URLWithString:@"http://library.poly.edu/news/feed"];
    feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull; // Parse feed info and all items
    feedParser.connectionType = ConnectionTypeAsynchronously;
    [feedParser parse];
}

- (void)loadCalendarNoInternet
{
    NSMutableArray *cache = self.hoursCache;
    HoursCache *string = [cache firstObject];
    UIFont *todaysHoursFont = [UIFont fontWithName:@"Helvetica-Nueu-Condensed-Bold" size:24.0];
    UIColor *todaysHoursColor = [UIColor whiteColor];
    NSDictionary *todaysHoursAttributes = [NSDictionary dictionaryWithObjectsAndKeys:todaysHoursFont, NSFontAttributeName, todaysHoursColor, NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *hours = [[NSMutableAttributedString alloc] initWithString:string.todayHours attributes:todaysHoursAttributes];
    [self.todayHours setAttributedText:hours];
}

- (void)loadNewsFeedNoInternet
{
    NSMutableArray *cache = self.newsFeedCache;
    NewsFeedCache *string = [cache firstObject];
    
    // News Title
    
    UIFont *newsTitleFont = [UIFont fontWithName:@"Helvetica-Nueu-Bold" size:15.0];
    UIColor *newsTitleColor = [UIColor blackColor];
    NSDictionary *newsTitleAttributes = [NSDictionary dictionaryWithObjectsAndKeys:newsTitleFont, NSFontAttributeName, newsTitleColor, NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *newsTitle = [[NSMutableAttributedString alloc] initWithString:string.title attributes:newsTitleAttributes];
    [self.newsTitle setAttributedText:newsTitle];
    
    // News Time Stamp
    
    UIFont *newsTimeStampFont = [UIFont fontWithName:@"Helvetica-Neueu" size:10.0];
    UIColor *newsTimeStampColor = UIColorFromRGB(0x808080);
    NSDictionary *newsTimeStampAttributes = [NSDictionary dictionaryWithObjectsAndKeys:newsTimeStampFont, NSFontAttributeName, newsTimeStampColor, NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *newsTimeStamp = [[NSMutableAttributedString alloc] initWithString:string.timeStamp attributes:newsTimeStampAttributes];
    [self.newsTimeStamp setAttributedText:newsTimeStamp];
    
    // News Body
    
    UIFont *newsFont = [UIFont fontWithName:@"Helvetica-Neueu" size:15.0];
    UIColor *newsColor = [UIColor blackColor];
    NSMutableParagraphStyle *newsParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    newsParagraphStyle.alignment = NSTextAlignmentLeft;
    newsParagraphStyle.minimumLineHeight = 15.0;
    NSDictionary *newsAttributes = [NSDictionary dictionaryWithObjectsAndKeys:newsFont, NSFontAttributeName, newsColor, NSForegroundColorAttributeName, newsParagraphStyle, NSParagraphStyleAttributeName, nil];
    NSMutableAttributedString *news = [[NSMutableAttributedString alloc] initWithString:string.newsBody attributes:newsAttributes];
    [self.news setAttributedText:news];
}

#define AMOUNT_TO_MOVE_UP 300.0

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    if (!self.movedUp && !self.menuButtonPressed)
    {
        self.menuButton.hidden = YES;
        [self moveScrollViewUp];
        self.movedUp = YES;
    } else if (self.movedUp && !self.menuButtonPressed)
    {
        [self moveScrollViewDown];
        self.movedUp = NO;
    } else if (!self.movedUp && self.menuButtonPressed)
    {
        [self moveScrollViewUpWhenBlocked];
    }
}

- (void)swipedUpGesture:(UISwipeGestureRecognizer *)gesture
{
    self.menuButton.hidden = YES;
    if (!self.movedUp && !self.menuButtonPressed)
    {
        [self moveScrollViewUp];
        self.movedUp = YES;
    } else if (!self.movedUp && self.menuButtonPressed)
    {
        [self moveScrollViewUpWhenBlocked];
    }
}

- (void)swipedDownGesture:(UISwipeGestureRecognizer *)gesture
{
    if (self.movedUp && !self.menuButtonPressed)
    {
        [self moveScrollViewDown];
        self.movedUp = NO;
    }
}

- (void)closeMenu:(UISwipeGestureRecognizer *)gesture
{
    self.menuButtonPressed = NO;
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.menuView setAlpha:0.0f];
                     }
                     completion:^(BOOL finished){
                         [self.menuView setAlpha:0.8f];
                         [self.view sendSubviewToBack:self.menuView];
                         self.menuButton.hidden = NO;
                     }];
}

- (IBAction)touchedMenuButton:(id)sender
{
    self.menuButtonPressed = YES;
    self.menuButton.hidden = YES;
    [self.view bringSubviewToFront:self.menuView];
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.menuView setAlpha:0.0f];
                         [self.menuView setAlpha:0.8f];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

- (IBAction)cancelMenu:(id)sender
{
    self.menuButtonPressed = NO;
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.menuView setAlpha:0.8f];
                         [self.menuView setAlpha:0.0f];
                     }
                     completion:^(BOOL finished){
                         self.menuButton.hidden = NO;
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moveScrollViewUp
{
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect rect = self.scrollView.frame;
                         rect.origin.y -= AMOUNT_TO_MOVE_UP;
                         rect.size.height += AMOUNT_TO_MOVE_UP;
                         self.scrollView.frame = rect;
                         self.movedUp = YES;
                     }
                     completion:^(BOOL finished){

                     }];
}

- (void)moveScrollViewDown
{
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect rect = self.scrollView.frame;
                         rect.origin.y += AMOUNT_TO_MOVE_UP;
                         rect.size.height -= AMOUNT_TO_MOVE_UP;
                         self.scrollView.frame = rect;
                         self.movedUp = NO;
                     }
                     completion:^(BOOL finished){
                         self.menuButton.hidden = NO;
                     }];
}

- (void)moveScrollViewUpWhenBlocked
{
    __block NSMutableArray* animationBlocks = [NSMutableArray new];
    typedef void(^animationBlock)(BOOL);
    
    animationBlock (^getNextAnimation)() = ^{
        
        if ([animationBlocks count] > 0){
            animationBlock block = (animationBlock)[animationBlocks objectAtIndex:0];
            [animationBlocks removeObjectAtIndex:0];
            return block;
        } else {
            return ^(BOOL finished){
                animationBlocks = nil;
            };
        }
    };
    
    [animationBlocks addObject:^(BOOL finished){
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            [self.menuView setAlpha:0.0f];
        } completion: getNextAnimation()];
    }];
    
    [animationBlocks addObject:^(BOOL finished){
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            [self moveScrollViewUp];
        } completion: getNextAnimation()];
    }];
    
    self.movedUp = YES;
    self.menuButtonPressed = NO;
    
    getNextAnimation()(YES);
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)linkToHours:(id)sender
{
    [self performSegueWithIdentifier:@"hours" sender:self];
}

- (IBAction)linkToCall:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"tel://718-260-3530"];
    [[UIApplication sharedApplication] openURL:url];
}

@end
