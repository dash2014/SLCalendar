//
//  SLCanlendarRange.h
//  SLCalendar
//
//  Created by dash on 15/5/27.
//  Copyright (c) 2015年 dash. All rights reserved.
//

#import "SLDateHelper.h"

@implementation SLDateHelper

+ (NSInteger)numberOfDaysInMonth:(NSInteger)month forYear:(NSInteger)year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = month;
    components.year = year;
    NSDate *date = [calendar dateFromComponents:components];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    return range.length;
}

+ (NSDateComponents *)dateComponentsWithDate:(NSDate *)date;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit |
    NSCalendarCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    return comps;
}

+ (NSDateComponents *)dateComponentsWithComponents:(NSDateComponents *)dateComponents afterDay:(NSInteger)day
{
    NSDateComponents *nextDateComponents = [dateComponents copy];
    nextDateComponents.day += day;
    nextDateComponents = [SLDateHelper dateComponentsWithDate:nextDateComponents.date];
    return nextDateComponents;
}

+ (NSDate *)dateWithDateComponents:(NSDateComponents *)dateComponents
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:dateComponents];
    return date;
}

+ (NSArray *)weekDayArray
{
    NSArray *weekDayArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    return weekDayArray;
}

+ (NSDateComponents *)firstDateComponentsWithMonthComponents:(NSDateComponents *)monthComponents
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSCalendarCalendarUnit;
    monthComponents.day = 1;
    comps = [calendar components:unitFlags fromDate:[calendar dateFromComponents:monthComponents]];
    return comps;
}

+ (NSString *)dateStringWithDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    return [formatter stringFromDate:date];
}

+ (NSDateComponents *)componentsWithComponents:(NSDateComponents *)dateComponents afterMonth:(NSInteger)month
{
    NSDateComponents *monthComponents = [dateComponents copy];
    monthComponents.month += month;
    monthComponents = [SLDateHelper dateComponentsWithDate:monthComponents.date];
    return monthComponents;
}

@end