# SLCalendar
---
this demo is shown a calendar which completed by UIColletionView, shown the current month and future year date。
this demo have two method to choose the date, the first is single selection for one day, and the other is range selection for time interval。

## SLCalendar Class

>* SLCalendar is subclass of UIView, draw by Xib, you can initial it with Nib.
>* SLCalendar has a delegate, confirm the SLCalendarDelegate protocol

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
