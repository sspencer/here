//
//  BigAttendanceTableViewController.m
//  Here
//
//  Created by Steve Spencer on 10/26/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import "BigAttendanceTableViewController.h"
#import "Tour.h"
#import "Program.h"
#import "Camper.h"

@interface BigAttendanceTableViewController ()

@property (nonatomic, strong)Tour *tour;
@property (nonatomic, strong)Program *program;
@property (nonatomic, assign)NSUInteger dateOffset;

@end

@implementation BigAttendanceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = [_program name];
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
    return [_tour.campers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Camper *camper = _tour.campers[indexPath.row];
    cell.textLabel.text = [camper name];

    if ([camper didAttendAtOffset:_dateOffset program:_program]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Camper *camper = _tour.campers[indexPath.row];
    BOOL selected = [camper didAttendAtOffset:_dateOffset program:_program];
    [camper attendedAtOffset:_dateOffset program:_program selected:!selected];
    [tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Here
- (void)displayTour:(Tour *)tour program:(Program *)program withOffset:(NSUInteger)dateOffset {
    _tour = tour;
    _program = program;
    _dateOffset = dateOffset;
}

@end
