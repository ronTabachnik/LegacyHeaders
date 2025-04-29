//
//  UIButton+Extension.h
//  Strauss
//
//  Created by Lior Shabo on 3/16/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

- (void)centerVerticallyWithPadding:(float)padding;
- (void)centerImageAndButton:(CGFloat)gap imageOnTop:(BOOL)imageOnTop;
- (void)colorSubstring:(NSString*)substring color:(UIColor*)color;
- (void)underlineSubstring:(NSString*)substring color:(UIColor*)color;
- (void)underlineSubstring:(NSString*)substring color:(UIColor*)color state:(UIControlState)state;
- (void)setLineSpacing:(float)spacing;
- (void)fontSubstring:(NSString*)substring font:(UIFont*)font;

@end
