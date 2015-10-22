//
//  Tour.m
//  Here
//
//  Created by Steve Spencer on 10/21/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import "Tour.h"

@interface Tour ()

@property (nonatomic, assign) NSInteger tourId;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSString *startDateString;
@property (nonatomic, strong) NSString *endDateString;

@end

@implementation Tour

+ (instancetype)tourWithId:(NSInteger)tourId from:(NSString *)startDate to:(NSString *)endDate {
    Tour *t = [[Tour alloc] init];

    NSDateFormatter *ymd = [[NSDateFormatter alloc] init];
    ymd.dateFormat = @"yyyy-MM-dd";

    t.tourId = tourId;
    t.startDate = [ymd dateFromString:startDate];
    t.startDateString = startDate;
    t.endDate = [ymd dateFromString:endDate];
    t.endDateString = endDate;

    return t;
}

@end
