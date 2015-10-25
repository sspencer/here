//
//  Tour.h
//  Here
//
//  Created by Steve Spencer on 10/21/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFObject;

@interface Tour : NSObject

@property (nonatomic, assign, readonly) NSInteger tourId;
@property (nonatomic, strong, readonly) NSDate *startDate;
@property (nonatomic, strong, readonly) NSDate *endDate;
@property (nonatomic, strong, readonly) NSString *endDateString;
@property (nonatomic, strong, readonly) NSArray *campers;
@property (nonatomic, strong, readonly) NSArray *programs;

+ (instancetype)tourWithObject:(PFObject *)obj;

@end
