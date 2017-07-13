//
//  SLCalendarCollectionCell.h
//  SLCalendar
//
//  Created by dash on 15/5/27.
//  Copyright (c) 2015年 dash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLCalendarCollectionCell : UICollectionViewCell

@property (nonatomic, copy) NSDateComponents *dateComponents;
@property (nonatomic, assign) BOOL isLimitedCondition;

@end