//
//  UICustomDatePicker.m
//  eldan2
//
//  Created by YKM on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UICustomDatePicker.h"
#import "UIView-Extensions.h"
#import "NSDate+Extension.h"
#import "AppStyleUtilities.h"
#import "NSObject+PerformBlockAfterDelay.h"

@interface UICustomDatePicker ()
@property(nonatomic,strong) UILabel *labelDate;
@property (nonatomic,assign) BOOL showDateTitle;
@property (nonatomic,strong) NSArray *accessibilityElementsBackup;
@end

@implementation UICustomDatePicker

-(id) initWithCustomStyle:(NSString*)title showDateTitle:(BOOL)showDateTitle {
    if(self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 260.0);
        [self setAutoresizesSubviews:YES];
        
        self.btnShabow = [[UIButton alloc] initWithFrame:self.bounds];
        [self.btnShabow setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin];
        [self.btnShabow setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
        [self.btnShabow addTarget:self action:@selector(closeDatePicker) forControlEvents:UIControlEventTouchUpInside];
        [self.btnShabow setAlpha:0];
        self.btnShabow.accessibilityLabel = @"סגירת פקד";
        [self addSubview:self.btnShabow];
        
        self.pickerContainer = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 260.0)];
        [self.pickerContainer setBackgroundColor:[UIColor blackColor]];
        
        self.pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.width, 44.0)];
        if([self.pickerDateToolbar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
            [self.pickerDateToolbar setBackgroundImage:[[UIImage alloc] init] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
        }
        [self.pickerDateToolbar setBackgroundColor:[UIColor blackColor]];
        [self.pickerDateToolbar setBarStyle:UIBarStyleDefault];
        [self.pickerDateToolbar sizeToFit];
        
        self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, self.width, 216.0)];
        [self.datePicker setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin];
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        self.datePicker.backgroundColor = [UIColor blackColor];
        self.datePicker.tintColor = [UIColor whiteColor];
        [self.datePicker addTarget:self action:@selector(dateIsChanged:) forControlEvents:UIControlEventValueChanged];
        self.datePicker.accessibilityLabel = [NSString stringWithFormat:@"בחר %@", title];
        if (@available(iOS 13.4, *)) {
            [self.datePicker setPreferredDatePickerStyle:UIDatePickerStyleWheels];
        }
        [self.datePicker setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
        
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 20)];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [label setFont:[UIFont fontWithName:[AppStyleUtilities boldFontName] size:20]];
        label.textColor = [UIColor whiteColor];
        
        if (self.showDateTitle) {
            UILabel *labelDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 140, 16)];
            labelDate.text = @"";
            labelDate.textAlignment = NSTextAlignmentCenter;
            labelDate.backgroundColor = [UIColor clearColor];
            [labelDate setFont:[UIFont fontWithName:[AppStyleUtilities regularFontName] size:14]];
            labelDate.textColor = [UIColor whiteColor];
            self.labelDate = labelDate;
            [self setDate:[NSDate date]];
        }
        
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Select",@"") style:UIBarButtonItemStyleDone target:self action:@selector(dateSelected:)];
        NSDictionary *doneBtnAttributes = @{NSFontAttributeName: [UIFont fontWithName:[AppStyleUtilities boldFontName] size:18.0f],
                                            NSForegroundColorAttributeName:[UIColor whiteColor]};
        [doneBtn setTitleTextAttributes:doneBtnAttributes forState:UIControlStateNormal];
        [barItems addObject:doneBtn];
        
        UIBarButtonItem *flexSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace1];
        
        UIView *titleContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, self.showDateTitle?40:20)];
        [titleContainer setBackgroundColor:[UIColor clearColor]];
        [titleContainer addSubview:label];

        if(self.labelDate != nil) {
            [titleContainer addSubview:self.labelDate];
        }
        UIBarButtonItem *toolBarTitle = [[UIBarButtonItem alloc] initWithCustomView:titleContainer];
        [barItems addObject:toolBarTitle];
        
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace];
        
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"ביטול",@"") style:UIBarButtonItemStylePlain target:self action:@selector(closeDatePicker)];
        NSDictionary *cancelBtnAttributes = @{NSFontAttributeName: [UIFont fontWithName:[AppStyleUtilities regularFontName] size:18.0f],
                                              NSForegroundColorAttributeName:[UIColor whiteColor]};
        [cancelBtn setTitleTextAttributes:cancelBtnAttributes forState:UIControlStateNormal];
        [barItems addObject:cancelBtn];
        
        [self.pickerDateToolbar setItems:barItems animated:NO];
        [self.pickerContainer addSubview:self.pickerDateToolbar];
        [self.pickerContainer addSubview:self.datePicker];
        [self addSubview:self.pickerContainer];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.pickerContainer setY:self.height - self.pickerContainer.height];
}

-(void) closeDatePicker
{
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.pickerContainer setY:[UIScreen mainScreen].bounds.size.height];
        [self.btnShabow setAlpha:0];
    } completion:^(BOOL finished) {
        [self.delegatePicker datePickerDateCanceledWithTarget:self];
        
        self.superview.accessibilityElements = self.accessibilityElementsBackup;
        
        [self removeFromSuperview];
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.focusField);
    }];
}

-(void) dateSelected:(id)dender
{
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.pickerContainer setY:[UIScreen mainScreen].bounds.size.height];
        [self.btnShabow setAlpha:0];
    } completion:^(BOOL finished) {
        [self.delegatePicker datePickerDateSelected:self.datePicker.date sender:self];
        
        self.superview.accessibilityElements = self.accessibilityElementsBackup;
        
        [self removeFromSuperview];
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.focusField);
    }];
}

-(void) showInView:(UIView*)view
{
    [self setHeight:view.height];
    [view addSubview:self];
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.pickerContainer setY:0];
        [self.btnShabow setAlpha:1];
    } completion:^(BOOL finished) {
        
        [self performBlock:^{
            UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.datePicker);
            
            self.accessibilityElementsBackup = view.accessibilityElements;
            view.accessibilityElements = @[self];
        } afterDelay:2.0];
    }];
}

- (void)setDate:(NSDate*)date
{
    [self.datePicker setDate:date animated:NO];
    [self dateIsChanged:nil];
}

- (void)dateIsChanged:(id)sender
{
    self.labelDate.text = [NSString stringWithFormat:@"%@ יום %@", [NSDate toApplicationDateText:self.datePicker.date], [self.datePicker.date getDayOfWeek]];
}

@end
