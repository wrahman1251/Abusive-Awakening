//
//  FOOBAddAlarm.m
//  FOOB
//
//  Created by Administrator on 9/20/14.
//  Copyright (c) 2014 WAGE. All rights reserved.
//

#import "FOOBAddDeadline.h"
#import "FOOBMasterViewController.h"
#import <Parse/PFUser.h>
#import "FOOBParse.h"

@interface FOOBAddDeadline ()

@property (nonatomic) CLLocation *location;
@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation FOOBAddDeadline

- (IBAction)dateChanged:(id)sender
{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateStyle:NSDateFormatterMediumStyle];
    [f setTimeStyle:NSDateFormatterShortStyle];
    
    self.dateLabel.text = [f stringFromDate:self.deadlinePicker.date];
}

- (void)findMe:(id)sender
{
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager startUpdatingLocation];
}

- (IBAction)getFOOB:(id)sender {
    //send to server
    
    NSArray *numbers = [self.phoneNumber.text componentsSeparatedByString:@","];
    
    UINavigationController *nav = (UINavigationController *)self.presentingViewController;
    FOOBMasterViewController *vc = (FOOBMasterViewController *)[nav.viewControllers firstObject];
    NSDate *date = [[NSDate date] dateByAddingTimeInterval:30];
    
    for (NSString *number in numbers) {
        NSString *moddedNumber = [@"+" stringByAppendingString:number];
        NSLog(@"%@", moddedNumber);
        PFObject *obj = [FOOBParse addDeadlineWithTitle:self.deadlineName.text date:date phoneNumber:moddedNumber];
        [[vc objects] addObject:obj];
    }
    
    [vc.tableView reloadData];
    
    /*
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *coords = @[@(self.location.coordinate.latitude), @(self.location.coordinate.longitude)];
    [defaults setObject:coords forKey:object.objectId];
    [defaults synchronize];
    */
    
    /*
     NSDate *now = [NSDate date];
    [FOOBParse addDeadlineWithTitle:@"BBBBBB" date:[now dateByAddingTimeInterval:20] phoneNumber:@"+15195034679"];
    [FOOBParse addDeadlineWithTitle:@"CCCCCC" date:[now dateByAddingTimeInterval:30] phoneNumber:@"+16476067399"];
    */
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateStyle:NSDateFormatterMediumStyle];
    [f setTimeStyle:NSDateFormatterShortStyle];
    
    self.dateLabel.text = [f stringFromDate:self.deadlinePicker.date];
    self.deadlineName.text = @"";
    self.clearsSelectionOnViewWillAppear = NO;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)];
    
    [self.view addGestureRecognizer:tapGesture];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (IBAction)exitModal:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = [locations lastObject];
    [manager stopUpdatingLocation];
}

@end
