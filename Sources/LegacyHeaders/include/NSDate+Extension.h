//
//  NSDate+Extension.h
//  Strauss
//
//  Created by Lior Shabo on 3/3/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

+ (NSDate*)toLocalTime:(NSDate*)date;
+ (NSDate*)toDateFromISO8601:(NSString*)date;
+ (NSString*)toISO8601:(NSDate*)date;
+ (NSString*)toApplicationDateText:(NSDate*)date;
+ (NSString*)toApplicationDotDateText:(NSDate*)date;
+ (NSString*)toApplicationShortDateText:(NSDate*)date;
+ (NSString*)toApplicationDateTimeText:(NSDate*)date;
- (NSString*)getDayOfWeek;
+ (NSString*)getCurrentMonthName;
+ (NSString*)toApplicationTimeText:(NSDate*)date;
+ (NSString*)toApplicationTimeTextMin:(NSDate*)date;
+ (int)getYear:(NSDate*)date;
+ (NSInteger)getAge:(NSDate*)birthday;
+ (NSString*)getMonthName:(NSDate*)date;
+ (NSString*)toRangeDayText:(NSDate*)dateFrom dateTo:(NSDate*)dateTo;
+ (NSString*)toDayText:(NSDate*)date;
+ (NSString*)monthNameString:(int)monthNumber;
- (NSInteger)getWeekOfYear;
- (BOOL)isSameDayAsDate:(NSDate*)otherDate;
+ (NSString*)getFormattedMinutesString:(NSInteger)seconds;
+ (NSString*)getDayName:(NSInteger)day;
+ (NSInteger)getDayNumber:(NSString*)day;
+ (NSLocale*)GetAppLocale;
+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;

@end
