//
//  Program.m
//  Here
//
//  Created by Steve Spencer on 10/24/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import "Program.h"

@interface Program ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger mask;

@end


@implementation Program

+ (instancetype)programWithName:(NSString *)name mask:(NSUInteger)mask {
    Program *p = [[Program alloc] init];
    p.name = [name copy];
    p.mask = mask;

    return p;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<Program %@:%ld>", _name, _mask];
}

@end
