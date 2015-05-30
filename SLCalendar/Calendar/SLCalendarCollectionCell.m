//
//  SLCalendarCollectionCell.m
//  SLCalendar
//
//  Created by dash on 15/5/27.
//  Copyright (c) 2015年 dash. All rights reserved.
//

#import "SLCalendarCollectionCell.h"

#import "SLDateHelper.h"
#import "SLCalendarDefine.h"

@interface SLCalendarCollectionCell()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIView *highLightView;

@end

@implementation SLCalendarCollectionCell

- (void)setDateComponents:(NSDateComponents *)dateComponents
{
    _dateComponents = [dateComponents copy];
    if (dateComponents) {
        self.titleLabel.text = [NSString stringWithFormat:@"%ld",dateComponents.day];
    } else {
        self.titleLabel.text = nil;
    }
    self.highLightView.hidden = YES;
    [self addLimitedCondition];
}

- (void)setSelected:(BOOL)selected
{
    if (selected && self.dateComponents) {
        self.highLightView.layer.cornerRadius = self.highLightView.bounds.size.width / 2;
        self.highLightView.hidden = NO;
        self.highLightView.transform = CGAffineTransformMakeScale(.1f, .1f);
        [UIView animateWithDuration:0.4
                              delay:0.0
             usingSpringWithDamping:0.5
              initialSpringVelocity:1.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.titleLabel.textColor = [UIColor whiteColor];
                             self.highLightView.transform = CGAffineTransformIdentity;
                         } completion:nil];
    } else {
        self.highLightView.hidden = YES;
        if (self.userInteractionEnabled) {
            self.titleLabel.textColor = [UIColor blackColor];
        } else {
            self.titleLabel.textColor = [UIColor lightGrayColor];
        }
    }
    [super setSelected:selected];
}

- (void)addLimitedCondition
{
    if (!self.dateComponents) {
        return;
    }
    self.userInteractionEnabled = NO;
    NSDateComponents *comps = [SLDateHelper dateComponentsWithDate:[NSDate date]];
    NSDate *destDay = [SLDateHelper dateWithDateComponents:self.dateComponents];

    NSString *currentDateString = [SLDateHelper dateStringWithDate:[NSDate date]];
    NSString *dayDateString = [SLDateHelper dateStringWithDate:destDay];
    if ([currentDateString isEqualToString:dayDateString]
        || [destDay compare:comps.date] == NSOrderedDescending) {
        self.userInteractionEnabled = YES;
        self.titleLabel.textColor = [UIColor blackColor];
    }
}

@end
