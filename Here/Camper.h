//
//  Camper.h
//  Here
//
//  Created by Steve Spencer on 10/22/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import <Foundation/Foundation.h>


// Attendance string is just single digit (0-f), so only the first 4 values
// are used for it.
typedef NS_OPTIONS(NSInteger, BootcampProgram) {
    BootcampProgram0530    = 1 << 0, // START bitmask for attendance
    BootcampProgram0700    = 1 << 1,
    BootcampProgram1800    = 1 << 2,
    BootcampProgramXtra    = 1 << 3, // END bitmask for attendance
};

@interface Camper : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *attendance;

+ (instancetype)camperWithName:(NSString *)name attendance:(NSString *)attendance;

- (BOOL)didAttendAtOffset:(NSUInteger)offset program:(BootcampProgram)program;
- (void)attendedAtOffset:(NSUInteger)offset program:(BootcampProgram)program selected:(BOOL)selected;
- (NSUInteger)dayCount:(NSUInteger)offset;
- (NSUInteger)dayCount:(NSUInteger)offset program:(BootcampProgram)program;
- (NSString *)serialize;

@end
