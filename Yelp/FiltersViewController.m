//
//  FilterViewController.m
//  Yelp
//
//  Created by Francisco Rojas Gallegos on 10/31/15.
//  Copyright © 2015 frojasg. All rights reserved.
//

#import "FiltersViewController.h"
#import "SwitchCell.h"

@interface FiltersViewController () <UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *filtersTableView;

@end

@implementation FiltersViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.filtersTableView.delegate = self;
    self.filtersTableView.dataSource = self,
    [self.filtersTableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(onApplyButton)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:196/255.0f green:18/255.0f blue:0/255.0f alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setter method
- (void) setYelpFilters:(YelpFilters*) filters {
    _yelpFilters = filters;
}

#pragma mark - Table View Data Source methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.yelpFilters filter:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SwitchCell  *cell = [self.filtersTableView dequeueReusableCellWithIdentifier:@"SwitchCell"];

    YelpFilter *filter = [self.yelpFilters filter: indexPath.section];
    cell.titleLabel.text = [filter name: indexPath.row];
    cell.type = [self cellType: filter index: indexPath.row];
    [cell setOn:[filter isSelected:indexPath.row]];
    cell.delegator = self;

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.yelpFilters sectionsCount];
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.yelpFilters filter:section].title;
}

#pragma mark - Switch Cell Delegate method
- (void) switchCell: (SwitchCell *) cell didUpdateValue:(BOOL) value {
    NSIndexPath *indexPath = [self.filtersTableView indexPathForCell:cell];

    YelpFilter *filter = [self.yelpFilters filter:indexPath.section];
    if (value) {
        [filter select:indexPath.row];
    } else {
        [filter unselect:indexPath.row];
    }

    [self.filtersTableView reloadSections:[NSIndexSet indexSetWithIndex: indexPath.section] withRowAnimation:NO];
}

#pragma mark - UITableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YelpFilter *filter = [self.yelpFilters filter: indexPath.section];
    SwitchCell *cell =  [self.filtersTableView cellForRowAtIndexPath:indexPath];
    if (cell.type == SwitchCellTypeCheck) {
        [self switchCell:cell didUpdateValue:!cell.on];
    }
    if (cell.type != SwitchCellTypeToggle) {
        [filter toggle];
    }

    [self.filtersTableView reloadSections:[NSIndexSet indexSetWithIndex: indexPath.section] withRowAnimation:NO];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    YelpFilter *filter = [self.yelpFilters filter: indexPath.section];
    [filter close];
    [self.filtersTableView reloadSections:[NSIndexSet indexSetWithIndex: indexPath.section] withRowAnimation:NO];
}


#pragma mark - Private Methods

- (SwitchCellType) cellType: (YelpFilter*) filter index: (NSInteger) index {
    if (filter.class == YelpSingleOptionFilter.self) {
        if([filter isOpen]) {
            return SwitchCellTypeCheck;
        } else {
            return SwitchCellTypeDropDown;
        }
    } else {
        if([filter isOpen] && [filter count] > 1 && [filter count] - 1 == index) {
            return SwitchCellTypeShowMore;
        } else {
            return SwitchCellTypeToggle;
        }
    }
}

- (void) onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) onApplyButton {
    [self.delegate filtersViewController:self didChangeFilters: self.yelpFilters];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
