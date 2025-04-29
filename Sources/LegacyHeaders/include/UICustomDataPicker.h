//
//  UICustomDataPicker.h
//  Clalit
//
//  Created by ykm dev on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UICustomDataPikerDelegete;

@interface UICustomDataPicker : UIView <UIPickerViewDelegate>

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) UIButton *btnShabow;
@property (nonatomic,strong) UIView *pickerContainer;
@property (nonatomic,strong) UIPickerView *dataPicker;
@property (nonatomic,strong) UIToolbar *pickerDateToolbar;

@property (nonatomic,weak) UIView *focusField;
@property (nonatomic,weak) id<UICustomDataPikerDelegete> delegatePicker;

-(id) initWithCustomStyle:(NSString*)title data:(NSArray*)data;
-(void) showInView:(UIView*)view;

@end


@protocol UICustomDataPikerDelegete<NSObject>
-(void) dataPickerDataSelected:(NSString*)data target:(UICustomDataPicker*)picker;
-(void) dataPickerCanceledWithTarget:(UICustomDataPicker*)picker;
@end
