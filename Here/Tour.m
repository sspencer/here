//
//  Tour.m
//  Here
//
//  Created by Steve Spencer on 10/21/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import "Tour.h"
#import "Camper.h"
#import "Program.h"
#import <Parse/Parse.h>

@interface Tour ()

@property (nonatomic, assign) NSInteger tourId;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSString *endDateString;
@property (nonatomic, strong) NSArray *campers;
@property (nonatomic, strong) NSArray *programs;
@end

@implementation Tour


+ (instancetype)tourWithObject:(PFObject *)obj {

    Tour *t = [[Tour alloc] init];

    NSUInteger tourId     = [obj[@"tourId"] integerValue];
    NSString *startDate   = obj[@"startDate"];
    NSString *endDate     = obj[@"endDate"];
    NSString *camperData  = obj[@"campers"];
    NSString *programData = obj[@"programs"];

    NSDateFormatter *ymd = [[NSDateFormatter alloc] init];
    ymd.dateFormat = @"yyyy-MM-dd";

    t.tourId = tourId;
    t.startDate = [ymd dateFromString:startDate];
    t.endDate = [ymd dateFromString:endDate];
    t.endDateString = [endDate copy];
    t.campers = [Tour parseCampers:camperData];
    t.programs = [Tour parsePrograms:programData];

    return t;
}

+ (NSArray *)parseCampers:(NSString *)camperData {

    NSArray *campers = [camperData componentsSeparatedByString:@";"];
    NSMutableArray *list = [NSMutableArray arrayWithCapacity: [campers count]];

    for (NSString *data in campers) {
        NSArray *comps = [data componentsSeparatedByString:@"|"];
        if ([comps count] >= 2) {
            [list addObject:[Camper camperWithName:comps[0] attendance:comps[1]]];
        }
    }

    return [NSArray arrayWithArray:list];
}

+ (NSArray *)parsePrograms:(NSString *)programData {

    // programData looks like this: "5:30AM|7:00AM|6:00PM|Extra Credit"
    NSArray *comps = [programData componentsSeparatedByString:@"|"];
    NSMutableArray *list = [NSMutableArray arrayWithCapacity: [comps count]];
    NSUInteger mask = 1;

    for (NSUInteger i = 0; i < MIN(4, [comps count]); i++) {
        Program *program = [Program programWithName:comps[i] mask:mask];
        [list addObject:program];
        mask *= 2;
    }

    return [NSArray arrayWithArray:list];
}

- (Program *)programWithMask:(NSUInteger)mask {
    for (Program *p in _programs) {
        if (mask == p.mask) {
            return p;
        }
    }

    return nil;
}

@end
