//
//  FOOBAddAlarm.h
//  FOOB
//
//  Created by Administrator on 9/20/14.
//  Copyright (c) 2014 WAGE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FOOBAddDeadline : UITableViewController<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *deadlineName;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *done;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancel;
@property (weak, nonatomic) IBOutlet UIDatePicker *deadlinePicker;

- (IBAction)findMe:(id)sender;

@end
