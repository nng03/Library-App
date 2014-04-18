//
//  viewTextbook.h
//  Library App
//
//  Created by fp on 3/28/14.
//  Copyright (c) 2014 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Textbook.h"
@interface viewTextbook : UIViewController <UITextViewDelegate>

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@property (weak, nonatomic) IBOutlet UIImageView *coverPage;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *courseCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (strong, nonatomic) Textbook *text;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
