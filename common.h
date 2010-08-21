#ifdef __OBJC__
    #if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR

        #define UIViewFrameChangeValue( view, key, value) \
            CGRect frame = [view frame]; \
            key = value; \
            [view setFrame:frame]

        #define UIApplicationDirectory \
            ^ { \
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); \
                return (id)( ([paths count] > 0) ? [paths objectAtIndex:0] : nil ); \
            }

        #define UIInterfaceOrientationIsValidAndNotUpsideDown(orientation) \
            (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    
    #endif
#endif