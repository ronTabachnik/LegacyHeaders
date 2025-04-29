//
//  UIFontDescriptor+Dynamic.h
//  Strauss
//
//  Created by Lior Shabo on 8/5/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const ANUIFontTextStyleCaption3;
extern NSString *const ANUIFontTextStyleCaption4;

@interface UIFontDescriptor (Dynamic)

+(UIFontDescriptor *)preferredAppFontDescriptorWithStyle:(NSString *)style;
+(UIFontDescriptor *)preferredAppBoldFontDescriptorWithStyle:(NSString *)style;

@end
