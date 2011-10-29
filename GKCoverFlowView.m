//
//  GKCoverFlowView.m
//  GIndiaTV
//
//  Created by Gaurav Khanna on 4/26/11.
//  Copyright 2011 GK Apps. All rights reserved.
//

#import "GKCoverFlowView.h"

@implementation GKCoverFlowView

- (id)initWithFrame:(GKRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code here.

    }
    return self;
}

#pragma mark - Touch Methods
/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

}
*/

#pragma mark - View Events

- (void)willMoveToWindow:(UIWindow *)newWindow {

}

- (void)layoutSubviews {

}

#pragma mark - View Drawing
/*
- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
}
*/

#pragma mark - Memory Management
#if !OBJC_ARC
- (void)dealloc {
    [super dealloc];
}
#endif
@end
