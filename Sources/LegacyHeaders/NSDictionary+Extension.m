//
//  NSDictionary+Extension.m
//  MySupermarket
//
//  Created by Lior shabo on 5/27/14.
//  Copyright (c) 2014 poccaDot. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

-(BOOL) contains:(NSString*)key
{
    return [self objectForKey:key] != nil && (NSNull*)[self objectForKey:key] != [NSNull null];
}

@end
