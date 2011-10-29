//
//  GKCoverFlowController.h
//  GIndiaTV
//
//  Created by Gaurav Khanna on 4/26/11.
//  Copyright 2011 GK Apps. All rights reserved.
//

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    #import <QuartzCore/QuartzCore.h>
    #define GKViewController UIViewController
#elif TARGET_OS_MAC
    #define GKViewController NSViewController
#endif

@interface GKCoverFlowController : GKViewController {
@private

}



@end
