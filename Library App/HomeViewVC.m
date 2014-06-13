//
//  HomeViewVC.m
//  Library App
//
//  Created by fp on 6/10/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import "HomeViewVC.h"

@interface HomeViewVC ()
@property (weak, nonatomic) IBOutlet UIImageView *movingImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIButton *cancelMenu;
@property (weak, nonatomic) IBOutlet UIButton *linkToHours;
@property (weak, nonatomic) IBOutlet UIView *menu;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    self.movedUp = NO;
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedUpGesture:)];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.scrollView addGestureRecognizer:swipeUp];
    UISwipeGestureRecognizer *swipedDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedDownGesture:)];
    [swipedDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.scrollView addGestureRecognizer:swipedDown];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self.scrollView addGestureRecognizer:singleTap];
    // Do any additional setup after loading the view.
}

#define AMOUNT_TO_MOVE_UP 300.0

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect rect = self.scrollView.frame;
    if (!self.movedUp && !self.menuButtonPressed)
    {
        rect.origin.y -= AMOUNT_TO_MOVE_UP;
        rect.size.height += AMOUNT_TO_MOVE_UP;
        self.movedUp = YES;
        self.menuButton.hidden = YES;
    } else if (self.movedUp && !self.menuButtonPressed)
    {
        rect.origin.y += AMOUNT_TO_MOVE_UP;
        rect.size.height -= AMOUNT_TO_MOVE_UP;
        self.movedUp = NO;
        self.menuButton.hidden = NO;
    }
    self.scrollView.frame = rect;
    [UIView commitAnimations];
}

- (void)swipedUpGesture:(UISwipeGestureRecognizer *)gesture
{
    if (!self.movedUp && !self.menuButtonPressed)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        CGRect rect = self.scrollView.frame;
        rect.origin.y -= AMOUNT_TO_MOVE_UP;
        rect.size.height += AMOUNT_TO_MOVE_UP;
        self.movedUp = YES;
        self.menuButton.hidden = YES;
        self.scrollView.frame = rect;
        [UIView commitAnimations];
    }
}

- (void)swipedDownGesture:(UISwipeGestureRecognizer *)gesture
{
    if (self.movedUp && !self.menuButtonPressed)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        CGRect rect = self.scrollView.frame;
        rect.origin.y += AMOUNT_TO_MOVE_UP;
        rect.size.height -= AMOUNT_TO_MOVE_UP;
        self.movedUp = NO;
        self.menuButton.hidden = NO;
        self.scrollView.frame = rect;
        [UIView commitAnimations];
    }
}

- (IBAction)touchedMenuButton:(id)sender
{
    self.menuButtonPressed = YES;
    [self.menuView setAlpha:0.f];
    [self.view bringSubviewToFront:self.menuView];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.menuView setAlpha:1.0f];
    [UIView commitAnimations];
}

- (IBAction)cancelMenu:(id)sender
{
    self.menuButtonPressed = NO;
    [self.menuView setAlpha:1.0f];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.menuView setAlpha:0.f];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
