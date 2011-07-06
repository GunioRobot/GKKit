//
//  GKCoverFlowView.h
//  GIndiaTV
//
//  Created by Gaurav Khanna on 4/26/11.
//  Copyright 2011 GK Apps. All rights reserved.
//

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    #import <QuartzCore/QuartzCore.h>
    #define GKView UIView
#elif TARGET_OS_MAC 
    #define GKView NSView
#endif

@interface GKCoverFlowView : GKView {
@private
    
}

@end
