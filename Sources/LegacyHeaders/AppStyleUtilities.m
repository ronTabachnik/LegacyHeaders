//
//  AppStyleUtilities.m
//  Strauss
//
//  Created by Lior Shabo on 7/6/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import "AppStyleUtilities.h"

@implementation AppStyleUtilities

+ (NSString*)regularFontName
{
    /*NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }*/
    
    if(UIAccessibilityIsBoldTextEnabled()) {
        return @"AlmoniNeueDL4.0AAA-Bold";
    }
    return @"AlmoniNeueDL4.0AAA-Regular";
}

+ (NSString*)boldFontName
{
    return @"AlmoniNeueDL4.0AAA-Bold";
}

+ (NSString*)semiBoldFontName
{
    return @"AlmoniNeueDL4.0AAA-D-Bold";
}

+ (NSString*)blackFontName
{
    return @"AlmoniNeueDL4.0AAA-Black";
}

+ (NSString*)mediumFontName
{
    return @"AlmoniNeueDL4.0AAA-Medium";
}

+ (NSString*)helvaticaFontName
{
    return @"Helvetica";
}

+ (NSString*)lightFontName
{
    return @"AlmoniNeueDL4.0AAA-Light";
}

+ (NSString*)thinFontName
{
    return @"AlmoniNeueDL4.0AAA-Thin";
}

+ (NSString*)zeekrRegularFontName
{
    return @"LynkcoType-Regular";
}

+ (NSString*)zeekrSemiBoldFontName
{
    return @"LynkcoType-Medium";
}

+ (NSString*)zeekrLightFontName
{
    return @"LynkcoType-Light";
}

+ (NSString*)rubikRegularFontName
{
    return @"AlmoniNeueDL4.0AAA-Regular";
}

@end
