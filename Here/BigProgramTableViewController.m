//
//  BigProgramTableViewController.m
//  Here
//
//  Created by Steve Spencer on 10/25/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import "BigProgramTableViewController.h"
#import "Tour.h"
#import "Program.h"
#import "Camper.h"
#import "BigAttendanceTableViewController.h"


@interface BigProgramTableViewController()

@property (nonatomic, strong)NSDate *date;
@property (nonatomic, strong)Tour *tour;
@property (nonatomic, assign)NSUInteger dateOffset;
@property (nonatomic, strong) NSCalendar *gregorian;

@end



@implementation BigProgramTableViewController

- (void)displayTour:(Tour *)tour onDate:(NSDate *)date withOffset:(NSUInteger)dateOffset {
    _tour = tour;
    _date = date;
    _dateOffset = dateOffset;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDateFormatter *abbrDateFormat = [[NSDateFormatter alloc] init];
    abbrDateFormat.dateFormat = @"EEE, MMM d";

    // for isWeekday calculation
    _gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];

    self.title = [abbrDateFormat stringFromDate:_date];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // counts may have changed so reload must be triggered or cached data will show
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self isWeekday:_date]) {
        return [_tour.programs count];
    } else {
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Program";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Program *program;
    NSUInteger count;
    if ([self isWeekday:_date]) {
        program = _tour.programs[indexPath.row];
    } else {
        // get last program
        NSUInteger programSize = [_tour.programs count];
        program = _tour.programs[programSize-1];
    }

    count = [self dayCount:program];
    cell.textLabel.text = program.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", count];

    return cell;
}




 #pragma mark - Navigation


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Program *program = _tour.programs[indexPath.row];
    [self performSegueWithIdentifier:@"attendance" sender:program];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"attendance"]) {
        Program *program = sender;
        BigAttendanceTableViewController *controller = segue.destinationViewController;
        [controller displayTour:_tour program:program withOffset:_dateOffset];
     }
}


#pragma mark - Here

- (BOOL)isWeekday:(NSDate *)date {
    NSInteger weekday = [_gregorian component:(NSCalendarUnitWeekday) fromDate:date];
    return (weekday > 1 && weekday < 7);
}

- (NSUInteger)dayCount:(Program *)program {
    NSUInteger count = 0;
    for (Camper *camper in _tour.campers) {
        count += [camper dayCount:_dateOffset program:program];
    }

    return count;
}

@end
