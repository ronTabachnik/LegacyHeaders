//
//  OSTextField.m
//  Strauss
//
//  Created by Lior Shabo on 3/16/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import "OSTextField.h"
#import "AppStyleUtilities.h"
#import "Masonry.h"
#import "UIView-Extensions.h"
#import "NSObject+PerformBlockAfterDelay.h"

@implementation OSTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initControl];
        self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initControl];
        self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.lblPlaceholder setOrigin:CGPointMake(self.width-self.lblPlaceholder.width-_edgeInsets.right, -5)];
    self.error.frame = CGRectMake(0, self.bounds.size.height+1, self.bounds.size.width+5, 1);
}

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)initControl
{
    [self setClipsToBounds:NO];
    
    self.lblPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 16)];
    [self.lblPlaceholder setHidden:YES];
    self.lblPlaceholder.textAlignment = NSTextAlignmentRight;
    self.lblPlaceholder.backgroundColor = [UIColor clearColor];
    [self.lblPlaceholder setFont:[UIFont fontWithName:[AppStyleUtilities regularFontName] size:12]];
    self.lblPlaceholder.textColor = [UIColor lightGrayColor];
    [self.lblPlaceholder setText:self.placeholder];
    [self addSubview:self.lblPlaceholder];
    [self.lblPlaceholder sizeToFit];
    
    self.error = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height+1, self.bounds.size.width+5, 1)];
    self.error.backgroundColor = [UIColor colorWithRed:50/255.0 green:58/255.0 blue:72/255.0 alpha:1.0];
    self.error.alpha = 0;
    [self addSubview:self.error];
    
    if (@available(iOS 14.0, *)) {
        if (self.background != nil) {
            [self setBorderStyle:UITextBorderStyleLine];
        }
    }
    
    /*[self.error mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(4);
        make.right.equalTo(self.mas_right).offset(-4);
        make.height.mas_equalTo(2);
    }];*/
    
    /*[self.lblPlaceholder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(-5);
        make.right.equalTo(self.mas_right).with.offset(-self.edgeInsets.right);
    }];*/
    
    [self.lblPlaceholder setAlpha:(self.text.length == 0)?0:1];
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    
    /*[self.lblPlaceholder mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-_edgeInsets.right);
    }];*/
}

- (void)setIsTopPlaceholder:(BOOL)isTopPlaceholder
{
    _isTopPlaceholder = isTopPlaceholder;
    [self.lblPlaceholder setHidden:!_isTopPlaceholder];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [super editingRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (BOOL)becomeFirstResponder {
    BOOL outcome = [super becomeFirstResponder];
    if (outcome) {
        if(self.focusImage != nil) {
            self.background = self.focusImage;
        }
    }
    return outcome;
}

- (BOOL)resignFirstResponder {
    BOOL outcome = [super resignFirstResponder];
    if (outcome) {
        if(self.focusImage != nil) {
            self.background = self.defaultImage;
        }
    }
    
    [self.lblPlaceholder setAlpha:(self.text.length == 0)?0:1];
    
    return outcome;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self.lblPlaceholder setAlpha:(text.length == 0)?0:1];
}

- (void)showError {
    [self bringSubviewToFront:self.error];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.error.alpha = 1;
    }];
    
    [self performBlock:^{
        [UIView animateWithDuration:0.2 animations:^{
            self.error.alpha = 0;
        }];
    } afterDelay:5];
}

- (void)showErrorWithLine {
    [self bringSubviewToFront:self.error];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.error.alpha = 1;
    }];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    [self.lblPlaceholder setText:placeholder];
}

@end
