//
//  LocationController.h
//  eldan2
//
//  Created by YKM on 7/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationControllerDelegate;

extern NSString* const NOTIFICATION_LOCATION_UPDATED;

@interface LocationController : NSObject<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocation *currentLocation;

+(LocationController*) sharedManager;
-(void)addListener:(id<LocationControllerDelegate>)listener;
-(void) removeListener:(id<LocationControllerDelegate>)listener;

@end

@protocol LocationControllerDelegate<NSObject>
@required
-(void) locationController:(LocationController *)manager dataDidFailed:(NSString*)error;
-(void) locationController:(LocationController *)manager didReciveLocation:(CLLocation *)location;
@optional
-(void) locationController:(LocationController *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
@end
