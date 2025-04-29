//
//  UILabel+Extension.m
//  Zaparoot
//
//  Created by ykm dev on 2/24/14.
//  Copyright (c) 2014 ykm dev. All rights reserved.
//

#import "UILabel+Extension.h"
#import "AppStyleUtilities.h"

@implementation UILabel (Extension)

- (void)boldRange:(NSRange)range color:(UIColor*)color
{
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:[AppStyleUtilities boldFontName] size:self.font.pointSize] /*[UIFont boldSystemFontOfSize:self.font.pointSize]*/,
                                    NSForegroundColorAttributeName:color} range:range];
    self.attributedText = attributedText;
}

- (void)boldSubstring:(NSString*)substring color:(UIColor*)color
{
    NSRange range = [self.text rangeOfString:substring];
    [self boldRange:range color:color];
}

- (void)underlineRange:(NSRange)range color:(UIColor*)color
{
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }
    [attributedText setAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                                    NSForegroundColorAttributeName:color} range:range];
    self.attributedText = attributedText;
}

- (void)underlineSubstring:(NSString*)substring color:(UIColor*)color
{
    NSRange range = [self.text rangeOfString:substring];
    [self underlineRange:range color:color];
}

- (void)colorRange:(NSRange)range color:(UIColor*)color
{
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }
    [attributedText setAttributes:@{NSForegroundColorAttributeName:color} range:range];
    self.attributedText = attributedText;
}

- (void)colorSubstring:(NSString*)substring color:(UIColor*)color
{
    NSRange range = [self.text rangeOfString:substring];
    [self colorRange:range color:color];
}

- (void)setFontAttribute:(UIFont*)font
{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [attr length])];
    self.attributedText = attr;
}

- (void)strikeRange:(NSRange)range color:(UIColor*)color
{
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }
    
    [attributedText addAttribute:NSStrikethroughStyleAttributeName
                            value:@1
                            range:range];
    
    [attributedText addAttributes:@{NSForegroundColorAttributeName:color} range:range];
    self.attributedText = attributedText;
}

- (void)strikeSubstring:(NSString*)substring color:(UIColor*)color
{
    NSRange range = [self.text rangeOfString:substring];
    [self strikeRange:range color:color];
}

- (void)fontRange:(NSRange)range font:(UIFont*)font
{
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }
    
    [attributedText addAttributes:@{NSFontAttributeName:font} range:range];
    self.attributedText = attributedText;
}

- (void)fontSubstring:(NSString*)substring font:(UIFont*)font
{
    NSArray *results = [self rangesOfString:substring inString:self.text];
    for (int i = 0; i < results.count; i++) {
        [self fontRange:[results[i] rangeValue] font:font];
    }
    //NSRange range = [self.text rangeOfString:substring];
}

- (void)lineSpacing:(int)space
{
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }
    
    [attributedText addAttribute:NSKernAttributeName value:@(space) range:NSMakeRange(0, attributedText.length)];
    self.attributedText = attributedText;
}

/*- (void)setLineSpacing:(float)spacing
{
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }
    
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setLineSpacing:spacing];
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, [self.attributedText length])];
    
    self.attributedText = attributedText;
}*/

- (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str {
    NSMutableArray *results = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, [str length]);
    NSRange range;
    while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        [results addObject:[NSValue valueWithRange:range]];
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
    }
    return results;
}

@end
