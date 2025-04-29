//
//  BaseViewController.h
// Cocacola
//
//  Created by Lior Shabo on 3/3/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iToast.h"

@interface BaseController : UIViewController

@property(nonatomic,assign) BOOL showBackButton;
@property(nonatomic,assign) BOOL showRightAppIcon;
@property(nonatomic,assign) BOOL showAppLogo;
@property(nonatomic,assign) BOOL showLeftMenuButton;
@property(nonatomic,assign) BOOL shouldLoadRentalColors;
@property(nonatomic,assign) BOOL loadDataAfterVisible;

@property(nonatomic,strong) NSDate *lastRefreshDate;

//loader
-(void) hideActivityViewer;
-(void) showActivityViewer:(UIView*)onView andText:(NSString*)text;
-(void) showActivityViewerDelay:(UIView*)onView andText:(NSString*)text;

-(void) showLeftMenuClick:(id)sender;

-(void) setTitleView:(NSString *)title subTitle:(NSString*)subTitle;
-(void) addAnimation:(UIView*)view;
-(void) backButtonClicked:(id)sender;
-(BOOL) isVisible;

- (void)userInfoChangeFromOutsideNotification:(NSNotification*)notification;

- (void)applicationDidBecomeActive;
- (void)applicationDidResignActive;
- (void)refreshDataAfterTimeInterval;
-(void) setupBackButton;
- (void)hideNavigationBarShadow;
- (void)addNavigationBarShadow;

@end
