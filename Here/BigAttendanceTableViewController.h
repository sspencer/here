//
//  BigAttendanceTableViewController.h
//  Here
//
//  Created by Steve Spencer on 10/26/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tour;
@class Program;

@interface BigAttendanceTableViewController : UITableViewController

- (void)displayTour:(Tour *)tour program:(Program *)program withOffset:(NSUInteger)dateOffset;

@end
