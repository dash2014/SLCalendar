//
//  SLCanlendarRange.h
//  SLCalendar
//
//  Created by dash on 15/5/27.
//  Copyright (c) 2015年 dash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLDateHelper : NSObject

//获取某年的某月有多少天
+ (NSInteger)numberOfDaysInMonth:(NSInteger)month forYear:(NSInteger)year;
//根据date获取dateComponents
+ (NSDateComponents *)dateComponentsWithDate:(NSDate *)date;
//获取当前的下几天
+ (NSDateComponents *)dateComponentsWithComponents:(NSDateComponents *)dateComponents
                                          afterDay:(NSInteger)day;
//根据dateComponents获取date
+ (NSDate *)dateWithDateComponents:(NSDateComponents *)dateComponents;
//获取日期数组
+ (NSArray *)weekDayArray;
//获取某个月的第一天
+ (NSDateComponents *)firstDateComponentsWithMonthComponents:(NSDateComponents *)monthComponents;
//获取dateString
+ (NSString *)dateStringWithDate:(NSDate *)date;
//获取几个月后的datecomponents
+ (NSDateComponents *)componentsWithComponents:(NSDateComponents *)dateComponents
                                    afterMonth:(NSInteger)month;

@end
