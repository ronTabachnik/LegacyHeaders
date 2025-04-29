//
//  UILabel+Extension.h
//  Zaparoot
//
//  Created by ykm dev on 2/24/14.
//  Copyright (c) 2014 ykm dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

- (void)boldSubstring:(NSString*)substring color:(UIColor*)color;
- (void)underlineSubstring:(NSString*)substring color:(UIColor*)color;
- (void)colorSubstring:(NSString*)substring color:(UIColor*)color;
- (void)setFontAttribute:(UIFont*)font;
- (void)strikeSubstring:(NSString*)substring color:(UIColor*)color;
- (void)fontSubstring:(NSString*)substring font:(UIFont*)font;
- (void)lineSpacing:(int)space;

@end
