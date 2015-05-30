//
//  SLCalendar.h
//  SLCalendar
//
//  Created by dash on 15/5/26.
//  Copyright (c) 2015年 dash. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLCalendar, SLCalendarRange;

typedef NS_ENUM(NSInteger, ECalendarChooseType) {
    ECalendarChooseTypeSingle = 0,
    ECalendarChooseTypeRange = 1,
};

@protocol SLCalendarDelegate <NSObject>

@optional
//单选回调
- (void)calendar:(SLCalendar *)calendar didSelectDateComponents:(NSDateComponents *)dateComponents;
//日期区间回调
- (void)calendar:(SLCalendar *)calendar didSelectRange:(SLCalendarRange *)range;

@end

@interface SLCalendar : UIView

@property (nonatomic, weak) id<SLCalendarDelegate> delegate;
@property (nonatomic, assign) ECalendarChooseType chooseType;

@end