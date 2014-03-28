////
////  TextbookVC.m
////  Library App
////
////  Created by fp on 2/28/14.
////  Copyright (c) 2014 Nick. All rights reserved.
////
//
//#import "TextbookVC.h"
//#import "Textbook.h"
//#import "AppDelegate.h"
//#import "TextbooksClassVC.h"
//
//@interface TextbookVC ()
//
//@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, strong) NSArray *fetchedTextbooks;
//@property (nonatomic, strong) NSArray *subjects;
//
//@end
//
//@implementation TextbookVC
//
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.title = @"Textbook Subjects";
//    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
//    self.managedObjectContext = appDelegate.managedObjectContext;
//    self.fetchedTextbooks = [appDelegate getAllTextbooks];
//    self.subjects = [[NSArray alloc] initWithObjects:@"Biology", @"CB Engineering", @"Chemistry", @"Civil Engineering", @"Computer Science", @"Digital Media", @"Electrical Engineering", @"English", @"Finance", @"General Engineering", @"Humanities", @"Management", @"Mathematics", @"Mechanical Engineering", @"Physics", nil];
//    [self deleteAllObjects:@"Textbook"];
//    // Uncomment the following line to preserve selection between presentations.
//    // self.clearsSelectionOnViewWillAppear = NO;
// 
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (void) deleteAllObjects: (NSString *) entityDescription  {
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:_managedObjectContext];
//    [fetchRequest setEntity:entity];
//    
//    NSError *error;
//    NSArray *items = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    
//    
//    for (NSManagedObject *managedObject in items) {
//    	[_managedObjectContext deleteObject:managedObject];
//    	NSLog(@"%@ object deleted",entityDescription);
//    }
//    if (![_managedObjectContext save:&error]) {
//    	NSLog(@"Error deleting %@ - error:%@",entityDescription,error);
//    }
//    
//}
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return [self.subjects count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    cell.textLabel.text = [self.subjects objectAtIndex:indexPath.row];
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    self.currentSubject = cell.textLabel.text;
//    [self performSegueWithIdentifier:@"segue" sender:cell];
//}
//
//- (void)prepareTextbooksClassVC:(TextbooksClassVC *)tcvc forString:(NSString *)subject forBooks:(NSArray *)textbooks
//{
//    tcvc.title = subject;
////    tcvc.fetchedBooks = [[NSArray alloc] initWithArray:[self textbooksBySubject:subject textbooks:textbooks]];
//}
//
////- (NSMutableArray *)textbooksBySubject:(NSString *)sort textbooks:(NSArray *)textbooks
////{
////    NSMutableArray *newArray = [[NSMutableArray alloc] init];
////    for (Textbook *text in textbooks)
////    {
////        if ([text.subject isEqualToString:sort])
////        {
////            [newArray addObject:text];
////        }
////    }
////    return newArray;
////}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    [self prepareTextbooksClassVC:segue.destinationViewController
//                        forString:self.currentSubject
//                         forBooks:self.fetchedTextbooks];
//}
//
//#define bio "Biology"
//#define cbe "CB Engineering"
//#define chem "Chemistry"
//#define civil "Civil Engineering"
//#define compsci "Computer Science"
//#define dm "Digital Media"
//#define ee "Electrical Engineering"
//#define eng "English"
//#define fin "Finance"
//#define geneg "General Engineering"
//#define human "Humanities"
//#define mang "Management"
//#define math "Mathematics"
//#define meche "Mechanical Engineering"
//#define phy "Physics"
//
////- (void)fillTextbooks
////{
////    [self fillBio];
////    [self fillCBE];
////    [self fillChem];
////    [self fillCivil];
////    [self fillCompSci];
////    [self fillDigitalMedia];
////    [self fillEE];
////    [self fillEnglish];
////    [self fillFinance];
////    [self fillGeneralEngineering];
////    [self fillHumanities];
////    [self fillManagement];
////    [self fillMath];
////    [self fillMechE];
////    [self fillPhysics];
////}
////
////- (void)fillBio
////{
////    Textbook *text1 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text1.subject = @bio;
////    text1.class0 = @"BMS1004 Introduction to Cell and Molecular Biology";
////    text1.name = @"Introduction to Cellular and Molecular Biology Lab Manual";
////    NSError *error;
////    if (![self.managedObjectContext save:&error])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
////    }
////    Textbook *text2 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text2.subject = @bio;
////    text2.class0 = @"BMS1004 Introduction to Cell and Molecular Biology";
////    text2.name = @"Brooker - Biology, 2nd Edition";
////    NSError *error1;
////    if (![self.managedObjectContext save:&error1])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error1 localizedDescription]);
////    }
////    Textbook *text3 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text3.subject = @bio;
////    text3.class0 = @"BMS2004 Introduction to Physiology";
////    text3.name = @"Brooker - Biology, 2nd Edition";
////    NSError *error2;
////    if (![self.managedObjectContext save:&error2])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error2 localizedDescription]);
////    }
////}
////
////- (void)fillCBE
////{
////    Textbook *text1 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text1.subject = @cbe;
////    text1.class0 = @"CBE1002 Introduction to Chemical and Biological Engineering";
////    text1.name = @"Elementary Principles of Chemical Processes 3rd Edition";
////    NSError *error;
////    if (![self.managedObjectContext save:&error])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
////    }
////    Textbook *text2 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text2.subject = @cbe;
////    text2.class0 = @"CBE2124 Analysis of Chemical and Biological Processes";
////    text2.name = @"Elementary Principles of Chemical Processes 3rd Edition";
////    NSError *error1;
////    if (![self.managedObjectContext save:&error1])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error1 localizedDescription]);
////    }
////    Textbook *text3 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text3.subject = @cbe;
////    text3.class0 = @"CBE3153 Chemical and Biological Thermodynamics";
////    text3.name = @"Introduction to Chemical Engineering Thermodynamics 7th Edition";
////    NSError *error2;
////    if (![self.managedObjectContext save:&error2])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error2 localizedDescription]);
////    }
////    Textbook *text4 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text4.subject = @cbe;
////    text4.class0 = @"CBE3223 Kinetics and Reactor Design";
////    text4.name = @"Chemical Reactor Analysis and Design Fundamentals";
////    NSError *error3;
////    if (![self.managedObjectContext save:&error3])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error3 localizedDescription]);
////    }
////    Textbook *text5 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text5.subject = @cbe;
////    text5.class0 = @"CBE3233 Chemical and Biomolecular Engineering Separations";
////    text5.name = @"Separation Process Principles 3rd Edition";
////    NSError *error4;
////    if (![self.managedObjectContext save:&error4])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error4 localizedDescription]);
////    }
////    Textbook *text6 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text6.subject = @cbe;
////    text6.class0 = @"CBE3313 Transport I";
////    text6.name = @"Transport Phenomena 2nd Edition";
////    NSError *error5;
////    if (![self.managedObjectContext save:&error5])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error5 localizedDescription]);
////    }
////    Textbook *text7 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text7.subject = @cbe;
////    text7.class0 = @"CBE3313 Transport II";
////    text7.name = @"Transport Phenomena 2nd Edition";
////    NSError *error6;
////    if (![self.managedObjectContext save:&error6])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error6 localizedDescription]);
////    }
////    Textbook *text8 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text8.subject = @cbe;
////    text8.class0 = @"CBE6153 Applied Mathematics in Engineering";
////    text8.name = @"Advanced Engineering Mathematics 2nd Edition";
////    NSError *error7;
////    if (![self.managedObjectContext save:&error7])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error7 localizedDescription]);
////    }
////}
////
////- (void)fillChem
////{
////    Textbook *text1 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text1.subject = @chem;
////    text1.class0 = @"CM1004 General Chemistry for Engineers";
////    text1.name = @"Chemistry 10th Edition";
////    NSError *error;
////    if (![self.managedObjectContext save:&error])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
////    }
////    Textbook *text2 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text2.subject = @chem;
////    text2.class0 = @"CM1004 General Chemistry for Engineers";
////    text2.name = @"General Chemistry - The Essential Concepts 6th Edition";
////    NSError *error1;
////    if (![self.managedObjectContext save:&error1])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error1 localizedDescription]);
////    }
////    Textbook *text3 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text3.subject = @chem;
////    text3.class0 = @"CM2213 Organic Chemistry I";
////    text3.name = @"Organic Chemistry 8th Edition";
////    NSError *error2;
////    if (![self.managedObjectContext save:&error2])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error2 localizedDescription]);
////    }
////    Textbook *text4 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text4.subject = @chem;
////    text4.class0 = @"CM2213 Organic Chemistry II";
////    text4.name = @"Organic Chemistry 8th Edition";
////    NSError *error3;
////    if (![self.managedObjectContext save:&error3])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error3 localizedDescription]);
////    }
////    Textbook *text5 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text5.subject = @chem;
////    text5.class0 = @"CM3514 Analytical Chemistry";
////    text5.name = @"Analytical Chemistry 6th Edition";
////    NSError *error4;
////    if (![self.managedObjectContext save:&error4])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error4 localizedDescription]);
////    }
////}
////
////- (void)fillCivil
////{
////    Textbook *text1 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text1.subject = @civil;
////    text1.class0 = @"CE2113 Statics";
////    text1.name = @"Engineering Mechanics - Statics 12th Edition";
////    NSError *error;
////    if (![self.managedObjectContext save:&error])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
////    }
////    Textbook *text2 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text2.subject = @civil;
////    text2.class0 = @"CE2123 Mechanics of Materials";
////    text2.name = @"Mechanics of Materials 8th Edition";
////    NSError *error1;
////    if (![self.managedObjectContext save:&error1])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error1 localizedDescription]);
////    }
////    Textbook *text3 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text3.subject = @civil;
////    text3.class0 = @"CE2213 Fluid Mechanics and Hydraulics";
////    text3.name = @"Fundamentals of Fluid Mechanics 6th Edition";
////    NSError *error2;
////    if (![self.managedObjectContext save:&error2])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error2 localizedDescription]);
////    }
////    Textbook *text4 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text4.subject = @civil;
////    text4.class0 = @"CE3122 Structural Dynamics";
////    text4.name = @"Engineering Mechanics - Dynamics 13th Edition";
////    NSError *error3;
////    if (![self.managedObjectContext save:&error3])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error3 localizedDescription]);
////    }
////}
////
////- (void)fillCompSci
////{
////    Textbook *text1 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text1.subject = @compsci;
////    text1.class0 = @"CS1114 Intro to Prog and Problem Solving";
////    text1.name = @"Starting out with Python";
////    NSError *error;
////    if (![self.managedObjectContext save:&error])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
////    }
////    Textbook *text2 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text2.subject = @compsci;
////    text2.class0 = @"CS1122 Intro to Computer Science";
////    text2.name = @"Computer Science: An Overview 9th Edition";
////    NSError *error1;
////    if (![self.managedObjectContext save:&error1])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error1 localizedDescription]);
////    }
////    Textbook *text3 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text3.subject = @compsci;
////    text3.class0 = @"CS1133 Engineering Problem Solving and Programming";
////    text3.name = @"Chapman Essentials MATLAB Programming 2nd Edition";
////    NSError *error2;
////    if (![self.managedObjectContext save:&error2])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error2 localizedDescription]);
////    }
////    Textbook *text4 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text4.subject = @compsci;
////    text4.class0 = @"CS2134 Data Structures and Algorithms";
////    text4.name = @"Data Structures and Problem Solving With C++ 2nd Edition";
////    NSError *error3;
////    if (![self.managedObjectContext save:&error3])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error3 localizedDescription]);
////    }
////    Textbook *text5 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text5.subject = @compsci;
////    text5.class0 = @"CS2204 Digital Logic and State Machine Design";
////    text5.name = @"Digital Design Principles And Practices 4th Edition";
////    NSError *error4;
////    if (![self.managedObjectContext save:&error4])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error4 localizedDescription]);
////    }
////    Textbook *text6 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text6.subject = @compsci;
////    text6.class0 = @"CS2214 Computer Architecture and Organization";
////    text6.name = @"Computer Organization and Design 5th Edition";
////    NSError *error5;
////    if (![self.managedObjectContext save:&error5])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error5 localizedDescription]);
////    }
////    Textbook *text7 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text7.subject = @compsci;
////    text7.class0 = @"CS308 Introduction to Databases";
////    text7.name = @"Database System Concepts 6th Edition";
////    NSError *error6;
////    if (![self.managedObjectContext save:&error6])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error6 localizedDescription]);
////    }
////    Textbook *text8 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text8.subject = @compsci;
////    text8.class0 = @"CS3224 Operating Systems";
////    text8.name = @"Modern Operating Systems 3rd Edition";
////    NSError *error7;
////    if (![self.managedObjectContext save:&error7])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error7 localizedDescription]);
////    }
////    Textbook *text9 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text9.subject = @compsci;
////    text9.class0 = @"CS3254 Introduction to Parallel and Distributed Systems";
////    text9.name = @"Distributed Systems - Concepts and Design 5th Edition";
////    NSError *error8;
////    if (![self.managedObjectContext save:&error8])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error8 localizedDescription]);
////    }
////    Textbook *text10 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text10.subject = @compsci;
////    text10.class0 = @"CS3314 Design and Implementation of Programming Languages";
////    text10.name = @"Programming Languages Principles and Practices 3rd Edition";
////    NSError *error9;
////    if (![self.managedObjectContext save:&error9])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error9 localizedDescription]);
////    }
////    Textbook *text11 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text11.subject = @compsci;
////    text11.class0 = @"CS3413 Design and Analysis of Algorithms";
////    text11.name = @"Algorithms";
////    NSError *error10;
////    if (![self.managedObjectContext save:&error10])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error10 localizedDescription]);
////    }
////    Textbook *text12 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text12.subject = @compsci;
////    text12.class0 = @"CS3513 Software Engineering I";
////    text12.name = @"Objected Oriented and Classical Software Engineering 8th Edition";
////    NSError *error11;
////    if (![self.managedObjectContext save:&error11])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error11 localizedDescription]);
////    }
////    Textbook *text13 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text13.subject = @compsci;
////    text13.class0 = @"CS391 Java and Web Design";
////    text13.name = @"Just Java 2 6th Edition";
////    NSError *error12;
////    if (![self.managedObjectContext save:&error12])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error12 localizedDescription]);
////    }
////    Textbook *text14 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text14.subject = @compsci;
////    text14.class0 = @"CS4523 Design Project II";
////    text14.name = @"Objected Oriented and Classical Software Engineering 8th Edition";
////    NSError *error13;
////    if (![self.managedObjectContext save:&error13])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error13 localizedDescription]);
////    }
////    Textbook *text15 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text15.subject = @compsci;
////    text15.class0 = @"CS6003 Foundations of Computer Science";
////    text15.name = @"Discrete Math and its Applications 7th Edition";
////    NSError *error14;
////    if (![self.managedObjectContext save:&error14])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error14 localizedDescription]);
////    }
////    Textbook *text16 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text16.subject = @compsci;
////    text16.class0 = @"CS6003 Foundations of Computer Science";
////    text16.name = @"Discrete Math and its Applications 7th Edition";
////    NSError *error15;
////    if (![self.managedObjectContext save:&error15])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error15 localizedDescription]);
////    }
////    Textbook *text17 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text17.subject = @compsci;
////    text17.class0 = @"CS6033 Design and Analysis of Algorithms I";
////    text17.name = @"Introduction to Algorithms 3rd Edition";
////    NSError *error16;
////    if (![self.managedObjectContext save:&error16])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error16 localizedDescription]);
////    }
////    Textbook *text18 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text18.subject = @compsci;
////    text18.class0 = @"CS6033 Design and Analysis of Algorithms II";
////    text18.name = @"Introduction to Algorithms 3rd Edition";
////    NSError *error17;
////    if (![self.managedObjectContext save:&error17])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error17 localizedDescription]);
////    }
////    Textbook *text19 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text19.subject = @compsci;
////    text19.class0 = @"CS6083 Principles of Database Systems";
////    text19.name = @"Database System Concepts 6th Edition";
////    NSError *error18;
////    if (![self.managedObjectContext save:&error18])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error18 localizedDescription]);
////    }
////    Textbook *text20 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text20.subject = @compsci;
////    text20.class0 = @"CS6143 Computer Architecture II";
////    text20.name = @"Computer Architecture - A Quantitative Approach 5th Edition";
////    NSError *error19;
////    if (![self.managedObjectContext save:&error19])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error19 localizedDescription]);
////    }
////    Textbook *text21 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text21.subject = @compsci;
////    text21.class0 = @"CS6233 Introduction to Operating Systems";
////    text21.name = @"Operating Systems Internals and Design Principles 6th Edition";
////    NSError *error20;
////    if (![self.managedObjectContext save:&error20])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error20 localizedDescription]);
////    }
////    Textbook *text22 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text22.subject = @compsci;
////    text22.class0 = @"CS6233 Introduction to Operating Systems";
////    text22.name = @"Modern Operating Systems 3rd Edition";
////    NSError *error21;
////    if (![self.managedObjectContext save:&error21])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error21 localizedDescription]);
////    }
////    Textbook *text23 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text23.subject = @compsci;
////    text23.class0 = @"CS6533 Interactive Computer Graphics";
////    text23.name = @"Foundations of 3D Computer Graphics";
////    NSError *error22;
////    if (![self.managedObjectContext save:&error22])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error22 localizedDescription]);
////    }
////    Textbook *text24 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text24.subject = @compsci;
////    text24.class0 = @"CS6533 Interactive Computer Graphics";
////    text24.name = @"Interactive Computer Graphics - A Top-Down Approach Using OpenGL 5th Edition";
////    NSError *error23;
////    if (![self.managedObjectContext save:&error23])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error23 localizedDescription]);
////    }
////    Textbook *text25 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text25.subject = @compsci;
////    text25.class0 = @"CS6573 Penetration Testing and Vulnerability Analysis";
////    text25.name = @"Gray Hat Hacking 3rd Edition";
////    NSError *error24;
////    if (![self.managedObjectContext save:&error24])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error24 localizedDescription]);
////    }
////    Textbook *text26 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text26.subject = @compsci;
////    text26.class0 = @"CS6613 Artificial Intelligence";
////    text26.name = @"Artificial Intelligence - A Modern Approach 3rd Edition";
////    NSError *error25;
////    if (![self.managedObjectContext save:&error25])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error25 localizedDescription]);
////    }
////    Textbook *text27 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text27.subject = @compsci;
////    text27.class0 = @"CS6643 Computer Vision and Scene Analysis";
////    text27.name = @"Computer Vision";
////    NSError *error26;
////    if (![self.managedObjectContext save:&error26])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error26 localizedDescription]);
////    }
////    Textbook *text28 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text28.subject = @compsci;
////    text28.class0 = @"CS6673 Neural Network Computing";
////    text28.name = @"Fundamentals of Neural Networks";
////    NSError *error27;
////    if (![self.managedObjectContext save:&error27])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error27 localizedDescription]);
////    }
////    Textbook *text29 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text29.subject = @compsci;
////    text29.class0 = @"CS6703 Computational Geometry";
////    text29.name = @"Computational Geometry - Algorithms and Applications 3rd Edition";
////    NSError *error28;
////    if (![self.managedObjectContext save:&error28])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error28 localizedDescription]);
////    }
////    Textbook *text30 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text30.subject = @compsci;
////    text30.class0 = @"CS6753 Theory of Computation";
////    text30.name = @"Introduction to the Theory of Computation 2nd Edition";
////    NSError *error29;
////    if (![self.managedObjectContext save:&error29])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error29 localizedDescription]);
////    }
////    Textbook *text31 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text31.subject = @compsci;
////    text31.class0 = @"CS6823 Network Security";
////    text31.name = @"Counter Hack Reloaded";
////    NSError *error30;
////    if (![self.managedObjectContext save:&error30])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error30 localizedDescription]);
////    }
////    Textbook *text32 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text32.subject = @compsci;
////    text32.class0 = @"CS6823 Network Security";
////    text32.name = @"Cryptography Engineering";
////    NSError *error31;
////    if (![self.managedObjectContext save:&error31])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error31 localizedDescription]);
////    }
////    Textbook *text33 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text33.subject = @compsci;
////    text33.class0 = @"CS6843 Computer Networking";
////    text33.name = @"Computer Networking - A Top Down Approach 6th Edition";
////    NSError *error32;
////    if (![self.managedObjectContext save:&error32])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error32 localizedDescription]);
////    }
////    Textbook *text34 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text34.subject = @compsci;
////    text34.class0 = @"CS6903 Modern Cryptography";
////    text34.name = @"Introduction to Modern Cryptography";
////    NSError *error33;
////    if (![self.managedObjectContext save:&error33])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error33 localizedDescription]);
////    }
////    Textbook *text35 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text35.subject = @compsci;
////    text35.class0 = @"CS6923 Machine Learning";
////    text35.name = @"Introduction to Machine Learning 2nd Edition";
////    NSError *error34;
////    if (![self.managedObjectContext save:&error34])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error34 localizedDescription]);
////    }
////    Textbook *text36 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text36.subject = @compsci;
////    text36.class0 = @"CS9163 Application Security";
////    text36.name = @"The Art of Software Security Assessment";
////    NSError *error35;
////    if (![self.managedObjectContext save:&error35])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error35 localizedDescription]);
////    }
////    Textbook *text37 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text37.subject = @compsci;
////    text37.class0 = @"CSEE1012 Intro to Computer Engineering";
////    text37.name = @"Introduction to Computing Systems";
////    NSError *error36;
////    if (![self.managedObjectContext save:&error36])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error36 localizedDescription]);
////    }
////}
////
////- (void)fillDigitalMedia
////{
////    Textbook *text1 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text1.subject = @dm;
////    text1.class0 = @"DM1123 Visual Foundation Studio";
////    text1.name = @"Processing - A Programming Handbook for Visual Designers and Artists";
////    NSError *error;
////    if (![self.managedObjectContext save:&error])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
////    }
////    Textbook *text2 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text2.subject = @dm;
////    text2.class0 = @"DM2123 Cinema Studio I";
////    text2.name = @"Film Art - An Introduction 8th Edition";
////    NSError *error1;
////    if (![self.managedObjectContext save:&error1])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error1 localizedDescription]);
////    }
////    Textbook *text3 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text3.subject = @dm;
////    text3.class0 = @"DM2153 Game Development Studio I";
////    text3.name = @"Game Design Workshop";
////    NSError *error2;
////    if (![self.managedObjectContext save:&error2])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error2 localizedDescription]);
////    }
////    Textbook *text4 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text4.subject = @dm;
////    text4.class0 = @"DM3193 Web Studio II";
////    text4.name = @"Introducing HTML5";
////    NSError *error3;
////    if (![self.managedObjectContext save:&error3])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error3 localizedDescription]);
////    }
////    Textbook *text5 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text5.subject = @dm;
////    text5.class0 = @"DM3193 Web Studio II";
////    text5.name = @"Stunning CSS3";
////    NSError *error4;
////    if (![self.managedObjectContext save:&error4])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error4 localizedDescription]);
////    }
////    Textbook *text6 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text6.subject = @dm;
////    text6.class0 = @"DM4153 Game Development Studio III";
////    text6.name = @"The Art of Game Design";
////    NSError *error5;
////    if (![self.managedObjectContext save:&error5])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error5 localizedDescription]);
////    }
////}
////
////- (void)fillEE
////{
////    Textbook *text1 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text1.subject = @ee;
////    text1.class0 = @"CSEE1012 Intro to Computer Engineering";
////    text1.name = @"Introduction to Computing Systems";
////    NSError *error;
////    if (![self.managedObjectContext save:&error])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
////    }
////    Textbook *text2 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text2.subject = @ee;
////    text2.class0 = @"EE136 Communication Networks";
////    text2.name = @"Data and Computer Communications 8th Edition";
////    NSError *error1;
////    if (![self.managedObjectContext save:&error1])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error1 localizedDescription]);
////    }
////    Textbook *text3 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text3.subject = @ee;
////    text3.class0 = @"EE2013 Fundamentals of Electric Circuits I";
////    text3.name = @"Engineering Circuit Analysis 8th Edition";
////    NSError *error2;
////    if (![self.managedObjectContext save:&error2])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error2 localizedDescription]);
////    }
////    Textbook *text4 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text4.subject = @ee;
////    text4.class0 = @"EE2013 Fundamentals of Electric Circuits II";
////    text4.name = @"Engineering Circuit Analysis 8th Edition";
////    NSError *error3;
////    if (![self.managedObjectContext save:&error3])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error3 localizedDescription]);
////    }
////    Textbook *text5 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text5.subject = @ee;
////    text5.class0 = @"EE3054 Signals, Systems, and Transforms";
////    text5.name = @"Signals and Systems using MATLAB";
////    NSError *error4;
////    if (![self.managedObjectContext save:&error4])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error4 localizedDescription]);
////    }
////    Textbook *text6 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text6.subject = @ee;
////    text6.class0 = @"EE3114 Fundamentals of Electronics I";
////    text6.name = @"Microelectronics Circuit Analysis";
////    NSError *error5;
////    if (![self.managedObjectContext save:&error5])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error5 localizedDescription]);
////    }
////    Textbook *text7 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text7.subject = @ee;
////    text7.class0 = @"EE3114 Fundamentals of Electronics II";
////    text7.name = @"Microelectronics Circuit Analysis";
////    NSError *error6;
////    if (![self.managedObjectContext save:&error6])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error6 localizedDescription]);
////    }
////    Textbook *text8 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text8.subject = @ee;
////    text8.class0 = @"EE3404 Fundamentals of Communication Theory";
////    text8.name = @"Communication Systems Engineering 2nd Edition";
////    NSError *error7;
////    if (![self.managedObjectContext save:&error7])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error7 localizedDescription]);
////    }
////    Textbook *text9 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text9.subject = @ee;
////    text9.class0 = @"EL5363 Principles of Communication Networks";
////    text9.name = @"Data and Computer Communications 8th Edition";
////    NSError *error8;
////    if (![self.managedObjectContext save:&error8])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error8 localizedDescription]);
////    }
////    Textbook *text10 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text10.subject = @ee;
////    text10.class0 = @"EL5373 Internet Architecture & Protocols";
////    text10.name = @"TCP IP Essentials A Lab-Based Approach";
////    NSError *error9;
////    if (![self.managedObjectContext save:&error9])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error9 localizedDescription]);
////    }
////    Textbook *text11 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text11.subject = @ee;
////    text11.class0 = @"EL5473 Introduction to VLSI System Design";
////    text11.name = @"CMOS VLSI Design 4th Edition";
////    NSError *error10;
////    if (![self.managedObjectContext save:&error10])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error10 localizedDescription]);
////    }
////    Textbook *text12 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text12.subject = @ee;
////    text12.class0 = @"EL5553 Physics of Quantum Computing";
////    text12.name = @"Introduction to Quantum Computers";
////    NSError *error11;
////    if (![self.managedObjectContext save:&error11])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error11 localizedDescription]);
////    }
////    Textbook *text13 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text13.subject = @ee;
////    text13.class0 = @"EL6303 Probability Theory";
////    text13.name = @"Probability Random Variables and Stochastic Processes 4th Edition";
////    NSError *error12;
////    if (![self.managedObjectContext save:&error12])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error12 localizedDescription]);
////    }
////}
////
////- (void)fillEnglish
////{
////    Textbook *text1 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text1.subject = @eng;
////    text1.class0 = @"EW1013 Writing the Essay";
////    text1.name = @"Occasions for Writing";
////    NSError *error;
////    if (![self.managedObjectContext save:&error])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
////    }
////    Textbook *text2 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text2.subject = @eng;
////    text2.class0 = @"EW1023 The Advanced College Essay";
////    text2.name = @"The Advanced College Essay";
////    NSError *error1;
////    if (![self.managedObjectContext save:&error1])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error1 localizedDescription]);
////    }
////}
////
////- (void)fillFinance
////{
////    Textbook *text1 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text1.subject = @fin;
////    text1.class0 = @"FIN2003 Economic Foundations of Finance";
////    text1.name = @"Microeconomics 7th Edition";
////    NSError *error;
////    if (![self.managedObjectContext save:&error])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
////    }
////}
////
////- (void)fillGeneralEngineering
////{
////    Textbook *text1 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text1.subject = @geneg;
////    text1.class0 = @"EG1001 Engineering Forum";
////    text1.name = @"They Made America";
////    NSError *error;
////    if (![self.managedObjectContext save:&error])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
////    }
////}
////
////- (void)fillHumanities
////{
////    Textbook *text1 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text1.subject = @human;
////    text1.class0 = @"MU2113 Western Music Theory";
////    text1.name = @"Introductory Musicianship - A Workbook 7th Edition";
////    NSError *error;
////    if (![self.managedObjectContext save:&error])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
////    }
////    Textbook *text2 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text2.subject = @human;
////    text2.class0 = @"MU2213 Non-Western Music Appreciation";
////    text2.name = @"Worlds of Music 5th Edition";
////    NSError *error1;
////    if (![self.managedObjectContext save:&error1])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error1 localizedDescription]);
////    }
////    Textbook *text3 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text3.subject = @human;
////    text3.class0 = @"'PL2143 Ethics and Technology";
////    text3.name = @"Elements of Moral Philosophy";
////    NSError *error2;
////    if (![self.managedObjectContext save:&error2])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error2 localizedDescription]);
////    }
////}
////
////- (void)fillManagement
////{
////    Textbook *text1 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text1.subject = @mang;
////    text1.class0 = @"MG2304 Marketing";
////    text1.name = @"Marketing Management 14th Edition";
////    NSError *error;
////    if (![self.managedObjectContext save:&error])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
////    }
////}
////
////- (void)fillMath
////{
////    Textbook *text1 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text1.subject = @math;
////    text1.class0 = @"MA1002 Art of Mathematics";
////    text1.name = @"An Introduction to Mathematical Reasoning";
////    NSError *error;
////    if (![self.managedObjectContext save:&error])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
////    }
////    Textbook *text2 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text2.subject = @math;
////    text2.class0 = @"MA1024 Calculus I";
////    text2.name = @"Essential Calculus Early Transcendentals 1st Edition";
////    NSError *error1;
////    if (![self.managedObjectContext save:&error1])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error1 localizedDescription]);
////    }
////    Textbook *text3 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text3.subject = @math;
////    text3.class0 = @"MA1124 Calculus II";
////    text3.name = @"Essential Calculus Early Transcendentals 1st Edition";
////    NSError *error2;
////    if (![self.managedObjectContext save:&error2])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error2 localizedDescription]);
////    }
////    Textbook *text4 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text4.subject = @math;
////    text4.class0 = @"MA1132 Numerical Methods for Calculus";
////    text4.name = @"Essential Calculus Early Transcendentals 1st Edition";
////    NSError *error3;
////    if (![self.managedObjectContext save:&error3])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error3 localizedDescription]);
////    }
////    Textbook *text5 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text5.subject = @math;
////    text5.class0 = @"MA1324 Integrated Calculus I";
////    text5.name = @"Essential Calculus Early Transcendentals 1st Edition";
////    NSError *error4;
////    if (![self.managedObjectContext save:&error4])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error4 localizedDescription]);
////    }
////    Textbook *text6 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text6.subject = @math;
////    text6.class0 = @"MA1424 Integrated Calculus II";
////    text6.name = @"Essential Calculus Early Transcendentals 1st Edition";
////    NSError *error5;
////    if (![self.managedObjectContext save:&error5])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error5 localizedDescription]);
////    }
////    Textbook *text7 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text7.subject = @math;
////    text7.class0 = @"MA2012 Elements of Linear Algebra I";
////    text7.name = @"Differential Equations and Linear Algebra 3rd Edition";
////    NSError *error6;
////    if (![self.managedObjectContext save:&error6])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error6 localizedDescription]);
////    }
////    Textbook *text8 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text8.subject = @math;
////    text8.class0 = @"MA2012 Elements of Linear Algebra I";
////    text8.name = @"Linear Algebra and its Applications 4th Edition";
////    NSError *error7;
////    if (![self.managedObjectContext save:&error7])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error7 localizedDescription]);
////    }
////    Textbook *text9 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text9.subject = @math;
////    text9.class0 = @"MA2054 Applied Business Data Analysis I";
////    text9.name = @"Elementary Statistics 10e";
////    NSError *error8;
////    if (![self.managedObjectContext save:&error8])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error8 localizedDescription]);
////    }
////    Textbook *text10 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text10.subject = @math;
////    text10.class0 = @"MA2112 Multivariable Calculus A";
////    text10.name = @"Multivariable Calculus 6th Edition";
////    NSError *error9;
////    if (![self.managedObjectContext save:&error9])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error9 localizedDescription]);
////    }
////    Textbook *text11 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text11.subject = @math;
////    text11.class0 = @"MA2122 Multivariable Calculus B";
////    text11.name = @"Multivariable Calculus 6th Edition";
////    NSError *error10;
////    if (![self.managedObjectContext save:&error10])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error10 localizedDescription]);
////    }
////    Textbook *text12 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text12.subject = @math;
////    text12.class0 = @"MA2132 Ordinary Differential Equations";
////    text12.name = @"Differential Equations and Linear Algebra 3rd Edition";
////    NSError *error11;
////    if (![self.managedObjectContext save:&error11])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error11 localizedDescription]);
////    }
////    Textbook *text13 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text13.subject = @math;
////    text13.class0 = @"MA2132 Ordinary Differential Equations";
////    text13.name = @"A First Course in Differential Equations 9th Edition";
////    NSError *error12;
////    if (![self.managedObjectContext save:&error12])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error12 localizedDescription]);
////    }
////    Textbook *text14 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text14.subject = @math;
////    text14.class0 = @"MA2212 Data Analysis I";
////    text14.name = @"Probability and Statistics for Engineers and Scientists 4th Edition";
////    NSError *error13;
////    if (![self.managedObjectContext save:&error13])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error13 localizedDescription]);
////    }
////    Textbook *text15 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text15.subject = @math;
////    text15.class0 = @"MA2222 Data Analysis II";
////    text15.name = @"Probability and Statistics for Engineers and Scientists 4th Edition";
////    NSError *error14;
////    if (![self.managedObjectContext save:&error14])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error14 localizedDescription]);
////    }
////    Textbook *text16 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text16.subject = @math;
////    text16.class0 = @"MA2312 Discrete Math I";
////    text16.name = @"Discrete Math and its Applications 7th Edition";
////    NSError *error15;
////    if (![self.managedObjectContext save:&error15])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error15 localizedDescription]);
////    }
////    Textbook *text17 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text17.subject = @math;
////    text17.class0 = @"MA2322 Discrete Math II";
////    text17.name = @"Discrete Math and its Applications 7th Edition";
////    NSError *error16;
////    if (![self.managedObjectContext save:&error16])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error16 localizedDescription]);
////    }
////    Textbook *text18 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text18.subject = @math;
////    text18.class0 = @"MA3012 Introduction to Probability I";
////    text18.name = @"A First Course in Probability 8th Edition";
////    NSError *error17;
////    if (![self.managedObjectContext save:&error17])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error17 localizedDescription]);
////    }
////    Textbook *text19 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text19.subject = @math;
////    text19.class0 = @"MA3022 Introduction to Probability II";
////    text19.name = @"A First Course in Probability 8th Edition";
////    NSError *error18;
////    if (![self.managedObjectContext save:&error18])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error18 localizedDescription]);
////    }
////    Textbook *text20 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text20.subject = @math;
////    text20.class0 = @"MA3112 Complex Variables I";
////    text20.name = @"Complex Variables and Applications 8th Edition";
////    NSError *error19;
////    if (![self.managedObjectContext save:&error19])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error19 localizedDescription]);
////    }
////    Textbook *text21 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text21.subject = @math;
////    text21.class0 = @"MA4423 Introductory Numerical Analysis";
////    text21.name = @"Numerical Analysis 2nd Edition";
////    NSError *error20;
////    if (![self.managedObjectContext save:&error20])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error20 localizedDescription]);
////    }
////    Textbook *text22 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text22.subject = @math;
////    text22.class0 = @"MA4613 Real Analysis I";
////    text22.name = @"Introduction to Real Analysis 2nd Edition";
////    NSError *error21;
////    if (![self.managedObjectContext save:&error21])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error21 localizedDescription]);
////    }
////    Textbook *text23 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text23.subject = @math;
////    text23.class0 = @"MA4623 Real Analysis II";
////    text23.name = @"Introduction to Real Analysis 2nd Edition";
////    NSError *error22;
////    if (![self.managedObjectContext save:&error22])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error22 localizedDescription]);
////    }
////    Textbook *text24 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text24.subject = @math;
////    text24.class0 = @"MA6213 Elements of Real Analysis I";
////    text24.name = @"Introduction to Real Analysis 2nd Edition";
////    NSError *error23;
////    if (![self.managedObjectContext save:&error23])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error23 localizedDescription]);
////    }
////    Textbook *text25 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text25.subject = @math;
////    text25.class0 = @"MA6223 Elements of Real Analysis II";
////    text25.name = @"Introduction to Real Analysis 2nd Edition";
////    NSError *error24;
////    if (![self.managedObjectContext save:&error24])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error24 localizedDescription]);
////    }
////    Textbook *text26 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text26.subject = @math;
////    text26.class0 = @"MA7033 Linear Algebra I";
////    text26.name = @"Finite Dimensional Vector Spaces";
////    NSError *error25;
////    if (![self.managedObjectContext save:&error25])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error25 localizedDescription]);
////    }
////    Textbook *text27 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text27.subject = @math;
////    text27.class0 = @"MA7043 Linear Algebra II";
////    text27.name = @"Finite Dimensional Vector Spaces";
////    NSError *error26;
////    if (![self.managedObjectContext save:&error26])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error26 localizedDescription]);
////    }
////}
////
////- (void)fillMechE
////{
////    Textbook *text1 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text1.subject = @meche;
////    text1.class0 = @"ME2213 Statics";
////    text1.name = @"Vector Mechanics for Engineers (Statics&Dynamics) 9th Edition";
////    NSError *error;
////    if (![self.managedObjectContext save:&error])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
////    }
////    Textbook *text2 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text2.subject = @meche;
////    text2.class0 = @"ME3213 Mechanics of Materials";
////    text2.name = @"Mechanics of Materials 7th Edition";
////    NSError *error1;
////    if (![self.managedObjectContext save:&error1])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error1 localizedDescription]);
////    }
////    Textbook *text3 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text3.subject = @meche;
////    text3.class0 = @"ME3223 Dynamics";
////    text3.name = @"Vector Mechanics for Engineers (Statics&Dynamics) 9th Edition";
////    NSError *error2;
////    if (![self.managedObjectContext save:&error2])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error2 localizedDescription]);
////    }
////    Textbook *text4 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text4.subject = @meche;
////    text4.class0 = @"ME3233 Machine Design";
////    text4.name = @"Mechanical Design An Integrated Approach";
////    NSError *error3;
////    if (![self.managedObjectContext save:&error3])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error3 localizedDescription]);
////    }
////    Textbook *text5 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text5.subject = @meche;
////    text5.class0 = @"ME3233 Machine Design";
////    text5.name = @"Shigleys Mechanical Engineering Design 9th Edition";
////    NSError *error4;
////    if (![self.managedObjectContext save:&error4])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error4 localizedDescription]);
////    }
////    Textbook *text6 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text6.subject = @meche;
////    text6.class0 = @"ME3313 Fluid Mechanics";
////    text6.name = @"Fundamentals of Fluid Mechanics 6th Edition";
////    NSError *error5;
////    if (![self.managedObjectContext save:&error5])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error5 localizedDescription]);
////    }
////    Textbook *text7 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text7.subject = @meche;
////    text7.class0 = @"ME3333 Thermodynamics";
////    text7.name = @"Thermodynamics 7th Edition";
////    NSError *error6;
////    if (![self.managedObjectContext save:&error6])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error6 localizedDescription]);
////    }
////    Textbook *text8 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text8.subject = @meche;
////    text8.class0 = @"ME3413 Automatic Control";
////    text8.name = @"Modern Control Systems 11th Edition";
////    NSError *error7;
////    if (![self.managedObjectContext save:&error7])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error7 localizedDescription]);
////    }
////    Textbook *text9 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text9.subject = @meche;
////    text9.class0 = @"ME3513 Measurement Systems";
////    text9.name = @"Introduction to Mechatronics and Measurement Systems 4th Edition";
////    NSError *error8;
////    if (![self.managedObjectContext save:&error8])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error8 localizedDescription]);
////    }
////    Textbook *text10 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text10.subject = @meche;
////    text10.class0 = @"ME4214 Finite Element Modeling, Design and Analysis";
////    text10.name = @"A First Course in the Finite Element Methods 5th Edition";
////    NSError *error9;
////    if (![self.managedObjectContext save:&error9])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error9 localizedDescription]);
////    }
////    Textbook *text11 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text11.subject = @meche;
////    text11.class0 = @"ME4313 Heat Transfer Laboratory";
////    text11.name = @"Fundamentals of Heat and Mass Transfer 7th Edition";
////    NSError *error10;
////    if (![self.managedObjectContext save:&error10])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error10 localizedDescription]);
////    }
////    Textbook *text12 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text12.subject = @meche;
////    text12.class0 = @"ME6003 Applied Mathematics in Mechanical Engineering";
////    text12.name = @"Advanced Engineering Mathematics 2nd Edition";
////    NSError *error11;
////    if (![self.managedObjectContext save:&error11])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error11 localizedDescription]);
////    }
////    Textbook *text13 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text13.subject = @meche;
////    text13.class0 = @"ME6213 Introduction to Solid Mechanics";
////    text13.name = @"Advanced Mechanics of Materials 6th Edition";
////    NSError *error12;
////    if (![self.managedObjectContext save:&error12])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error12 localizedDescription]);
////    }
////    Textbook *text14 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text14.subject = @meche;
////    text14.class0 = @"MT2813 Introduction to Materials Science";
////    text14.name = @"Materials Science and Engineering: An Introduction 8th Edition";
////    NSError *error13;
////    if (![self.managedObjectContext save:&error13])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error13 localizedDescription]);
////    }
////}
////
////- (void)fillPhysics
////{
////    Textbook *text1 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text1.subject = @phy;
////    text1.class0 = @"PH1013 Mechanics";
////    text1.name = @"Physics for Scientists and Engineers 4th Edition";
////    NSError *error;
////    if (![self.managedObjectContext save:&error])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
////    }
////    Textbook *text2 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text2.subject = @phy;
////    text2.class0 = @"PH2023 Electricity Magnetism and Fluids";
////    text2.name = @"Physics for Scientists and Engineers 4th Edition";
////    NSError *error1;
////    if (![self.managedObjectContext save:&error1])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error1 localizedDescription]);
////    }
////    Textbook *text3 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text3.subject = @phy;
////    text3.class0 = @"PH2033 Waves Optics and Thermodynamics";
////    text3.name = @"Physics for Scientists and Engineers 4th Edition";
////    NSError *error2;
////    if (![self.managedObjectContext save:&error2])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error2 localizedDescription]);
////    }
////    Textbook *text4 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text4.subject = @phy;
////    text4.class0 = @"PH2104 Analytical Mechanics";
////    text4.name = @"Classical Mechanics";
////    NSError *error3;
////    if (![self.managedObjectContext save:&error3])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error3 localizedDescription]);
////    }
////    Textbook *text5 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text5.subject = @phy;
////    text5.class0 = @"PH3054 Introduction to Polymer Physics";
////    text5.name = @"Intro to Polymer Physics";
////    NSError *error4;
////    if (![self.managedObjectContext save:&error4])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error4 localizedDescription]);
////    }
////    Textbook *text6 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text6.subject = @phy;
////    text6.class0 = @"PH3234 Electricity and Magnetism";
////    text6.name = @"Intro to Electrodynamics 3rd Edition";
////    NSError *error5;
////    if (![self.managedObjectContext save:&error5])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error5 localizedDescription]);
////    }
////    Textbook *text7 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text7.subject = @phy;
////    text7.class0 = @"PH3614 Computational Physics";
////    text7.name = @"Computational Physics 2nd Edition";
////    NSError *error6;
////    if (![self.managedObjectContext save:&error6])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error6 localizedDescription]);
////    }
////    Textbook *text8 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text8.subject = @phy;
////    text8.class0 = @"PH4554 Solid State Physics";
////    text8.name = @"Introduction to Solid State Physics 8th Edition";
////    NSError *error7;
////    if (![self.managedObjectContext save:&error7])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error7 localizedDescription]);
////    }
////    Textbook *text9 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text9.subject = @phy;
////    text9.class0 = @"PH5553 Physics of Quantum Computing";
////    text9.name = @"Introduction to Quantum Computers";
////    NSError *error8;
////    if (![self.managedObjectContext save:&error8])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error8 localizedDescription]);
////    }
////    Textbook *text10 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                    inManagedObjectContext:self.managedObjectContext];
////    text10.subject = @phy;
////    text10.class0 = @"PH6673 Quantum Mechanics I";
////    text10.name = @"Quantum Mechanics - A Modern and Concise Introduction 2nd Edition";
////    NSError *error9;
////    if (![self.managedObjectContext save:&error9])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error9 localizedDescription]);
////    }
////    Textbook *text11 = [NSEntityDescription insertNewObjectForEntityForName:@"Textbook"
////                                                     inManagedObjectContext:self.managedObjectContext];
////    text11.subject = @phy;
////    text11.class0 = @"PH6673 Quantum Mechanics I";
////    text11.name = @"Introduction to Quantum Mechanics 2nd Edition";
////    NSError *error10;
////    if (![self.managedObjectContext save:&error10])
////    {
////        NSLog(@"Whoops, couldn't save: %@", [error10 localizedDescription]);
////    }
////}
//
//@end
