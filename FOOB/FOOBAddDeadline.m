//
//  FOOBAddAlarm.m
//  FOOB
//
//  Created by Administrator on 9/20/14.
//  Copyright (c) 2014 WAGE. All rights reserved.
//

#import "FOOBAddDeadline.h"
#import <Parse/PFUser.h>

@interface FOOBAddDeadline () {
    NSDateFormatter *dateFormatter;
}

@end

@implementation FOOBAddDeadline

- (IBAction)dateChanged:(id)sender {
    self.dateLabel.text = [dateFormatter stringFromDate:self.deadlinePicker.date];
}
- (IBAction)getFOOB:(id)sender {
    //send to server
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    self.dateLabel.text = [dateFormatter stringFromDate:self.deadlinePicker.date];
    self.deadlineName.text = @"";
    self.clearsSelectionOnViewWillAppear = NO;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
}

-(void)hideKeyBoard {
    [self.deadlineName resignFirstResponder];
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



@end
