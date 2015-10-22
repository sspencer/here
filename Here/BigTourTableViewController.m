//
//  BigTourTableViewController.m
//  Here
//
//  Created by Steve Spencer on 10/21/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import "BigTourTableViewController.h"
#import "Tour.h"
#import "NSDate+Big.h"

@interface BigTourTableViewController ()

@property (nonatomic, strong) NSMutableArray *weeks;
@property (nonatomic, strong) NSDateFormatter *fullDayFormatter;
@property (nonatomic, strong) NSDateFormatter *ymdFormatter;
@end



@implementation BigTourTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"Tour 66";


    _fullDayFormatter = [[NSDateFormatter alloc] init];
    _fullDayFormatter.dateFormat = @"EEEE, MMM d";

    _ymdFormatter = [[NSDateFormatter alloc] init];
    _ymdFormatter.dateFormat = @"yyyy-MM-dd";

    Tour *tour = [Tour tourWithId:67 from:@"2015-09-14" to:@"2015-10-23"];

    [self generateTour:tour];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_weeks) {
        return _weeks.count;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_weeks) {
        NSArray *days = _weeks[section];
        return days.count;
    } else {
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Week %ld", (long)(section+1)];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell;

    if (_weeks) {
        NSDate *date = _weeks[indexPath.section][indexPath.row];
        NSString *day = [self fullDayFormat:date];
        /*
        NSUInteger offset = (indexPath.section * 7) + indexPath.row;
        NSUInteger count = [_bootcamp dayCount:offset];
        */
        NSUInteger count = 0;

        cell = [tableView dequeueReusableCellWithIdentifier:@"weekday" forIndexPath:indexPath];
        cell.textLabel.text = day;

        if (count > 0) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)count];
        } else {
            cell.detailTextLabel.text = @"";
        }

    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"loading" forIndexPath:indexPath];
    }

    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Here
- (void)generateTour:(Tour *)tour {

    _weeks = [NSMutableArray arrayWithCapacity:6];
    NSMutableArray *days;
    int index = 0;
    NSString *dateStr = @"";
    NSDate *startDate;
    NSDate *date;

    while (index < 50 && (![dateStr isEqualToString:tour.endDateString])) {
        if (!days || index % 7 == 0) {
            days = [NSMutableArray arrayWithCapacity:7];
            [_weeks addObject:days];
        }

        if (!startDate) {
            startDate = tour.startDate;
            date = startDate;
        } else {
            date = [startDate big_addDays:index];
        }

        dateStr = [_ymdFormatter stringFromDate:date];
        [days addObject:date];
        index++;
    }
}

- (NSString *)fullDayFormat:(NSDate *)date {
    return [_fullDayFormatter stringFromDate:date];
}
@end
