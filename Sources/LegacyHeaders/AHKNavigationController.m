//  Created by Arkadiusz on 01-04-14.

#import "AHKNavigationController.h"

@interface AHKNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>
/// A Boolean value indicating whether navigation controller is currently pushing a new view controller on the stack.
@property (nonatomic, getter = isDuringPushAnimation) BOOL duringPushAnimation;
/// A real delegate of the class. `delegate` property is used only for keeping an internal state during
/// animations – we need to know when the animation ended, and that info is available only
/// from `navigationController:didShowViewController:animated:`.
@property (weak, nonatomic) id<UINavigationControllerDelegate> realDelegate;
@end

@implementation AHKNavigationController

#pragma mark - NSObject

- (void)dealloc
{
    self.delegate = nil;
    self.interactivePopGestureRecognizer.delegate = nil;
}

#pragma mark - UIViewController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController])
    {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
        
        return self;
    }
    
    return nil;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
        
        return self;
    }
    
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - UINavigationController

/*- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    [super setDelegate:delegate ? self : nil];
    self.realDelegate = delegate != self ? delegate : nil;
}*/

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated __attribute__((objc_requires_super))
{
    self.duringPushAnimation = YES;
    [super pushViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.view.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    self.navigationBar.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    
    if ([self.realDelegate respondsToSelector:_cmd]) {
        [self.realDelegate navigationController:navigationController willShowViewController:viewController animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    NSCAssert(self.interactivePopGestureRecognizer.delegate == self, @"AHKNavigationController won't work correctly if you change interactivePopGestureRecognizer's delegate.");

    self.duringPushAnimation = NO;

    if ([self.realDelegate respondsToSelector:_cmd]) {
        [self.realDelegate navigationController:navigationController didShowViewController:viewController animated:animated];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        // Disable pop gesture in two situations:
        // 1) when the pop animation is in progress
        // 2) when user swipes quickly a couple of times and animations don't have time to be performed
        BOOL res = [self.viewControllers count] > 1 && !self.isDuringPushAnimation;
        return res;
    } else {
        // default value
        return YES;
    }
}

#pragma mark - Delegate Forwarder

// Thanks for the idea goes to: https://github.com/steipete/PSPDFTextView/blob/ee9ce04ad04217efe0bc84d67f3895a34252d37c/PSPDFTextView/PSPDFTextView.m#L148-164

- (BOOL)respondsToSelector:(SEL)s
{
    BOOL res = [super respondsToSelector:s] || [self.realDelegate respondsToSelector:s];
    return res;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)s
{
    return [super methodSignatureForSelector:s] ?: [(id)self.realDelegate methodSignatureForSelector:s];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    id delegate = self.realDelegate;
    if ([delegate respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:delegate];
    }
}

-(BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    /*if (@available(iOS 13.0, *)) {
        return UIStatusBarStyleDarkContent;
    } else {
        return UIStatusBarStyleDefault;
    }*/
    return self.topViewController.preferredStatusBarStyle;
}

@end
