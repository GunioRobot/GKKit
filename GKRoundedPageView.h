//
//  GKRoundedPageView.h
//  GHome
//
//  Created by Gaurav Khanna on 4/15/11.
//  Copyright 2011 GK Apps. All rights reserved.
//

//  _contentView in this class is where all the subviews are stored,
//  thus all methods utilizing subviews are manipulated

#if IPHONE_ONLY

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GKRoundedPageView : UIView {
@protected
    UIView *_contentView;
}

@end

#endif