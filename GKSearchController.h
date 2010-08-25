//
//  GKSearchController.h
//  GKKit
//
//  Created by Gaurav Khanna on 7/14/10.
//

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR

#import <UIKit/UIKit.h>
#import "NSObject+GKAdditions.h"
#import "common.h"

@interface GKSearchController : NSObject <UISearchDisplayDelegate, UISearchBarDelegate> {
    UIActivityIndicatorView *_activityView;
    UIView *_searchLoadingView;
    UISearchDisplayController *_controller;
    UIView *_controlledView;
    id _delegate;
}

@property(nonatomic, assign) id delegate;
@property(nonatomic, assign) UISearchDisplayController *controller;
@property(nonatomic, assign) UIView *controlledView;

- (id)initWithSearchDisplayController:(UISearchDisplayController *)controller controlledView:(UIView *)view;
- (void)readyToDisplayResults;
- (void)search:(NSString *)searchText fromTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

@end

@protocol GKSearchControllerDelegate <NSObject>
@optional

- (void)searchController:(GKSearchController *)controller shouldStartSearch:(NSString *)searchText;

@end

#endif