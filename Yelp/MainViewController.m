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
    self.filters.defaultTerm = @"Restaurant";

    self.title= @"Yelp";
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(showFilter)];
    self.navigationItem.leftBarButtonItem = filterButton;

    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = self.filters.defaultTerm;
    [self.searchBar sizeToFit];
    self.navigationItem.titleView = self.searchBar;

    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessViewCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];

    [self search];

}

- (void) search {
    [YelpBusiness searchWithTerm: self.filters.term
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

#pragma mark - Search Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"search : %@", searchText);
    if(searchText.length == 0) {
        self.filters.term = @"";
        [self.searchBar resignFirstResponder];
        [self search];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.filters.term = searchBar.text;
    [self.searchBar resignFirstResponder];
    [self search];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.filters.term = @"";
    [self.searchBar resignFirstResponder];
    [self search];
}


#pragma mark - TableViewData Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.businesses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BusinessViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];

    YelpBusiness *business = self.businesses[indexPath.row];
    [cell setBusiness: business];

    return cell;
}

#pragma mark - UITableView methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}


#pragma mark - Filters delegate methods

- (void)filtersViewController: (FiltersViewController*) filtersViewController didChangeFilters:(YelpFilters *) filters {
    self.filters = filters;
    [self search];
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
