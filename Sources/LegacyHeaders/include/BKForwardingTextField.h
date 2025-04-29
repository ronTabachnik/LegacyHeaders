//
//  BKForwardingTextField.h
//  BKMoneyKit
//

#ifndef BKForwardingTextField_h
#define BKForwardingTextField_h

#import <UIKit/UIKit.h>
#import "OSTextField.h"

@interface BKForwardingTextField : OSTextField <UITextFieldDelegate>

@property (nonatomic, weak, readonly) id<UITextFieldDelegate> userDelegate;

- (void)commonInit;

@end

#endif /* BKForwardingTextField_h */
