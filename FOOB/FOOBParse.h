//
//  FOOBParse.h
//  FOOB
//
//  Created by Eric Webster on 2014-09-20.
//  Copyright (c) 2014 WAGE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FOOBParse : NSObject

+ (void)addDeadlineWithTitle:(NSString *)title date:(NSDate *)date phoneNumber:(NSString *)phoneNumber;
+ (void)removeDeadlineWithObjectId:(NSString *)objectId;

@end
