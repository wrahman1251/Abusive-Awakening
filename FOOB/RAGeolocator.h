//
//  RAGeolocator.h
//  FOOB
//
//  Created by Eric Webster on 2014-09-20.
//  Copyright (c) 2014 WAGE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef enum _RAGeolocatorState : int16_t {
    
    RAGeolocatorStateInside,
    RAGeolocatorStateOutside,
    RAGeolocatorStateUnknown
    
} RAGeolocatorState;

@class RAGeolocator;

@protocol RAGeolocatorDelegate

- (void)geolocator:(RAGeolocator *)geolocator receivedMapItems:(NSArray *)mapItems;
- (void)geolocator:(RAGeolocator *)geolocator didChangeState:(RAGeolocatorState)state;

@end

@interface RAGeolocator : NSObject<CLLocationManagerDelegate>

@property (nonatomic, weak) id<RAGeolocatorDelegate> delegate;
@property (nonatomic, readonly) RAGeolocatorState state;

- (void)fetchMapItemsForSearchQuery:(NSString *)query;
- (void)registerHomeAtLocation:(CLLocation *)location;

@end
