//
//  GKSearchController.m
//  GKKit
//
//  Created by Gaurav Khanna on 7/14/10.
//

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR

#import "GKSearchController.h"

typedef enum {
    GKSearchDisplayStateSearching = 0,
    GKSearchDisplayStateLoading   = 1,
} GKSearchDisplayState;

@implementation GKSearchController

@synthesize delegate = _delegate, controlledView = _controlledView, controller = _controller;

- (id)initWithSearchDisplayController:(UISearchDisplayController *)controller controlledView:(UIView *)view {
    if ((self = [super init])) {
        _searchLoadingView = [[UIView alloc] initWithFrame:CGRectZero];
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.hidesWhenStopped = TRUE;
        [_activityView stopAnimating];
        [_searchLoadingView addSubview:_activityView];
#if !OBJC_ARC
        [_activityView release];
#endif

        controller.delegate = self;
        controller.searchBar.delegate = self;

        self.controller = controller;
        self.controlledView = view;
    }
    return self;
}

- (void)setSearchLoadingState:(GKSearchDisplayState)state {
    switch(state) {
        case GKSearchDisplayStateLoading:
            _searchLoadingView.backgroundColor = [UIColor whiteColor];
            _activityView.center = _searchLoadingView.center;
            UIViewFrameChangeValue(_activityView, origin.y, 11.0);
            [_activityView startAnimating];
            break;

        case GKSearchDisplayStateSearching:
            [_activityView stopAnimating];
            _searchLoadingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
            break;
    }
}

- (void)readyToDisplayResults {
    self.controller.searchResultsTableView.hidden = FALSE;
    [_searchLoadingView removeFromSuperview];
}

- (void)search:(NSString *)searchText fromTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated{
    if(tableView && indexPath)
        [tableView deselectRowAtIndexPath:indexPath animated:animated];
    [self.controller setActive:TRUE animated:animated];
    self.controller.searchBar.text = searchText;
    [self searchBarSearchButtonClicked:self.controller.searchBar];
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

// called when table is shown/hidden
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {
    tableView.hidden = TRUE;
    [_searchLoadingView setFrame:( CGRectEqualToRect(tableView.frame, CGRectZero ) ? _searchLoadingView.frame : tableView.frame)];
    [self setSearchLoadingState:GKSearchDisplayStateSearching];
    [self.controlledView addSubview:_searchLoadingView];
}

// returns NO to not cause reload of table with no results
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    return NO;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    return NO;
}

#pragma mark -
#pragma mark UISearchBar Delegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self setSearchLoadingState:GKSearchDisplayStateLoading];
    [self.delegate searchController:self shouldStartSearch:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    if(_searchLoadingView.superview) {
        [_searchLoadingView removeFromSuperview];
        [NSObject scheduleRunAfterDelay:1.0 forBlock:^{
            self.controller.searchResultsTableView.hidden = FALSE;
        }];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if([searchText length] == 0)
        _searchLoadingView.hidden = TRUE;
    else
        _searchLoadingView.hidden = FALSE;
}

#pragma mark - Memory Management
#if !OBJC_ARC
- (void)dealloc {
    [_searchLoadingView release];
    [_activityView release];
    [super dealloc];
}
#endif

@end

#endif