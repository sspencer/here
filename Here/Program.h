//
//  Program.h
//  Here
//
//  Created by Steve Spencer on 10/24/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Program : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, assign, readonly) NSUInteger mask;

+ (instancetype)programWithName:(NSString *)name mask:(NSUInteger)mask;

@end
