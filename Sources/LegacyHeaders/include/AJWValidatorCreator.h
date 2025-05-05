//
//  AJWValidatorCreator.h
//  Strauss
//
//  Created by Lior Shabo on 3/18/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

//#import <Foundation/Foundation.h>
//#import <AJWValidator/AJWValidator.h>
@import Foundation;
@import AJWValidator;

@interface AJWValidatorCreator : NSObject

+ (AJWValidator*)createUserNameValidation;
+ (AJWValidator*)createPasswordValidation;
+ (AJWValidator*)createExistsValidation;
+ (AJWValidator*)createBlockValidation:(AJWValidatorCustomRuleBlock) block;
+ (AJWValidator*)createCarNumberValidation;
+ (AJWValidator*)createPhoneValidation;
+ (NSError *)errorWithLocalizedDescription:(NSString *)localizedDescription;
+ (AJWValidator*)createEmailValidation;
+ (AJWValidator*)createUserIDValidation;
+ (BOOL)validateUserId:(NSString*)userId;
    
@end
