//
//  GKActivityView.m
//  OutForWork
//
//  Created by Gaurav Khanna on 9/12/10.
//  Copyright 2010 GK Apps. All rights reserved.
//

#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR

#import "GKActivityView.h"

@implementation GKActivityView

- (id)initWithFrame:(CGRect)frame {
    if((self = [super initWithFrame:frame])) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.hidesWhenStopped = TRUE;
        [_activityView stopAnimating];
        [self addSubview:_activityView];
        [_activityView release];
    }
    return self;
}

- (void)activate {
    self.backgroundColor = [UIColor whiteColor];
    _activityView.center = self.center;
    UIViewFrameChangeValue(_activityView, origin.y, 11.0);
    [_activityView startAnimating];
}

- (void)dealloc {
    [_activityView release];
    [super dealloc];
}

@end

#endif
