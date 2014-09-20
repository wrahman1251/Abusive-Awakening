//
//  RAFoob.h
//  FOOB
//
//  Created by Eric Webster on 2014-09-20.
//  Copyright (c) 2014 WAGE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAFoob : NSObject

- (void)sendSMSToNumber:(NSString *)number message:(NSString *)message completion:(void (^)(BOOL))completion;

@end
