//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpBusiness.h"
#import "BusinessViewCell.h"
#import "FiltersViewController.h"
#import "YelpFilters.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *businesses;
@property (strong, nonatomic) YelpFilters *filters;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.filters = [[YelpFilters alloc] init];

    self.title= @"Yelp";
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(showFilter)];
    self.navigationItem.leftBarButtonItem = filterButton;

    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    self.navigationItem.titleView = self.searchBar;

    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessViewCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];

    [self search: @"Restaurant"];

}

- (void) search: (NSString*) term {
    [YelpBusiness searchWithTerm: term
                        sortMode: [self.filters sortMode]
                      categories: [self.filters categoryCodes]
                           deals: [self.filters deals]
                      completion:^(NSArray *businesses, NSError *error) {
                          self.businesses = businesses;
                          [self.tableView reloadData];
                          for (YelpBusiness *business in businesses) {
                              NSLog(@"%@", business);
                          }
                      }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.businesses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BusinessViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];

    YelpBusiness *business = self.businesses[indexPath.row];
    [cell setBusiness: business];

    return cell;
}

#pragma mark - Filters delegate methods

- (void)filtersViewController: (FiltersViewController*) filtersViewController didChangeFilters:(YelpFilters *) filters {
    self.filters = filters;
    [self search: @"Restaurant"];
}


#pragma mark - Private Methods

- (void) showFilter {
    FiltersViewController *fvc = [[FiltersViewController alloc] init];
    fvc.delegate = self;
    fvc.yelpFilters = [self.filters copy];

    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:fvc];
    [self presentViewController:nvc animated:YES completion:nil];
}

@end
