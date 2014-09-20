//
//  RAFoob.m
//  FOOB
//
//  Created by Eric Webster on 2014-09-20.
//  Copyright (c) 2014 WAGE. All rights reserved.
//

#import "RAFoob.h"
#import <AFNetworking/AFNetworking.h>

@implementation RAFoob

//    NSString *number = @"+15195034679";

- (void)sendSMSToNumber:(NSString *)number message:(NSString *)message completion:(void (^)(BOOL success))completion;
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twilio.com"]];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"ACef266da6b48baf8671ea2baf6c2b1f38" password:@"3dc3dbc60091a2a9c9149687091b8e30"];
    
    NSDictionary *params = @{ @"From": @"+12268871449", @"To": number, @"Body": message };
    
    [manager POST:@"2010-04-01/Accounts/ACef266da6b48baf8671ea2baf6c2b1f38/Messages.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"%@", responseObject);
        if (completion) {
            completion(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
        if (completion) {
            completion(NO);
        }
    }];
}

@end
