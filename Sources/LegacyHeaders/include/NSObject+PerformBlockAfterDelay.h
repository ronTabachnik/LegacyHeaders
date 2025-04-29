//
//  NSObject+PerformBlockAfterDelay.h
//  MySuperMarketIOSApp
//
//  Created by Lior shabo on 6/29/14.
//  Copyright (c) 2014 mysupermarket. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformBlockAfterDelay)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
