//
//  NSDate+Big.m
//  Here
//
//  Created by Steve Spencer on 10/21/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import "NSDate+Big.h"

@implementation NSDate (Big)

- (NSDate *)big_addDays:(NSInteger)days {
    return [self big_addDays:days weeks:0 months:0 years:0];
}

- (NSDate *)big_addWeeks:(NSInteger)weeks {
    return [self big_addDays:0 weeks:weeks months:0 years:0];
}

- (NSDate *)big_addMonths:(NSInteger)months {
    return [self big_addDays:0 weeks:0 months:months years:0];
}

- (NSDate *)big_addYears:(NSInteger)years {
    return [self big_addDays:0 weeks:0 months:0 years:years];
}

- (NSDate *)big_addDays:(NSInteger)days weeks:(NSInteger)weeks months:(NSInteger)months years:(NSInteger)years {
    NSDateComponents *offset = [[NSDateComponents alloc] init];
    offset.day = days;
    offset.weekOfYear = weeks;
    offset.month = months;
    offset.year = years;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [calendar dateByAddingComponents:offset toDate:self options:0];
}

@end
