#ifdef __OBJC__
    #if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR

        #define UIViewFrameChangeValue( view, key, value) \
            CGRect view ## Frame = view.frame; \
            view ## Frame.key = value; \
            [view setFrame:view ## Frame]
            
        #define CGRectRoundFrameValues(frame) \
            CGRectMake( roundf(frame.origin.x), roundf(frame.origin.y), roundf(frame.size.width), roundf(frame.size.height))

        #define UIApplicationDirectory \
            ^ { \
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); \
                return (id)( ([paths count] > 0) ? [paths objectAtIndex:0] : nil ); \
            }

        #define UIInterfaceOrientationIsValidAndNotUpsideDown(orientation) \
            (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    
    #endif
#endif