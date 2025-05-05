//
//  BaseController.m
// Cocacola
//
//  Created by Lior Shabo on 3/3/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import "BaseController.h"
#import "MBProgressHUD.h"
#import "AHKNavigationController.h"
//#import "ActiveSessionManager.h"
#import "AppStyleUtilities.h"
#import "UILabel+Extension.h"
#import "SDWebImage/UIImage+GIF.h"
#import "NSObject+PerformBlockAfterDelay.h"
//#import "Zeekr-Swift.h"

@interface LoaderSpinner : UIView
@end

@interface BaseController () <UIGestureRecognizerDelegate>
@property(nonatomic,assign) BOOL visible;
@property(nonatomic,assign) BOOL activityShow;
@property(nonatomic,assign) BOOL isActivityVisible;
@property(nonatomic,strong) MBProgressHUD *dsActivityView;
@end

@implementation BaseController
{
    NSArray *_activityArgs;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.showLeftMenuButton) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 10, 10);
        [backButton setImage: [UIImage imageNamed:@"menu_icon"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//        rightBarBtn.accessibilityLabel = @"חזור";
        self.navigationItem.rightBarButtonItem = rightBarBtn;
    }
    
    [self setupBackButton];
    
    if(self.showRightAppIcon) {
        UIImage *logoImage = [UIImage imageNamed:@"header_icon"];
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
        [rightBtn setImage:logoImage forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(homeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
//        if(![[AuthenticationManager sharedManager] isVerified]) {
//            [rightBtn setUserInteractionEnabled:NO];
//        }
        
        UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        rightBarBtn.accessibilityLabel = @"עמוד ראשי";
        self.navigationItem.rightBarButtonItem = rightBarBtn;
    }
    
    if(self.showAppLogo) {
        UIImage *logoImage = [UIImage imageNamed:@"header_icon"];
        UIImageView *imgLogo = [[UIImageView alloc] initWithImage:logoImage];
        imgLogo.frame = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
        self.navigationItem.titleView = imgLogo;
    }

    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:UIColor.zeekrBlack];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationBarAppearance *app = [UINavigationBarAppearance new];
    [app configureWithOpaqueBackground];
    if (self.shouldLoadRentalColors){
        app.shadowColor = UIColor.clearColor;
    }
    app.backgroundColor = self.shouldLoadRentalColors == YES ? UIColor.charcoalGrey : UIColor.zeekrBlack;
    app.titleTextAttributes =  @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                 NSFontAttributeName: [UIFont fontWithName:[AppStyleUtilities mediumFontName] size:18]};
    self.navigationController.navigationBar.scrollEdgeAppearance = self.navigationController.navigationBar.standardAppearance = app;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeUserInfoNotification:) name:ActiveSessionManager.NotificationDidChangeUserInfo object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(applicationDidResignActive)
                                                name:UIApplicationDidEnterBackgroundNotification object:nil];
}

-(void) setupBackButton
{
    if(self.showBackButton) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 25, 25);
        [backButton setImage: [UIImage imageNamed:@"backward_arrow_icon"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        leftBarBtn.accessibilityLabel = @"חזור";
        self.navigationItem.leftBarButtonItem = leftBarBtn;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshScreenDataIfNeeded];
    
    self.visible = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.visible = NO;
}

#pragma mark - Refresh

- (BOOL)refreshScreenDataIfNeeded {
    if (self.lastRefreshDate == nil) return NO;

    NSTimeInterval interval = [self.lastRefreshDate timeIntervalSinceNow];
    if (fabs(interval) > ([ActiveSessionManager sharedInstance].configurations.screenAutoRefreshInMinutes * 60)) {
        [self refreshDataAfterTimeInterval];
        return YES;
    }
    
    return NO;
}

- (void)applicationDidBecomeActive {
    [self performBlock:^{
        [self refreshScreenDataIfNeeded];
    } afterDelay:1.0];
}

- (void)applicationDidResignActive {}

- (void)refreshDataAfterTimeInterval {}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UISlider class]]) {
        // prevent recognizing touches on the slider
        return NO;
    }
    return YES;
}

-(void) backButtonClicked:(id)sender
{
    if (self.navigationController != nil) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:true];
            return;
        }
    }
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void) showLeftMenuClick:(id)sender
{}

-(void) didChangeUserInfoNotification:(NSNotification*)notification
{
    id sender = notification.userInfo[@"sender"];
    if(sender != self) {
        [self userInfoChangeFromOutsideNotification:notification];
    }
}

- (void)userInfoChangeFromOutsideNotification:(NSNotification*)notification
{}

-(void) homeButtonClicked:(id)sender
{
    
}

-(void) addAnimation:(UIView*)view
{
    CATransition* transition = [CATransition animation];
    transition.removedOnCompletion = YES;
    transition.duration = 0.2;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = kCATransitionFade;
    [view.layer addAnimation:transition forKey:nil];
}

- (void)setTitleView:(NSString *)title subTitle:(NSString*)subTitle
{
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width-180, self.navigationController.navigationBar.frame.size.height)];
        titleView.numberOfLines = 2;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.adjustsFontSizeToFitWidth = YES;
        titleView.minimumScaleFactor = 0.8;
        [titleView setTextColor:[UIColor whiteColor]];
        [titleView setBackgroundColor:[UIColor clearColor]];
        titleView.text = [NSString stringWithFormat:@"%@\n%@", title, subTitle];
        titleView.font = [UIFont fontWithName:[AppStyleUtilities zeekrSemiBoldFontName] size:18];
        
        [titleView fontSubstring:subTitle font:[UIFont fontWithName:[AppStyleUtilities mediumFontName] size:14]];
        self.navigationItem.titleView = titleView;
        titleView.frame = CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width-180, self.navigationController.navigationBar.frame.size.height);
    }
    else {
        titleView.text = title;
        
        [titleView fontSubstring:subTitle font:[UIFont fontWithName:[AppStyleUtilities mediumFontName] size:12]];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark Activity

-(void)hideActivityViewer
{
    _activityArgs = nil;
    
    _activityShow = NO;
    _isActivityVisible = NO;
    if(self.dsActivityView != nil) {
        [self.dsActivityView hideAnimated:YES];
    }
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification,@"התוכן סיים להיטען");
}

-(void)showActivityViewer:(UIView*)onView andText:(NSString*)text
{
    [self showActivityViewer:onView andText:text delay:0.0];
}

-(void)showActivityViewerDelay:(UIView*)onView andText:(NSString*)text
{
    [self showActivityViewer:onView andText:text delay:1.0];
}

-(void)showActivityViewer:(UIView*)onView andText:(NSString*)text delay:(CGFloat)delay
{
    if(_isActivityVisible) {
        if(self.dsActivityView != nil) {
            self.dsActivityView.label.text = text;
        }
        return;
    }
    
    _isActivityVisible = YES;
    _activityShow = YES;
    
    /*RoundedMBProgressHUD *hud = [[RoundedMBProgressHUD alloc] initWithView:onView];
    hud.removeFromSuperViewOnHide = YES;
    hud.graceTime = delay;
    hud.minShowTime = 0.5;
    [hud.bezelView setBackgroundColor:[UIColor zeekrBlack]];
    hud.bezelView.color = [UIColor zeekrBlack];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundColor = [UIColor clearColor];
    hud.label.text = text;
    hud.mode = MBProgressHUDModeCustomView;
    [onView addSubview:hud];
    [hud showAnimated:YES];*/
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:onView];
    hud.removeFromSuperViewOnHide = YES;
    hud.graceTime = delay;
    hud.minShowTime = 1.0;
    hud.margin = 20.0;
    hud.bezelView.clipsToBounds = NO;
    [hud.bezelView setBackgroundColor:[UIColor clearColor]];
    hud.bezelView.color = [UIColor clearColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundColor = [UIColor clearColor];
    hud.clipsToBounds = NO;

    hud.label.text = @"";
    //hud.label.text = @"רק רגע...";
    //hud.label.font = [UIFont fontWithName:[AppStyleUtilities regularFontName] size:12];
    
    LoaderSpinner *spinner = [[LoaderSpinner alloc] init];
    hud.customView = spinner;
    hud.customView.clipsToBounds = NO;
    hud.mode = MBProgressHUDModeCustomView;
    [onView addSubview:hud];
    [hud showAnimated:YES];
    
    UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, hud);
    [hud setAccessibilityViewIsModal:YES];
    [hud setIsAccessibilityElement: true];
    [hud setAccessibilityLabel:@"loading"];

    self.dsActivityView = hud;
}

- (BOOL)isVisible
{
    if (self.visible && self.isViewLoaded && self.view.window && self.presentedViewController == nil && [UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait; // or Right of course
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Navigation
- (void)hideNavigationBarShadow
{
    self.navigationController.navigationBar.layer.shadowColor = UIColor.clearColor.CGColor;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 0);
    self.navigationController.navigationBar.layer.shadowOpacity = 0;
    self.navigationController.navigationBar.layer.shadowRadius = 0;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)addNavigationBarShadow
{
    self.navigationController.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect: self.navigationController.navigationBar.bounds].CGPath;
    self.navigationController.navigationBar.layer.shadowColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.62].CGColor;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 5);
    self.navigationController.navigationBar.layer.shadowOpacity = 1;
    self.navigationController.navigationBar.layer.shadowRadius = 7;
}

@end

@implementation LoaderSpinner

- (id)init {
    
    if (self = [super init]) {
        self.translatesAutoresizingMaskIntoConstraints = YES;
        self.clipsToBounds = NO;
        
        UIImageView *back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loader_back_circle"]];
        [back setContentMode:UIViewContentModeScaleToFill];
        [back setFrame:CGRectMake(-60, -60, 220, 220)];
        [self addSubview:back];
        
        UIView *loader = [[LoaderLottie alloc] initWithFrame:CGRectMake(-7, -24, 114, 114)];
        [self addSubview:loader];
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 63, 80, 20)];
        [lblTitle setText:@"רק רגע..."];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [lblTitle setContentMode:UIViewContentModeCenter];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [lblTitle setFont:[UIFont fontWithName:[AppStyleUtilities lightFontName] size:16]];
        [self addSubview:lblTitle];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(100.0, 100.0);
}


@end
