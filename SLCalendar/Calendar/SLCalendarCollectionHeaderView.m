//
//  SLCalendarCollectionHeaderView.m
//  SLCalendar
//
//  Created by dash on 15/5/27.
//  Copyright (c) 2015年 dash. All rights reserved.
//

#import "SLCalendarCollectionHeaderView.h"

#import "SLCalendarDefine.h"

static const CGFloat kDefaultHeaderViewHeight = 80;

@interface SLCalendarCollectionHeaderView()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

@implementation SLCalendarCollectionHeaderView

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

+ (CGFloat)viewHeight
{
    return kDefaultHeaderViewHeight;
}

@end