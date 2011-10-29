#ifdef __OBJC__
    #import <Foundation/Foundation.h>
    #import <objc/message.h>
    #import <objc/runtime.h>

    // TODO: Test & Fix
    #define NSObjectMessageSendSuper(obj, msg, ...) \
        ^{ \
            return (id)objc_msgSendSuper(&(struct objc_super){obj, class_getSuperclass([obj class])}, @selector(msg), ## __VA_ARGS__); \
        }()

    #define NSObjectMessageSendSuperSuper(obj, msg, ...) \
        ^{ \
            return (id)objc_msgSendSuper(&(struct objc_super){obj, class_getSuperclass(class_getSuperclass([obj class]))}, @selector(msg), ## __VA_ARGS__); \
        }()

    #define NSDef [NSUserDefaults standardUserDefaults]
    #define $(class) objc_getClass(#class)
    #define OBJC_ARC __has_feature(objc_arc)
    #if OBJC_ARC
        #define STRONG strong
        #define WEAK weak
    #else
        #define STRONG retain
        #define WEAK assign
    #endif

    #if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
        #define MAC_ONLY 1
    #elif TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
        #define IPHONE_ONLY 1
    #endif

    #ifdef MAC_ONLY
        #ifndef NSApp
            #define NSApp [NSApplication sharedApplication]
        #endif
        #ifndef NSAppDelegate
            #define NSAppDelegate (id)[[NSApplication sharedApplication] delegate]
        #endif
        #define GKApp [NSApplication sharedApplication]
        #ifndef GKView
            #define GKView NSView
        #endif
        #ifndef GKRect
            #define GKRect NSRect
        #endif
    #elif IPHONE_ONLY
        #import <QuartzCore/QuartzCore.h>
        #ifndef UIApp
            #define UIApp [UIApplication sharedApplication]
        #endif
        #ifndef UIAppDelegate
            #define UIAppDelegate [UIApp delegate]
        #endif
        #ifndef GKView
            #define GKView UIView
        #endif
        #ifndef GKRect
            #define GKRect CGRect
        #endif

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