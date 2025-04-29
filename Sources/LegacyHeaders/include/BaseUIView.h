//
//  BaseView.h
// Cocacola
//
//  Created by Lior Shabo on 3/10/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iToast.h"
//#import "GoogleAnalyticsHandler.h"

@interface BaseUIView : UIView

//loader
-(void) hideActivityViewer;
-(void) showActivityViewer:(UIView*)onView andText:(NSString*)text;
-(void) showActivityViewerWithDelay:(UIView*)onView andText:(NSString*)text;

-(void) addAnimation:(UIView*)view;

@end
