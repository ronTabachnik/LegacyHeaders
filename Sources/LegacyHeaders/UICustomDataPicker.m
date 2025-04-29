//
//  UICustomDataPicker.m
//  Clalit
//
//  Created by ykm dev on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UICustomDataPicker.h"
#import "UIView-Extensions.h"
#import "AppStyleUtilities.h"

@implementation UICustomDataPicker

-(id) initWithCustomStyle:(NSString*)title data:(NSArray*)data
{
	if(self = [super init]) {
		self.dataArray = data;
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
        
		self.dataPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 44.0, self.width, 216.0)];
        [self.dataPicker setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin];
		self.dataPicker.backgroundColor = [UIColor blackColor];
        self.dataPicker.showsSelectionIndicator = YES;
        self.dataPicker.delegate = self;

        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Select",@"") style:UIBarButtonItemStyleDone target:self action:@selector(dataSelected:)];
        
        NSDictionary *doneBtnAttributes = @{NSFontAttributeName: [UIFont fontWithName:[AppStyleUtilities boldFontName] size:17.0f],
                                                  NSForegroundColorAttributeName:[UIColor whiteColor]};
        [doneBtn setTitleTextAttributes:doneBtnAttributes forState:UIControlStateNormal];
        [barItems addObject:doneBtn];
        
        UIBarButtonItem *flexSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace1];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [label setFont:[UIFont fontWithName:[AppStyleUtilities boldFontName] size:18]];
        label.textColor = [UIColor whiteColor];
        [label sizeToFit];
        UIBarButtonItem *toolBarTitle = [[UIBarButtonItem alloc] initWithCustomView:label];
        [barItems addObject:toolBarTitle];
        
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace];
        
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel",@"") style:UIBarButtonItemStylePlain target:self action:@selector(closeDatePicker)];
        NSDictionary *cancelBtnAttributes = @{NSFontAttributeName: [UIFont fontWithName:[AppStyleUtilities regularFontName] size:17.0f],
                                            NSForegroundColorAttributeName:[UIColor whiteColor]};
        [cancelBtn setTitleTextAttributes:cancelBtnAttributes forState:UIControlStateNormal];
        [barItems addObject:cancelBtn];
        
		
		[self.pickerDateToolbar setItems:barItems animated:NO];
		[self.pickerContainer addSubview:self.pickerDateToolbar];
		[self.pickerContainer addSubview:self.dataPicker];
        [self.pickerContainer addSubview:self.dataPicker];
        
        [self addSubview:self.pickerContainer];
        self.isAccessibilityElement = YES;
        self.accessibilityTraits = UIAccessibilityTraitAdjustable;
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
        [self.delegatePicker dataPickerCanceledWithTarget:self];
        [self removeFromSuperview];
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.focusField);
    }];
}

-(void) dataSelected:(id)dender
{
    if(self.dataArray.count == 0) return;
    
	[UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.pickerContainer setY:[UIScreen mainScreen].bounds.size.height];
        [self.btnShabow setAlpha:0];
    } completion:^(BOOL finished) {
        int row = (int)[self.dataPicker selectedRowInComponent:0];
        [self.delegatePicker dataPickerDataSelected:[self.dataArray objectAtIndex:row] target:self];
        [self removeFromSuperview];
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, nil);
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
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.dataPicker);
    }];
}


#pragma ---------------
#pragma UIPickerView 

- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{ 
    return [self.dataArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.dataArray objectAtIndex:row];
}

/*- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 1;
    label.text = [self.dataArray objectAtIndex:row];
    
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}*/

@end
