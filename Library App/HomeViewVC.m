//
//  HomeViewVC.m
//  Library App
//
//  Created by fp on 6/10/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import "HomeViewVC.h"
#import "GoogleCal.h"

@interface HomeViewVC ()
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
@property (nonatomic) BOOL movedUp;
@property (nonatomic) BOOL menuButtonPressed;

@end

@implementation HomeViewVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Current Date
    
    NSDate *now = [[NSDate alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE"];
    NSString* currentDayName = [dateFormat stringFromDate:now];
    [dateFormat setDateFormat:@"MMMM dd, yyyy"];
    NSString* currentDayDate = [dateFormat stringFromDate:now];
    UIFont *currentDayNameFont = [UIFont fontWithName:@"Helvetica-Neue-Condensed-Black" size:14.0];
    UIFont *currentDayDateFont = [UIFont fontWithName:@"Helvetica-Neue-Condensed-Bold" size:24.0];
    UIColor *dateColor = [UIColor whiteColor];
    NSDictionary *dayAttributes = [NSDictionary dictionaryWithObjectsAndKeys:currentDayDateFont, NSFontAttributeName, dateColor, NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *day = [[NSMutableAttributedString alloc] initWithString:currentDayName attributes:dayAttributes];
    [self.currentDay setAttributedText:day];
    NSDictionary *dateAttributes = [NSDictionary dictionaryWithObjectsAndKeys:currentDayNameFont, NSFontAttributeName, dateColor, NSForegroundColorAttributeName, nil];
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
    
    // Load Calendar Data
    
    [self loadCalendarData];
}

- (void)loadCalendarData
{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString: @"https://www.google.com/calendar/feeds/9var82lp3jhu0eeu5cqthc2bd8%40group.calendar.google.com/public/basic?alt=jsonc&orderby=starttime&max-results=7&singleevents=true&sortorder=ascending&futureevents=true"]];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)data
{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                    options:kNilOptions
                                                      error:&error];
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
    } else if ([hours isEqualToString:@"noon-6pm"])
    {
        NSString *string = @"12PM - 6PM";
        NSMutableAttributedString *todaysHours = [[NSMutableAttributedString alloc] initWithString:string attributes:todaysHoursAttributes];
        [self.todayHours setAttributedText:todaysHours];
    } else if ([hours isEqualToString:@"CLOSED"])
    {
        NSString *string = @"CLOSED";
        NSMutableAttributedString *todaysHours = [[NSMutableAttributedString alloc] initWithString:string attributes:todaysHoursAttributes];
        [self.todayHours setAttributedText:todaysHours];
    }
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

    } else if (self.movedUp && self.menuButtonPressed)
    {
        
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
        [self closeMenu:gesture];
        [self moveScrollViewUp];
        self.movedUp = YES;
    }
}

- (void)swipedDownGesture:(UISwipeGestureRecognizer *)gesture
{
    if (self.movedUp && !self.menuButtonPressed)
    {
        [self moveScrollViewDown];
        self.movedUp = NO;
    } else if (self.movedUp && self.menuButtonPressed)
    {
        [self closeMenu:gesture];
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
                         [self.menuView setAlpha:0.7f];
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
                         [self.menuView setAlpha:0.7f];
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
                         [self.menuView setAlpha:0.7f];
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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)linkToHours:(id)sender
{
    [self performSegueWithIdentifier:@"hours" sender:self];
}

@end
