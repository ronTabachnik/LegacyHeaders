//
//  UIFont+Dynamic.m
//  Strauss
//
//  Created by Lior Shabo on 8/5/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import "UIFont+Dynamic.h"
#import "UIFontDescriptor+Dynamic.h"
#import "AppStyleUtilities.h"

@implementation UIFont (Dynamic)

+(UIFont *)appFontWithStyle:(NSString *)style size:(float)size
{
    UIFont *font = [UIFont fontWithName:[AppStyleUtilities regularFontName] size:size + 2];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:(UIFontTextStyle)style];
    UIFont *scaledFont = [fontMetrics scaledFontForFont:font maximumPointSize:1.4 * size];
    return scaledFont;
}

+(UIFont *)appFontWithSize:(float)size{
    return [self appFontWithStyle:UIFontTextStyleSubheadline size:size + 2];
}

+ (CGFloat)limitFontSize:(CGFloat)size style:(UIFontTextStyle)style
{
    static NSDictionary *textStyles;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        textStyles = @{UIFontTextStyleHeadline: @(20),
                       UIFontTextStyleSubheadline: @(18),
                       UIFontTextStyleBody: @(17),
                       UIFontTextStyleFootnote: @(16),
                       UIFontTextStyleCaption1: @(15),
                       UIFontTextStyleCaption2: @(14)};
    });
    
    float maxSize = [textStyles[style] floatValue];
    return MIN(size, maxSize);
}

+(UIFont *)appBoldFontWithStyle:(NSString *)style size:(float)size
{
    UIFont *font = [UIFont fontWithName:[AppStyleUtilities boldFontName] size:size + 2];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:(UIFontTextStyle)style];
    UIFont *scaledFont = [fontMetrics scaledFontForFont:font maximumPointSize:1.4 * size];
    return scaledFont;
}

+(UIFont *)appBoldFontWithSize:(float)size{
    return [self appBoldFontWithStyle:UIFontTextStyleSubheadline size:size + 2];
}

+(UIFont *)appSemiBoldFontWithStyle:(NSString *)style size:(float)size
{
    UIFont *font = [UIFont fontWithName:[AppStyleUtilities semiBoldFontName] size:size + 2];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:(UIFontTextStyle)style];
    UIFont *scaledFont = [fontMetrics scaledFontForFont:font maximumPointSize:1.4 * size];
    return scaledFont;
}

+(UIFont *)appSemiBoldFontWithSize:(float)size{
    return [self appSemiBoldFontWithStyle:UIFontTextStyleSubheadline size:size + 2];
}

+(UIFont *)appBlackFontWithStyle:(NSString *)style size:(float)size
{
    UIFont *font = [UIFont fontWithName:[AppStyleUtilities blackFontName] size:size + 2];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:(UIFontTextStyle)style];
    UIFont *scaledFont = [fontMetrics scaledFontForFont:font maximumPointSize:1.4 * size];
    return scaledFont;
}

+(UIFont *)appBlackFontWithSize:(float)size{
    return [self appBlackFontWithStyle:UIFontTextStyleSubheadline size:size + 2];
}

+(UIFont *)appThinFontWithStyle:(NSString *)style size:(float)size
{
    UIFont *font = [UIFont fontWithName:[AppStyleUtilities thinFontName] size:size + 2];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:(UIFontTextStyle)style];
    UIFont *scaledFont = [fontMetrics scaledFontForFont:font maximumPointSize:1.4 * size];
    return scaledFont;
}

+(UIFont *)appThinFontWithSize:(float)size{
    return [self appThinFontWithStyle:UIFontTextStyleSubheadline size:size + 2];
}

+(UIFont *)appMediumFontWithStyle:(NSString *)style size:(float)size
{
    UIFont *font = [UIFont fontWithName:[AppStyleUtilities mediumFontName] size:size + 2];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:(UIFontTextStyle)style];
    UIFont *scaledFont = [fontMetrics scaledFontForFont:font maximumPointSize:1.4 * size];
    return scaledFont;
}

+(UIFont *)appHelvaticaFontWithStyle:(NSString *)style size:(float)size
{
    UIFont *font = [UIFont fontWithName:[AppStyleUtilities helvaticaFontName] size:size + 2];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:(UIFontTextStyle)style];
    UIFont *scaledFont = [fontMetrics scaledFontForFont:font maximumPointSize:1.4 * size];
    return scaledFont;
}

+(UIFont *)appHelvaticaFontWithSize:(float)size{
    return [self appHelvaticaFontWithStyle:UIFontTextStyleSubheadline size:size + 2];
}

+(UIFont *)appMediumFontWithSize:(float)size{
    return [self appMediumFontWithStyle:UIFontTextStyleSubheadline size:size + 2];
}

+(UIFont *)appLightFontWithStyle:(NSString *)style size:(float)size
{
    UIFont *font = [UIFont fontWithName:[AppStyleUtilities lightFontName] size:size + 2];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:(UIFontTextStyle)style];
    UIFont *scaledFont = [fontMetrics scaledFontForFont:font maximumPointSize:1.4 * size];
    return scaledFont;
}

+(UIFont *)appLightFontWithSize:(float)size{
    return [self appLightFontWithStyle:UIFontTextStyleSubheadline size:size + 2];
}

+(UIFont *)appZeekrRegularFontWithStyle:(NSString *)style size:(float)size
{
    UIFont *font = [UIFont fontWithName:[AppStyleUtilities zeekrRegularFontName] size:size + 2];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:(UIFontTextStyle)style];
    UIFont *scaledFont = [fontMetrics scaledFontForFont:font maximumPointSize:1.4 * size];
    return scaledFont;
}

+(UIFont *)appZeekrRegularFontWithSize:(float)size{
    return [self appZeekrRegularFontWithStyle:UIFontTextStyleSubheadline size:size + 2];
}

+(UIFont *)appZeekrSemiBoldFontWithStyle:(NSString *)style size:(float)size
{
    UIFont *font = [UIFont fontWithName:[AppStyleUtilities zeekrSemiBoldFontName] size:size + 2];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:(UIFontTextStyle)style];
    UIFont *scaledFont = [fontMetrics scaledFontForFont:font maximumPointSize:1.4 * size];
    return scaledFont;
}

+(UIFont *)appZeekrSemiBoldFontWithSize:(float)size{
    return [self appZeekrSemiBoldFontWithStyle:UIFontTextStyleSubheadline size:size + 2];
}

+(UIFont *)appZeekrLightFontWithStyle:(NSString *)style size:(float)size
{
    UIFont *font = [UIFont fontWithName:[AppStyleUtilities zeekrLightFontName] size:size + 2];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:(UIFontTextStyle)style];
    UIFont *scaledFont = [fontMetrics scaledFontForFont:font maximumPointSize:1.4 * size];
    return scaledFont;
}

+(UIFont *)appZeekrLightFontWithSize:(float)size{
    return [self appZeekrLightFontWithStyle:UIFontTextStyleSubheadline size:size + 2];
}

+(UIFont *)appRubikRegularFontWithStyle:(NSString *)style size:(float)size
{
    UIFont *font = [UIFont fontWithName:[AppStyleUtilities rubikRegularFontName] size:size + 2];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:(UIFontTextStyle)style];
    UIFont *scaledFont = [fontMetrics scaledFontForFont:font maximumPointSize:1.4 * size];
    return scaledFont;
}

+(UIFont *)appRubikRegularFontWithSize:(float)size{
    return [self appRubikRegularFontWithStyle:UIFontTextStyleSubheadline size:size + 2];
}

+ (void)describePreferredFonts
{
    static NSArray *textStyles;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        textStyles = @[UIFontTextStyleHeadline,//17
                       UIFontTextStyleSubheadline,//15
                       UIFontTextStyleBody,//17
                       UIFontTextStyleFootnote,//13
                       UIFontTextStyleCaption1,//12
                       UIFontTextStyleCaption2];//11
    });
    
    for (NSString *textStyle in textStyles)
    {
        UIFont *font = [UIFont preferredFontForTextStyle:textStyle];
        NSLog(@"\n%@\n%@ %@", textStyle, font.fontName, font);
    }
}


@end
