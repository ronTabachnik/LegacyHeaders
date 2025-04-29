//
//  AppStyleUtilities.h
//  Strauss
//
//  Created by Lior Shabo on 7/6/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define APP_COLOR_YELLOW [UIColor colorWithRed:255/255.0 green:229/255.0 blue:0/255.0 alpha:1.0]
#define APP_COLOR_RED [UIColor colorWithRed:207/255.0 green:33/255.0 blue:79/255.0 alpha:1.0]
#define APP_COLOR_GREEN [UIColor colorWithRed:31/255.0 green:134/255.0 blue:154/255.0 alpha:1.0]
#define APP_COLOR_BLUE [UIColor colorWithRed:3/255.0 green:124/255.0 blue:169/255.0 alpha:1.0]


@interface AppStyleUtilities : NSObject

+ (NSString*)regularFontName;
+ (NSString*)boldFontName;
+ (NSString*)semiBoldFontName;
+ (NSString*)lightFontName;
+ (NSString*)blackFontName;
+ (NSString*)mediumFontName;
+ (NSString*)thinFontName;
+ (NSString*)regularTitleFontName;
+ (NSString*)zeekrRegularFontName;
+ (NSString*)zeekrSemiBoldFontName;
+ (NSString*)zeekrLightFontName;
+ (NSString*)rubikRegularFontName;
+ (NSString*)helvaticaFontName;

@end
