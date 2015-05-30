# SLCalendar
---
>* this demo is shown a calendar which completed by UIColletionView, shown the current month and future year date。
>* this demo have two method to choose the date, the first is single selection for one day, and the other is range selection for time interval。

## SLCalendar Class

>* SLCalendar is subclass of UIView, draw by Xib, you can initial it with Nib.
>* SLCalendar has a delegate, confirm the SLCalendarDelegate protocol
>* SLCalendar has a chooseType, you can choose your calendar to support single selection or range selection.

## SLCalendarProtocol

>* this delegate method is choose one day
>* - (void)calendar:(SLCalendar *)calendar didSelectDateComponents:(NSDateComponents *)dateComponents;
>* this delegate method is choose a range
>* - (void)calendar:(SLCalendar *)calendar didSelectRange:(SLCalendarRange *)range;

## SLCalendarRange

>* this class is only two property, startComponents & endComponents to describe a date range.

## SLDateHelper

>* this class is a collection of helper method, eg. transform date to a datecomponents, or datecomponents to date, and so on.

## SLCalendarCollectionCell

>* this class is collectionCell, describe a day.

## SLCalendarCollectionHeaderView

>* this class is the collectionView headerView, for the month description.
