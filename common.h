#ifdef __OBJC__

    #import <objc/message.h>
    #import <objc/runtime.h>
    
    #define NSObjectMessageSendSuper(obj, msg, ...) \
        ^{ \
            return (id)objc_msgSendSuper(&(struct objc_super){obj, class_getSuperclass([obj class])}, @selector(msg), ## __VA_ARGS__); \
        }()
        
    #define NSObjectMessageSendSuperSuper(obj, msg, ...) \
        ^{ \
            return (id)objc_msgSendSuper(&(struct objc_super){obj, class_getSuperclass(class_getSuperclass([obj class]))}, @selector(msg), ## __VA_ARGS__); \
        }()
        
    #define NSDef [NSUserDefaults standardUserDefaults]
    #define AppDelegate [[UIApplication sharedApplication] delegate]
    #define $(object) object_getClass(object);

    #if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR

        #define UIViewFrameChangeValue( view, key, value) \
            CGRect view ## Frame = view.frame; \
            view ## Frame.key = value; \
            [view setFrame:view ## Frame]
            
        #define CGRectRoundFrameValues( frame) \
            CGRectMake( roundf(frame.origin.x), roundf(frame.origin.y), roundf(frame.size.width), roundf(frame.size.height))
            
        #define UIViewFrameRoundValues( view) \
            [view setFrame:CGRectRoundFrameValues( view.frame)]

        #define UIApplicationDirectory \
            ^{ \
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); \
                return (id)( ([paths count] > 0) ? [paths objectAtIndex:0] : nil ); \
            }

        #define UIInterfaceOrientationIsValidAndNotUpsideDown(orientation) \
            (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    
    #endif
#endif