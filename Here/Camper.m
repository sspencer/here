//
//  Camper.m
//  Here
//
//  Created by Steve Spencer on 10/22/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import "Camper.h"

@interface Camper ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *attendance;

@end


@implementation Camper

+ (instancetype)camperWithName:(NSString *)name attendance:(NSString *)attendance {
    Camper *c = [[Camper alloc] init];
    c.name = [name copy];
    c.attendance = [attendance copy];

    return c;
}

- (BOOL)didAttendAtOffset:(NSUInteger)offset program:(BootcampProgram)program {
    if (offset > [_attendance length]) {
        return NO;
    }

    NSString *digit = [_attendance substringWithRange:NSMakeRange(offset, 1)];
    NSInteger attended = strtol([digit UTF8String], NULL, 16);

    return attended & program;
}

- (void)attendedAtOffset:(NSUInteger)offset program:(BootcampProgram)program selected:(BOOL)selected {
    NSString *digit = [_attendance substringWithRange:NSMakeRange(offset, 1)];
    // int res = strtol( [yourString UTF8String], NULL, base) –  loretoparisi Nov 28 '13 at 18:55
    NSInteger attended = strtol([digit UTF8String], NULL, 16);

    if (selected) {
        attended = attended | program;
    } else {
        attended -= program;
    }


    NSMutableString *str = [NSMutableString stringWithString:_attendance];
    [str replaceCharactersInRange:NSMakeRange(offset, 1) withString:[NSString stringWithFormat:@"%lx", (long)attended]];
    _attendance = str;
}

- (NSUInteger)dayCount:(NSUInteger)offset {
    NSUInteger count = 0;
    NSString *digit = [_attendance substringWithRange:NSMakeRange(offset, 1)];
    NSInteger attended = strtol([digit UTF8String], NULL, 16);

    if (attended & BootcampProgram0530) { count++; }
    if (attended & BootcampProgram0700) { count++; }
    if (attended & BootcampProgram1800) { count++; }
    if (attended & BootcampProgramXtra) { count++; }

    return count;
}

- (NSUInteger)dayCount:(NSUInteger)offset program:(BootcampProgram)program {
    NSString *digit = [_attendance substringWithRange:NSMakeRange(offset, 1)];
    NSInteger attended = strtol([digit UTF8String], NULL, 16);
    return (attended & program) ? 1 : 0;
}

- (NSString *)serialize {
    return [NSString stringWithFormat:@"%@|%@", _name, _attendance];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<Camper:%@ %@>", _name, _attendance];
}


@end
