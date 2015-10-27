//
//  Camper.h
//  Here
//
//  Created by Steve Spencer on 10/22/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Program;

@interface Camper : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *attendance;

+ (instancetype)camperWithName:(NSString *)name attendance:(NSString *)attendance;

- (BOOL)didAttendAtOffset:(NSUInteger)offset program:(Program *)program;
- (void)attendedAtOffset:(NSUInteger)offset program:(Program *)program selected:(BOOL)selected;
- (NSUInteger)dayCount:(NSUInteger)offset programs:(NSArray *)programs;
- (NSUInteger)dayCount:(NSUInteger)offset program:(Program *)program;
- (NSString *)serialize;

@end
