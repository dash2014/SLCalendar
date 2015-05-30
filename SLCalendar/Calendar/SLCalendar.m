//
//  SLCalendar.m
//  SLCalendar
//
//  Created by dash on 15/5/26.
//  Copyright (c) 2015年 dash. All rights reserved.
//

#import "SLCalendar.h"

#import "SLCalendarDefine.h"
#import "SLCalendarCollectionHeaderView.h"
#import "SLCalendarCollectionCell.h"
#import "SLDateHelper.h"
#import "SLCalendarRange.h"
#import "SLCalendarDefine.h"

static const NSInteger kDefaultMonthShown = 12;

@interface SLCalendar()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) SLCalendarRange *selectedRange;

@end

@implementation SLCalendar

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self customUI];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(floor(self.bounds.size.width / kDefaultDaysInWeek), floor(self.bounds.size.width / kDefaultDaysInWeek));
    flowLayout.headerReferenceSize = CGSizeMake(self.bounds.size.width, [SLCalendarCollectionHeaderView viewHeight]);
}

- (void)customUI
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SLCalendarCollectionHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SLCalendarCollectionHeaderView class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SLCalendarCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SLCalendarCollectionCell class])];
}

- (void)setChooseType:(ECalendarChooseType)chooseType
{
    _chooseType = chooseType;
    if (self.chooseType == ECalendarChooseTypeRange) {
        self.collectionView.allowsMultipleSelection = YES;
    } else {
        self.collectionView.allowsMultipleSelection = NO;
    }
}

- (SLCalendarRange *)selectedRange
{
    if (!_selectedRange) {
        _selectedRange = [[SLCalendarRange alloc] init];
    }
    return _selectedRange;
}

#pragma mark - collectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return kDefaultMonthShown;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        SLCalendarCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SLCalendarCollectionHeaderView class]) forIndexPath:indexPath];
        NSDateComponents *dateComponents = [SLDateHelper dateComponentsWithDate:[NSDate date]];
        NSDateComponents *monthComponents = [SLDateHelper componentsWithComponents:dateComponents afterMonth:indexPath.section];
        NSString *titleString = [NSString stringWithFormat:@"%ld年%ld月",monthComponents.year, monthComponents.month];
        headerView.title = titleString;
        return headerView;
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDateComponents *dateComponents = [SLDateHelper dateComponentsWithDate:[NSDate date]];
    NSDateComponents *monthComponents = [SLDateHelper componentsWithComponents:dateComponents afterMonth:section];
    NSDateComponents *firstDateMonthComponents = [SLDateHelper firstDateComponentsWithMonthComponents:monthComponents];
    NSInteger numberOfDays = [SLDateHelper numberOfDaysInMonth:firstDateMonthComponents.month forYear:firstDateMonthComponents.day];
    NSInteger weekday = firstDateMonthComponents.weekday - 1;
    NSInteger lines = ceilf((float)(numberOfDays - (kDefaultDaysInWeek - weekday)) / kDefaultDaysInWeek) + 1;
    return lines * kDefaultDaysInWeek;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SLCalendarCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SLCalendarCollectionCell class]) forIndexPath:indexPath];
    NSDateComponents *dateComponents = [SLDateHelper dateComponentsWithDate:[NSDate date]];
    NSDateComponents *monthComponents = [SLDateHelper componentsWithComponents:dateComponents afterMonth:indexPath.section];
    NSDateComponents *firstDateMonthComponents = [SLDateHelper firstDateComponentsWithMonthComponents:monthComponents];
    NSInteger weekday = firstDateMonthComponents.weekday - 1;
    if (indexPath.row < weekday) {
        cell.dateComponents = nil;
    } else if (indexPath.row < weekday + [SLDateHelper numberOfDaysInMonth:firstDateMonthComponents.month forYear:firstDateMonthComponents.year]) {
        NSDateComponents *dateComponents = [SLDateHelper dateComponentsWithComponents:firstDateMonthComponents afterDay:(indexPath.row - weekday)];
        cell.dateComponents = dateComponents;
    } else {
        cell.dateComponents = nil;
    }
    cell.selected = [collectionView.indexPathsForSelectedItems containsObject:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.chooseType == ECalendarChooseTypeSingle) {
        return;
    }
    SLCalendarCollectionCell *cell = (SLCalendarCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([self.selectedRange.startComponents.date compare:cell.dateComponents.date] == NSOrderedSame) {
        self.selectedRange.startComponents = nil;
    } else if ([self.selectedRange.endComponents.date compare:cell.dateComponents.date] == NSOrderedSame) {
        self.selectedRange.endComponents = nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SLCalendarCollectionCell *cell = (SLCalendarCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.chooseType == ECalendarChooseTypeSingle) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(calendar:didSelectDateComponents:)]) {
            [self.delegate calendar:self didSelectDateComponents:cell.dateComponents];
        }
        return;
    }
    if (self.selectedRange.startComponents && self.selectedRange.endComponents) {
        self.selectedRange.startComponents = nil;
        self.selectedRange.endComponents = nil;
        for (NSIndexPath *seletedIndexPath in collectionView.indexPathsForSelectedItems) {
            if (seletedIndexPath != indexPath) {
                [self.collectionView deselectItemAtIndexPath:seletedIndexPath animated:YES];
            }
        }
    }
    if (!self.selectedRange.startComponents) {
        self.selectedRange.startComponents = cell.dateComponents;
    } else {
        if ([self.selectedRange.startComponents.date compare:cell.dateComponents.date] == NSOrderedSame) {
            self.selectedRange.startComponents = nil;
            return;
        } else if ([self.selectedRange.startComponents.date compare:cell.dateComponents.date] == NSOrderedAscending) {
            self.selectedRange.endComponents = cell.dateComponents;

        } else {
            NSDateComponents *tempDateComps = self.selectedRange.startComponents;
            self.selectedRange.startComponents = cell.dateComponents;
            self.selectedRange.endComponents = tempDateComps;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(calendar:didSelectRange:)]) {
            [self.delegate calendar:self didSelectRange:self.selectedRange];
        }
    }
}

@end
