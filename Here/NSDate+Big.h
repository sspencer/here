//
//  NSDate+Big.h
//  Here
//
//  Created by Steve Spencer on 10/21/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate  (Big)

- (NSDate *)big_addDays:(NSInteger)days;
- (NSDate *)big_addWeeks:(NSInteger)weeks;
- (NSDate *)big_addMonths:(NSInteger)months;
- (NSDate *)big_addYears:(NSInteger)years;
- (NSDate *)big_addDays:(NSInteger)days weeks:(NSInteger)weeks months:(NSInteger)months years:(NSInteger)years;

@end
