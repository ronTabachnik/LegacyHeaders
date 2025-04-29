//
//  BaseView.m
// Cocacola
//
//  Created by Lior Shabo on 3/10/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import "BaseUIView.h"
#import "MBProgressHUD.h"

@interface BaseUIView ()
@property(nonatomic,assign) BOOL activityShow;
@property(nonatomic,assign) BOOL isActivityVisible;
@property(nonatomic,strong) MBProgressHUD *dsActivityView;
@end

@implementation BaseUIView

-(void) addAnimation:(UIView*)view
{
    CATransition* transition = [CATransition animation];
    transition.removedOnCompletion = YES;
    transition.duration = 0.2;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = kCATransitionFade;
    [view.layer addAnimation:transition forKey:nil];
}

#pragma mark Activity

-(void)hideActivityViewer
{
    _activityShow = NO;
    _isActivityVisible = NO;
    if(self.dsActivityView != nil) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^(void) {
            [self.dsActivityView setAlpha:0];
        } completion:^(BOOL finished) {
            [self.dsActivityView removeFromSuperview];
            self.dsActivityView = nil;
        }];
    }
}

-(void)showActivityViewer:(UIView*)onView andText:(NSString*)text
{
    if(_isActivityVisible) {
        if(self.dsActivityView != nil) {
            self.dsActivityView.label.text = text;
        }
        return;
    }
    
    _isActivityVisible = YES;
    _activityShow = YES;
    self.dsActivityView = [MBProgressHUD showHUDAddedTo:onView animated:YES];
    [self.dsActivityView setRemoveFromSuperViewOnHide:YES];
    self.dsActivityView.layer.cornerRadius = 38;
    self.dsActivityView.graceTime = 0.3;
    self.dsActivityView.minShowTime = 1.0;
    self.dsActivityView.tintColor = [UIColor whiteColor];
    self.dsActivityView.contentColor = [UIColor blackColor];
    self.dsActivityView.square = YES;
    self.dsActivityView.mode = MBProgressHUDModeIndeterminate;
    self.dsActivityView.label.text = text;
}

-(void)showActivityViewerWithDelay:(UIView*)onView andText:(NSString*)text
{
    if(_isActivityVisible) return;
    
    _activityShow = YES;
    _isActivityVisible = YES;
    NSArray *array = [[NSArray alloc] initWithObjects:onView,text,nil];
    [self performSelector:@selector(showActivityViewerWithTitle:) withObject:array afterDelay:0.3];
}

-(void)showActivityViewerWithTitle:(NSArray*)data
{
    if(_activityShow){
        self.dsActivityView = [MBProgressHUD showHUDAddedTo:[data objectAtIndex:0] animated:YES];
        self.dsActivityView.square = YES;
        self.dsActivityView.mode = MBProgressHUDModeIndeterminate;
        self.dsActivityView.label.text = [data objectAtIndex:1];
    }
    _activityShow = YES;
}

@end
