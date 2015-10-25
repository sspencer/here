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

    if ([self isWeekday:_date]) {
        program = _tour.programs[indexPath.row];
    } else {
        // get last program
        NSUInteger programSize = [_tour.programs count];
        program = _tour.programs[programSize-1];
    }

    cell.textLabel.text = program.name;

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

- (BOOL)isWeekday:(NSDate *)date {
    NSInteger weekday = [_gregorian component:(NSCalendarUnitWeekday) fromDate:date];
    return (weekday > 1 && weekday < 7);
}

@end
