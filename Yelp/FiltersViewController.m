//
//  FilterViewController.m
//  Yelp
//
//  Created by Francisco Rojas Gallegos on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "FiltersViewController.h"
#import "SwitchCell.h"

@interface FiltersViewController () <UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSMutableSet *selectedCategories;

-(void) initCategories;
@end

@implementation FiltersViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.selectedCategories  = [NSMutableSet set];
        [self initCategories];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.categoriesTableView.delegate = self;
    self.categoriesTableView.dataSource = self,
    [self.categoriesTableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(onApplyButton)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setter method
- (void) setFilters:(YelpFilters*) filters {
    _filters = filters;
    self.selectedCategories = [filters.categories mutableCopy];
}

#pragma mark - Table View Data Source methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SwitchCell  *cell = [self.categoriesTableView dequeueReusableCellWithIdentifier:@"SwitchCell"];

    [cell setOn:[self.selectedCategories containsObject:self.categories[indexPath.row]]];
    cell.titleLabel.text = self.categories[indexPath.row][@"name"];
    cell.delegator = self;

    return cell;
}

#pragma mark - Switch Cell Delegate method
- (void) switchCell: (SwitchCell *) cell didUpdateValue:(BOOL) value {
    NSIndexPath *indexPath = [self.categoriesTableView indexPathForCell:cell];

    if (value) {
        [self.selectedCategories addObject: self.categories[indexPath.row]];
    } else {
        [self.selectedCategories removeObject:self.categories[indexPath.row]];
    }

}


#pragma mark - Private Methods

- (void) onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) onApplyButton {
    self.filters.categories = [self.selectedCategories copy];
    [self.delegate filtersViewController:self didChangeFilters: self.filters];

    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) initCategories {
    self.categories = @[
                        @{@"name": @"Mexican", @"code": @"mexican"},
                        @{@"name": @"Burgers", @"code": @"burgers"},
                        @{@"name": @"Cafes", @"code": @"cafes"},
                        @{@"name": @"Cheesesteaks", @"code": @"cheesesteaks"},
                        ];
}

@end
