//
//  UIFont+Dynamic.h
//  Strauss
//
//  Created by Lior Shabo on 8/5/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Dynamic)

+(UIFont *)appFontWithStyle:(NSString *)style size:(float)size;
+(UIFont *)appFontWithSize:(float)size;
+(UIFont *)appBoldFontWithStyle:(NSString *)style size:(float)size;
+(UIFont *)appBoldFontWithSize:(float)size;
+(UIFont *)appSemiBoldFontWithStyle:(NSString *)style size:(float)size;
+(UIFont *)appSemiBoldFontWithSize:(float)size;
+(UIFont *)appBlackFontWithStyle:(NSString *)style size:(float)size;
+(UIFont *)appBlackFontWithSize:(float)size;
+(UIFont *)appThinFontWithStyle:(NSString *)style size:(float)size;
+(UIFont *)appThinFontWithSize:(float)size;
+(UIFont *)appMediumFontWithStyle:(NSString *)style size:(float)size;
+(UIFont *)appMediumFontWithSize:(float)size;
+(UIFont *)appLightFontWithStyle:(NSString *)style size:(float)size;
+(UIFont *)appLightFontWithSize:(float)size;
+(UIFont *)appZeekrRegularFontWithStyle:(NSString *)style size:(float)size;
+(UIFont *)appZeekrRegularFontWithSize:(float)size;
+(UIFont *)appZeekrSemiBoldFontWithStyle:(NSString *)style size:(float)size;
+(UIFont *)appZeekrSemiBoldFontWithSize:(float)size;
+(UIFont *)appZeekrLightFontWithStyle:(NSString *)style size:(float)size;
+(UIFont *)appZeekrLightFontWithSize:(float)size;
+(UIFont *)appRubikRegularFontWithStyle:(NSString *)style size:(float)size;
+(UIFont *)appRubikRegularFontWithSize:(float)size;
+(UIFont *)appHelvaticaFontWithStyle:(NSString *)style size:(float)size;
+(UIFont *)appHelvaticaFontWithSize:(float)size;
@end
