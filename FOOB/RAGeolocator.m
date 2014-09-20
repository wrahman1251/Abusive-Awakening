//
//  RAGeolocator.m
//  FOOB
//
//  Created by Eric Webster on 2014-09-20.
//  Copyright (c) 2014 WAGE. All rights reserved.
//

#import "RAGeolocator.h"
#import <MapKit/MapKit.h>

@interface RAGeolocator ()

@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation RAGeolocator

- (CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

- (void)fetchMapItemsForSearchQuery:(NSString *)query;
{
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = query;
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
        [self.delegate geolocator:self receivedMapItems:response.mapItems];
    }];
}

- (void)registerHomeAtLocation:(CLLocation *)location
{
    CLRegion *region = [[CLCircularRegion alloc] initWithCenter:location.coordinate radius:20 identifier:@"my_home"];
    [self.locationManager startMonitoringForRegion:region];
}

#pragma mark - CLLocationDelegate

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    [manager requestStateForRegion:region];
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    if ([CLLocationManager respondsToSelector:@selector(isMonitoringAvailableForClass:)]) {
        if (![CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
            NSLog(@"Can't do it");
            return;
        }
    }
    
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted) {
        //You need to authorize Location Services for the APP
        NSLog(@"Location services disabled");
        return;
    }
    
    [manager performSelectorOnMainThread:@selector(startMonitoringForRegion:) withObject:region waitUntilDone:NO];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted) {
        //You need to authorize Location Services for the APP
        NSLog(@"Location services disabled");
        return;
    }
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    switch (state) {
        case CLRegionStateInside:
            _state = RAGeolocatorStateInside;
            break;
        case CLRegionStateOutside:
            _state = RAGeolocatorStateOutside;
            break;
        case CLRegionStateUnknown:
            _state = RAGeolocatorStateUnknown;
            break;
            
        default:
            break;
    }
    [self.delegate geolocator:self didChangeState:self.state];
}

/*
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{

}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    
}
*/

@end
