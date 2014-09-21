//
//  FOOBParse.m
//  FOOB
//
//  Created by Eric Webster on 2014-09-20.
//  Copyright (c) 2014 WAGE. All rights reserved.
//

#import "FOOBParse.h"

@implementation FOOBParse

+ (PFObject *)addDeadlineWithTitle:(NSString *)title date:(NSDate *)date phoneNumber:(NSString *)phoneNumber
{
    PFObject *testObject = [PFObject objectWithClassName:@"Deadline"];
    testObject[@"scheduledDate"] = [date description];
    testObject[@"title"] = title;
    testObject[@"phoneNumber"] = phoneNumber;
    testObject[@"username"] = [PFUser currentUser].username;
    [testObject saveEventually];
    return testObject;
}

+ (void)removeDeadlineWithObjectId:(NSString *)objectId
{
    PFQuery *query = [PFQuery queryWithClassName:@"Deadline"];
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *deadline, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        NSLog(@"%@", deadline);
        [deadline deleteEventually];
    }];
}

@end
