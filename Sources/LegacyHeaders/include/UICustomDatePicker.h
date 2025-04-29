//
//  UICustomDatePicker.h
//  eldan2
//
//  Created by YKM on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UICustomDatePikerDelegete<NSObject>
-(void) datePickerDateSelected:(NSDate*)date sender:(id)sender;
-(void) datePickerDateCanceledWithTarget:(id)sender;
@end

@interface UICustomDatePicker : UIView

@property (nonatomic,strong) UIButton *btnShabow;
@property (nonatomic,strong) UIView *pickerContainer;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,strong) UIToolbar *pickerDateToolbar;

@property (nonatomic,weak) UIView *focusField;
@property (nonatomic,weak) id<UICustomDatePikerDelegete> delegatePicker;

-(id) initWithCustomStyle:(NSString*)title showDateTitle:(BOOL)showDateTitle;
-(void) showInView:(UIView*)view;
- (void)setDate:(NSDate*)date;

@end
