//
//  SLCalendarCollectionHeaderView.h
//  SLCalendar
//
//  Created by dash on 15/5/27.
//  Copyright (c) 2015年 dash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLCalendarCollectionHeaderView : UICollectionReusableView

@property (nonatomic, copy) NSString *title;

+ (CGFloat)viewHeight;

@end