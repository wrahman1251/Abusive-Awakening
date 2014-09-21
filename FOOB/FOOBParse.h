//
//  FOOBParse.h
//  FOOB
//
//  Created by Eric Webster on 2014-09-20.
//  Copyright (c) 2014 WAGE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface FOOBParse : NSObject

+ (PFObject *)addDeadlineWithTitle:(NSString *)title date:(NSDate *)date phoneNumber:(NSString *)phoneNumber;
+ (void)removeDeadlineWithObjectId:(NSString *)objectId;

@end
