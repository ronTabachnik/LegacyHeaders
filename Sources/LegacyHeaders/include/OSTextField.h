//
//  OSTextField.h
//  Strauss
//
//  Created by Lior Shabo on 3/16/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSTextField : UITextField

@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) BOOL isTopPlaceholder;
@property (nonatomic, strong) UIImage *focusImage;
@property (nonatomic, strong) UIImage *defaultImage;
@property (nonatomic, strong) UIView *error;
@property (nonatomic, strong) UILabel *lblPlaceholder;

- (void)showError;
- (void)showErrorWithLine;
@end
