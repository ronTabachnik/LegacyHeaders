//
//  UIButton+Extension.m
//  Strauss
//
//  Created by Lior Shabo on 3/16/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (void)centerVerticallyWithPadding:(float)padding
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + padding);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height),
                                            0.0f,
                                            0.0f,
                                            - titleSize.width);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                            - imageSize.width,
                                            - (totalHeight - titleSize.height),
                                            0.0f);
    
}

- (void)centerImageAndButton:(CGFloat)gap imageOnTop:(BOOL)imageOnTop {
    NSInteger sign = imageOnTop ? 1 : -1;
    
    CGSize imageSize = self.imageView.frame.size;
    self.titleEdgeInsets = UIEdgeInsetsMake((imageSize.height+gap + 2)*sign, -imageSize.width, 0, 0);
    
    CGSize titleSize = self.titleLabel.bounds.size;
    self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height+gap)*sign, 0, 0, -titleSize.width);
    
}

- (void)colorRange:(NSRange)range color:(UIColor*)color
{
    if (![self respondsToSelector:@selector(setAttributedTitle:forState:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (![self attributedTitleForState:UIControlStateNormal]) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:[self attributedTitleForState:UIControlStateNormal]];
    }
    [attributedText setAttributes:@{NSForegroundColorAttributeName:color} range:range];
    [self setAttributedTitle:attributedText forState:UIControlStateNormal];
}

- (void)colorSubstring:(NSString*)substring color:(UIColor*)color
{
    NSRange range = [self.titleLabel.text rangeOfString:substring];
    [self colorRange:range color:color];
}

- (void)underlineRange:(NSRange)range color:(UIColor*)color state:(UIControlState)state
{
    if (![self respondsToSelector:@selector(setAttributedTitle:forState:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (![self attributedTitleForState:state]) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:[self attributedTitleForState:UIControlStateNormal]];
    }
    [attributedText setAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                                    NSForegroundColorAttributeName:color} range:range];
    [self setAttributedTitle:attributedText forState:state];
}

- (void)underlineSubstring:(NSString*)substring color:(UIColor*)color
{
    NSRange range = [self.currentTitle rangeOfString:substring];
    [self underlineRange:range color:color state:UIControlStateNormal];
}

- (void)underlineSubstring:(NSString*)substring color:(UIColor*)color state:(UIControlState)state
{
    NSRange range = [self.currentTitle rangeOfString:substring];
    [self underlineRange:range color:color state:state];
}

- (void)setLineSpacing:(float)spacing
{
    if (![self respondsToSelector:@selector(setAttributedTitle:forState:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (![self attributedTitleForState:UIControlStateNormal]) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:[self attributedTitleForState:UIControlStateNormal]];
    }
    
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setLineSpacing:spacing];
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, [self.titleLabel.text length])];
    
    [self setAttributedTitle:attributedText forState:UIControlStateNormal];
}

- (void)fontRange:(NSRange)range font:(UIFont*)font
{
    if (![self respondsToSelector:@selector(setAttributedTitle:forState:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (![self attributedTitleForState:UIControlStateNormal]) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:[self attributedTitleForState:UIControlStateNormal]];
    }
    
    [attributedText addAttributes:@{NSFontAttributeName:font} range:range];
    [self setAttributedTitle:attributedText forState:UIControlStateNormal];
}

- (void)fontSubstring:(NSString*)substring font:(UIFont*)font
{
    NSRange range = [self.currentTitle rangeOfString:substring];
    [self fontRange:range font:font];
}

@end
