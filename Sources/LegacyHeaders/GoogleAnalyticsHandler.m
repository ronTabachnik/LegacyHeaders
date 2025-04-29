////
////  GoogleAnalyticsHandler.m
////  MySupermarket
////
////  Created by poccaDot on 6/15/14.
////  Copyright (c) 2014 poccaDot. All rights reserved.
////
//
////#import "GoogleAnalyticsHandler.h"
//#import "NSDictionary+Extension.h"
//#import "Zeekr-Swift.h"
//
//@implementation GoogleAnalyticsHandler
//
////@synthesize tracker;
//
//+ (id)sharedInstance
//{
//    //  Static local predicate must be initialized to 0
//    static GoogleAnalyticsHandler *sharedInstance = nil;
//    static dispatch_once_t onceToken = 0;
//    dispatch_once(&onceToken, ^{
//        sharedInstance = [[GoogleAnalyticsHandler alloc] init];
//        
//        //[GAI sharedInstance].trackUncaughtExceptions = NO;
//        //[[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelNone];
//        //[GAI sharedInstance].dispatchInterval = 30;
//        
//        //sharedInstance.tracker = [[GAI sharedInstance] trackerWithTrackingId:[ActiveSessionManager getInstance].analyticsKey];
//    });
//    return sharedInstance;
//}
//
//- (void)sendGAEventWithCategory:(NSString *)category Action:(NSString *)action Label:(NSString *)label andValue:(int)value
//{
//    [self sendGAEventWithCategory:category Action:action Label:label andValue:value withProperties:@{}];
//}
//
//- (void)sendGAEventWithCategory:(NSString *)category Action:(NSString *)action Label:(NSString *)label andValue:(int)value withProperties:(NSDictionary *)properties
//{
//    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive ||
//        [[UIApplication sharedApplication] applicationState] == UIApplicationStateInactive) {
//        
//        
//        NSMutableDictionary *dic = @{
//                                     /*@"category": category,
//                                     @"label": label,
//                                     @"value": [NSString stringWithFormat:@"%d", value],*/
//                                     }.mutableCopy;
//        if (properties != nil) {
//            [dic addEntriesFromDictionary:properties];
//        }
//        
//        [FIRAnalytics logEventWithName:action parameters:dic];
//        
//        //[tracker send:[[GAIDictionaryBuilder createEventWithCategory:category action:action label:label value:[NSNumber numberWithInt:value]] build]];
//    }
//}
//
//- (void)sendGAEventWithEventName:(NSString *)eventName withProperties:(NSDictionary *)properties
//{
//    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive ||
//        [[UIApplication sharedApplication] applicationState] == UIApplicationStateInactive) {
//        
//        NSMutableDictionary *dic = @{}.mutableCopy;
//        if (properties != nil) {
//            [dic addEntriesFromDictionary:properties];
//        }
//        
//        [FIRAnalytics logEventWithName:eventName parameters:dic];
//    }
//}
//
//- (void)setUserProperty:(NSString*)property value:(NSString*)value
//{
//    @try {
//        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
//            [FIRAnalytics setUserPropertyString:value forName:property];
//        }
//    }
//    @catch (NSException *exception) {
//    }
//    @finally {
//    }
//}
//
//- (void)trackPageView:(NSString*)pageName
//{
//    [self trackPageView:pageName pageUrl:@""];
//}
//
//- (void)trackPageView:(NSString*)pageName pageUrl:(NSString*)pageUrl
//{
//    /*@try {
//        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
//            if(pageUrl==nil||pageUrl.length==0) {
//                [tracker send:[[[GAIDictionaryBuilder createScreenView] set:pageName forKey:kGAIScreenName] build]];
//            }
//            else {
//                [tracker send:[[[GAIDictionaryBuilder createScreenView] set:pageUrl forKey:kGAIScreenName] build]];
//            }
//        }
//    }
//    @catch (NSException *exception) {
//    }
//    @finally {
//    }*/
//}
//
//- (void)trackPageView:(NSString*)pageName pageClass:(NSString*)pageClass
//{
//    @try {
//        pageClass = [pageClass stringByReplacingOccurrencesOfString:@"BuyMe." withString:@""];
//        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
//            [FIRAnalytics logEventWithName:kFIREventScreenView parameters: @{kFIRParameterScreenName: pageName
//                                                                             ,kFIRParameterScreenClass: pageClass}];
//            //[self trackPageView:pageName pageUrl:nil];
//        }
//    }
//    @catch (NSException *exception) {
//    }
//    @finally {
//    }
//}
//
//- (void)purchaseCompleted:(NSString*)transactionId name:(NSString*)name sku:(NSString*)sku category:(NSString*)category price:(NSNumber*)price quantity:(NSInteger)quantity currencyCode:(NSString*)currencyCode {
//    
//    /*[tracker send:[[GAIDictionaryBuilder createTransactionWithId:transactionId             // (NSString) Transaction ID
//                                                     affiliation:@"In-app Store"         // (NSString) Affiliation
//                                                         revenue:price                  // (NSNumber) Order revenue (including tax and shipping)
//                                                             tax:@0                  // (NSNumber) Tax
//                                                        shipping:@0                      // (NSNumber) Shipping
//                                                    currencyCode:currencyCode] build]];        // (NSString) Currency code
//    
//
//    
//    [tracker send:[[GAIDictionaryBuilder createItemWithTransactionId:transactionId         // (NSString) Transaction ID
//                                                                name:name  // (NSString) Product Name
//                                                                 sku:sku            // (NSString) Product SKU
//                                                            category:category  // (NSString) Product category
//                                                               price:price               // (NSNumber) Product price
//                                                            quantity:@(quantity)                  // (NSInteger) Product quantity
//                                                        currencyCode:currencyCode] build]];    // (NSString) Currency code*/
//}
//
//@end
