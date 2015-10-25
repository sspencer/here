//
//  BigProgramTableViewController.h
//  Here
//
//  Created by Steve Spencer on 10/25/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tour;

@interface BigProgramTableViewController : UITableViewController

- (void)displayTour:(Tour *)tour onDate:(NSDate *)date withOffset:(NSUInteger)dateOffset;

@end
