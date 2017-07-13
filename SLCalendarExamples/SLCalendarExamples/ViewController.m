//
//  ViewController.m
//  SLCalendarExamples
//
//  Created by dash on 2017/7/13.
//  Copyright © 2017年 dash. All rights reserved.
//

#import "ViewController.h"

#import "SLCalendar.h"
#import "SLCalendarRange.h"

@interface ViewController ()<SLCalendarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SLCalendar *calendar = [[[UINib nibWithNibName:NSStringFromClass([SLCalendar class]) bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
    calendar.frame = self.view.bounds;
    calendar.delegate = self;
    calendar.chooseType = ECalendarChooseTypeRange;
    [self.view addSubview:calendar];
}

- (void)calendar:(SLCalendar *)calendar didSelectRange:(SLCalendarRange *)range
{
    NSLog(@"%@-%@",[range.startComponents.date descriptionWithLocale:[NSLocale currentLocale]], [range.endComponents.date descriptionWithLocale:[NSLocale currentLocale]]);
}

- (void)calendar:(SLCalendar *)calendar didSelectDateComponents:(NSDateComponents *)dateComponents
{
    NSLog(@"%@", [dateComponents.date descriptionWithLocale:[NSLocale currentLocale]]);
}

@end
