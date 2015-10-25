//
//  BigTourTableViewController.m
//  Here
//
//  Created by Steve Spencer on 10/21/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import "BigTourTableViewController.h"
#import <Parse/Parse.h>
#import "NSDate+Big.h"
#import "Tour.h"
#import "Camper.h"
#import "BigProgramTableViewController.h"


// TODO - how is current tour id determined??
#define HERE_TOUR_ID 66

@interface BigTourTableViewController ()

@property (nonatomic, strong) NSMutableArray *weeks;
@property (nonatomic, strong) NSDateFormatter *fullDayFormatter;
@property (nonatomic, strong) NSDateFormatter *ymdFormatter;
@property (nonatomic, strong) Tour *tour;
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

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getTour:HERE_TOUR_ID];
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
        NSUInteger offset = (indexPath.section * 7) + indexPath.row;
        NSUInteger count = [self dayCount:offset];

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



#pragma mark - Navigation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_weeks) {
        NSDate *date = _weeks[indexPath.section][indexPath.row];
        NSInteger offset = (indexPath.section * 7) + indexPath.row;
        NSArray *dateOffset = @[date, [NSNumber numberWithInteger:offset]];
        [self performSegueWithIdentifier:@"program" sender:dateOffset];
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"program"]) {
        NSArray *data = sender;
        NSDate *date = data[0];
        NSNumber *offset = data[1];

        BigProgramTableViewController *controller = segue.destinationViewController;
        [controller displayTour:_tour onDate:date withOffset:[offset integerValue]];
    }
}


#pragma mark - Here

- (NSString *)fullDayFormat:(NSDate *)date {
    return [_fullDayFormatter stringFromDate:date];
}


- (void)getTour:(NSUInteger)tourId {

    // Find all posts by the current user (ACL should restrict objects that get retrieved)
    PFQuery *query = [PFQuery queryWithClassName:@"Tour"];
    [query whereKey:@"tourId" equalTo:@(tourId)];
    [query findObjectsInBackgroundWithTarget:self selector:@selector(getTourCallback:error:)];
}

// back on main thread
- (void)getTourCallback:(NSArray *)retrievedObjects error:(NSError *)error {
    if (error) {
        // show alert dialog, error table entry
        NSLog(@"ERROR: %@", error);
        return;
    }

    if ([retrievedObjects count] < 1) {
        return;
    }

    self.tour = [Tour tourWithObject:retrievedObjects[0]];

    // Set nav bar title
    self.title = [NSString stringWithFormat:@"Tour %ld", _tour.tourId];

    // Calculate the days of the week which populate the table
    _weeks = [NSMutableArray arrayWithCapacity:6];
    NSMutableArray *days;
    int index = 0;
    NSString *dateStr = @"";
    NSDate *startDate;
    NSDate *date;

    while (index < 50 && (![dateStr isEqualToString:_tour.endDateString])) {
        if (!days || index % 7 == 0) {
            days = [NSMutableArray arrayWithCapacity:7];
            [_weeks addObject:days];
        }

        if (!startDate) {
            startDate = _tour.startDate;
            date = startDate;
        } else {
            date = [startDate big_addDays:index];
        }

        dateStr = [_ymdFormatter stringFromDate:date];
        [days addObject:date];
        index++;
    }

    [self.tableView reloadData];
}

- (NSUInteger)dayCount:(NSUInteger)offset {
    NSUInteger count = 0;
    for (Camper *camper in _tour.campers) {
        count += [camper dayCount:offset];
    }

    return count;
}

@end
