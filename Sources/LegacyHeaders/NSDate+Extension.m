//
//  NSDate+Extension.m
//  Strauss
//
//  Created by Lior Shabo on 3/3/15.
//  Copyright (c) 2015 Cpart LTD. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSString*)getFormattedMinutesString:(NSInteger)seconds
{
    int Minutes = 0;
    if (seconds > 59) {
        Minutes = (int)seconds / 60;
        seconds = seconds % 60;
    }
    return [NSString stringWithFormat:@"%d:%@%d",Minutes,(seconds < 10 ? @"0" : @""),(int)seconds];
}

+ (NSString*)toISO8601:(NSDate*)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSDate GetAppLocale]];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:year];
    [components setHour:hour];
    [components setMinute:minute];
    return [calendar dateFromComponents:components];
}

+ (NSDate*)toDateFromISO8601:(NSString*)date
{
    if (![date hasSuffix:@"Z"]) {
        date = [NSString stringWithFormat:@"%@Z", date];
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSDate GetAppLocale]];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *dateObject = [dateFormat dateFromString:date];
    if(dateObject == nil) {
        dateObject = [self toDateFromISO8601WithSSS:date];
        if(dateObject == nil) {
            dateObject = [self toDateFromISO8601WithSSSNoTimeZone:date];
            if(dateObject == nil) {
                dateObject = [self toDateFromISO8601WithTimeZone:date];
            }
        }
    }
    return dateObject;
}
+ (NSDate*)toDateFromISO8601WithSSS:(NSString*)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSDate GetAppLocale]];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *dateObject = [dateFormat dateFromString:date];
    return dateObject;
}
+ (NSDate*)toDateFromISO8601WithSSSNoTimeZone:(NSString*)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSDate GetAppLocale]];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *dateObject = [dateFormat dateFromString:date];
    return dateObject;
}
+ (NSDate*)toDateFromISO8601WithTimeZone:(NSString*)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSDate GetAppLocale]];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *dateObject = [dateFormat dateFromString:date];
    return dateObject;
}

+(NSDate*) toLocalTime:(NSDate*)date
{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: date];
    return [NSDate dateWithTimeInterval: seconds sinceDate: date];
}

+(NSDate *) toGlobalTime:(NSDate*)date
{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = -[tz secondsFromGMTForDate: date];
    return [NSDate dateWithTimeInterval: seconds sinceDate: date];
}

+ (NSString*)toApplicationDateText:(NSDate*)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSDate GetAppLocale]];
    [dateFormat setDateFormat:@"MMMM d yyyy"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString*)toApplicationDotDateText:(NSDate*)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSDate GetAppLocale]];
    [dateFormat setDateFormat:@"dd.MM.yy"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString*)toApplicationShortDateText:(NSDate*)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSDate GetAppLocale]];
    [dateFormat setDateFormat:@"dd/MM"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString*)toApplicationDateTimeText:(NSDate*)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSDate GetAppLocale]];
    [dateFormat setDateFormat:@"MMMM d | hh:mma"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString*)toApplicationTimeText:(NSDate*)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSDate GetAppLocale]];
    [dateFormat setDateFormat:@"hh:mm"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString*)toApplicationTimeTextMin:(NSDate*)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSDate GetAppLocale]];
    [dateFormat setDateFormat:@"hh:mma"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString*)toRangeDayText:(NSDate*)dateFrom dateTo:(NSDate*)dateTo
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSDate GetAppLocale]];
    [dateFormat setDateFormat:@"dd"];
    return [NSString stringWithFormat:@"%@-%@", [dateFormat stringFromDate:dateFrom], [dateFormat stringFromDate:dateTo]];
}

+ (NSString*)toDayText:(NSDate*)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSDate GetAppLocale]];
    [dateFormat setDateFormat:@"dd"];
    return [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:date]];
}

+ (NSLocale*)GetAppLocale
{
    return [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
}

+ (int)getYear:(NSDate*)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date];
    int year = (int)[components year];
    return year;
}

+ (NSInteger)getAge:(NSDate*)birthday
{
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:birthday
                                       toDate:now
                                       options:0];
   return [ageComponents year];
}

- (NSString*)getDayOfWeek
{
    static NSString *strings[] = {@"א׳",@"ב׳", @"ג׳",@"ד׳",@"ה׳",@"ו׳",@"ש׳"};
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    return strings[[components weekday] - 1];
}

+ (NSString*)getDayName:(NSInteger)day
{
    if (day < 0 || day > 7) {
        return nil;
    }
    
    static NSString *strings[] = {@"ראשון",@"שני", @"שלישי",@"רביעי",@"חמישי",@"שישי",@"שבת"};
    
    return strings[MAX(day-1,0)];
}

+ (NSInteger)getDayNumber:(NSString*)day
{
    NSArray *days = @[@"ראשון",@"שני", @"שלישי",@"רביעי",@"חמישי",@"שישי",@"שבת"];
    
    return [days indexOfObject:day] + 1;
}

- (NSInteger)getWeekOfYear
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self];
    return [components weekOfYear];
}

- (BOOL)isSameDayAsDate:(NSDate*)otherDate
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:self];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:otherDate];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}


+ (NSString*)getMonthName:(NSDate*)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:date];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.locale = [self GetAppLocale];
    NSString *monthName = [[df monthSymbols] objectAtIndex:([components month]-1)];
    return monthName;
}

+ (NSString*)monthNameString:(int)monthNumber
{
    NSDateFormatter *formate = [NSDateFormatter new];
    [formate setLocale:[NSDate GetAppLocale]];
    NSArray *monthNames = [formate standaloneMonthSymbols];
    NSString *monthName = [monthNames objectAtIndex:(monthNumber - 1)];
    return monthName;
}

+ (NSString*)getCurrentMonthName
{
    return [self getMonthName:[NSDate date]];
}

@end
