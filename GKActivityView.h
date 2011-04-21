//
//  GKActivityView.h
//  OutForWork
//
//  Created by Gaurav Khanna on 9/12/10.
//  Copyright 2010 GK Apps. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GKActivityView : UIView {
    @private
    UIActivityIndicatorView *_activityView;
}

- (void)activate;

@end
