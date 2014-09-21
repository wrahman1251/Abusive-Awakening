//
//  FOOBAddAlarm.h
//  FOOB
//
//  Created by Administrator on 9/20/14.
//  Copyright (c) 2014 WAGE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FOOBAddDeadline : UITableViewController 
@property (weak, nonatomic) IBOutlet UITextView *deadlineName;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *done;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancel;
@property (weak, nonatomic) IBOutlet UIDatePicker *deadlinePicker;


@end
