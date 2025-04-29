//
//  AJWValidatorCreator.m
//  Strauss
//
//  Created by Lior Shabo on 3/18/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import "AJWValidatorCreator.h"

@implementation AJWValidatorCreator

+ (AJWValidator*)createUserNameValidation
{
    AJWValidator *validator = [AJWValidator validatorWithType:AJWValidatorTypeString];
    [validator addValidationToEnsureValidEmailWithInvalidMessage:@"יש להזין כתובת מייל תקנית"];
    return validator;
}

+ (AJWValidator*)createEmailValidation
{
    AJWValidator *validator = [AJWValidator validatorWithType:AJWValidatorTypeString];
    [validator addValidationToEnsureValidEmailWithInvalidMessage:@"יש להזין כתובת מייל תקנית"];
    return validator;
}

+ (AJWValidator*)createPasswordValidation
{
    AJWValidator *validator = [AJWValidator validatorWithType:AJWValidatorTypeString];
    [validator addValidationToEnsurePresenceWithInvalidMessage:@"יש להזין סיסמה תקנית"];
    [validator addValidationToEnsureMinimumLength:6 invalidMessage:@"מינימום 6 תווים"];
    [validator addValidationToEnsureMaximumLength:12 invalidMessage:@"מקסימום 12 תווים"];
    return validator;
}

+ (AJWValidator*)createPhoneValidation
{
    AJWValidator *validator = [AJWValidator validatorWithType:AJWValidatorTypeString];
    [validator addValidationToEnsureRegularExpressionIsMetWithPattern:@"\\+?(972|0)(\\-)?0?([5]{1}\\d{8})" invalidMessage:@"יש להזין טלפון תקני"];
    return validator;
}

+ (AJWValidator*)createCarNumberValidation
{
    AJWValidator *validator = [AJWValidator validatorWithType:AJWValidatorTypeString];
    [validator addValidationToEnsureRegularExpressionIsMetWithPattern:@"\\d{7,8}" invalidMessage:@"יש להזין מספר רכב תקני"];
    return validator;
}

+ (AJWValidator*)createUserIDValidation
{
    AJWValidator *validator = [AJWValidator validatorWithType:AJWValidatorTypeString];
    [validator addValidationToEnsureRegularExpressionIsMetWithPattern:@"\\d{9,9}" invalidMessage:@"יש להזין תעודת זהות תקינה"];
    return validator;
}

+ (BOOL)validateUserId:(NSString*)userId
{
    AJWValidator *validator = [AJWValidator validatorWithType:AJWValidatorTypeString];
    [validator addValidationToEnsureRegularExpressionIsMetWithPattern:@"\\d{9,9}" invalidMessage:@"יש להזין תעודת זהות תקינה"];
    [validator validate:userId];
    if(![validator isValid]) {
        return NO;
    }
    
    
    NSUInteger paddingCount = 9 - userId.length;
    if(paddingCount > 0) {
        NSString *padding = [[NSString string] stringByPaddingToLength:paddingCount withString:@"0" startingAtIndex:0];
        userId = [padding stringByAppendingString:userId];
    }
    
    // CHECK THE ID NUMBER
    int mone = 0;
    int incNum;
    for( int i = 0 ; i < 9 ; i++ ) {
        incNum = [[userId substringWithRange:NSMakeRange(i, 1)] intValue];
        incNum *= ( i % 2 ) + 1;
        if( incNum > 9 )
        incNum -= 9;
        mone += incNum;
    }
    
    if( mone % 10 == 0 ) {
        return YES;
    }
    else {
        return NO;
    }
}
 
+ (AJWValidator*)createExistsValidation
{
    AJWValidator *validator = [AJWValidator validatorWithType:AJWValidatorTypeString];
    [validator addValidationToEnsurePresenceWithInvalidMessage:@""];
    return validator;
}

+ (AJWValidator*)createBlockValidation:(AJWValidatorCustomRuleBlock) block
{
    AJWValidator *validator = [AJWValidator validatorWithType:AJWValidatorTypeGeneric];
    [validator addValidationToEnsureCustomConditionIsSatisfiedWithBlock:block invalidMessage:@""];
    return validator;
}


+ (NSError *)errorWithLocalizedDescription:(NSString *)localizedDescription
{
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: localizedDescription};
    return [NSError errorWithDomain:@"MH" code:100 userInfo:userInfo];
}

@end
