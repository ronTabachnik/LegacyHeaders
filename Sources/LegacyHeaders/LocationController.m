//
//  LocationController.m
//  eldan2
//
//  Created by YKM on 7/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LocationController.h"

@interface LocationController()
@property(nonatomic,strong) NSMutableSet *listenerArray;
@property (nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation LocationController

NSString* const LOCATION_ALERT_KEY = @"locationAlert";
NSString* const NOTIFICATION_LOCATION_UPDATED = @"NOTIFICATION_LOCATION_UPDATED";

+(void) initialize
{
    
}

+(LocationController*) sharedManager
{
    static LocationController *sharedManagerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}

-(id)init
{
	if(self = [super init]) {
		self.locationManager = [[CLLocationManager alloc] init];
		self.locationManager.distanceFilter = 0;
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        self.locationManager.delegate = self;
        if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        self.listenerArray = [[NSMutableSet alloc] init];
	}
	return self;
}

-(BOOL) isLocationServicesEnabled
{
    if(![CLLocationManager locationServicesEnabled] ||
       [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    }
	else {
        return YES;
	}
}

-(void) addListener:(id<LocationControllerDelegate>)listener
{
    @synchronized(self)
    {
        [self.listenerArray addObject:listener];
        if([self.listenerArray count] > 0) {
            [self.locationManager startUpdatingLocation];
        }
    }
}

-(void) removeListener:(id<LocationControllerDelegate>)listener
{
    @synchronized(self)
    {
        [self.listenerArray removeObject:listener];
        if([self.listenerArray count] == 0) {
            [self.locationManager stopUpdatingLocation];
        }
    }
}

-(NSMutableSet*) syncronizedArray
{
    NSMutableSet *set = nil;
    @synchronized(self)
    {
        set = [[NSMutableSet alloc] initWithSet:self.listenerArray];
    }
    return set;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    /*CLLocation *oldLocation;
    if (locations.count > 1) {
        oldLocation = [locations objectAtIndex:locations.count-2];
    } else {
        oldLocation = nil;
    }*/
    
    // test the age of the location measurement to determine if the measurement is cached
    // in most cases you will not want to rely on cached measurements
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 10.0) return;
    
    // test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0) return;
    if (newLocation.coordinate.latitude == 0 && newLocation.coordinate.longitude == 0) return;
    
    NSLog(@"latitude=%f, longitude=%f, horizontalAccuracy=%f", newLocation.coordinate.latitude, newLocation.coordinate.longitude, newLocation.horizontalAccuracy);
    self.currentLocation = newLocation;
    
    NSMutableSet *listeners = [self syncronizedArray];
    for(id<LocationControllerDelegate> listener in listeners) {
        [listener locationController:self didReciveLocation:self.currentLocation];
    }
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"locationManager:%@ didFailWithError:%@", manager, error);
    
    NSMutableSet *listeners = [self syncronizedArray];
    for(id<LocationControllerDelegate> listener in listeners) {
        [listener locationController:self dataDidFailed:@"error location"];
    }
}

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
//    switch (status) {
//        case kCLAuthorizationStatusAuthorizedAlways:
//            break;
//        case kCLAuthorizationStatusAuthorizedWhenInUse:
//        break;
//        default:
//            break;
//    }
    NSMutableSet *listeners = [self syncronizedArray];
    for(id<LocationControllerDelegate> listener in listeners) {
        if ([listener respondsToSelector:@selector(locationController:didChangeAuthorizationStatus:)]){
            [listener locationController:self didChangeAuthorizationStatus:status];
        }
    }
}

-(void) dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
	[self.locationManager stopUpdatingLocation];
}

@end
