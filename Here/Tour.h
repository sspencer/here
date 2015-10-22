//
//  Tour.h
//  Here
//
//  Created by Steve Spencer on 10/21/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tour : NSObject

@property (nonatomic, assign, readonly) NSInteger tourId;
@property (nonatomic, strong, readonly) NSDate *startDate;
@property (nonatomic, strong, readonly) NSDate *endDate;
@property (nonatomic, strong, readonly) NSString *startDateString;
@property (nonatomic, strong, readonly) NSString *endDateString;

+ (instancetype)tourWithId:(NSInteger)tourId from:(NSString *)startDate to:(NSString *)endDate;

@end
