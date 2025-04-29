//
//  NSObject+PerformBlockAfterDelay.m
//  MySuperMarketIOSApp
//
//  Created by Lior shabo on 6/29/14.
//  Copyright (c) 2014 mysupermarket. All rights reserved.
//

#import "NSObject+PerformBlockAfterDelay.h"

@implementation NSObject (PerformBlockAfterDelay)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:block
               afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}

@end
