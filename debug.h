#ifdef __OBJC__

    #ifdef __DEBUG__
        #ifndef DEBUG
            #define DEBUG
        #endif
        #ifndef DLOG
            #define DLOG
        #endif
    #endif

    #ifdef DEBUG
        #ifndef DLOG
            #define DLOG
        #endif
    #endif

    #ifdef DLOG
    #import <Foundation/Foundation.h>
    /*void DebugLog(NSString *format, ...) {
        va_list ap;
        va_start (ap, format);
        if (![format hasSuffix: @"\n"])
            format = [format stringByAppendingString: @"\n"];
        NSString *body =  [[NSString alloc] initWithFormat:format arguments:ap];
        va_end (ap);
        fprintf(stderr,"%s",[body UTF8String]);
        [body release];
    }*/
        #define DLog(format, ...) \
            NSLog(@"DLog %@", [NSString stringWithFormat:[@"DL " stringByAppendingString:format], ## __VA_ARGS__ ])
        #define DLogObject(object) \
            NSLog(@"DLog %s: Class:%@ | Value:%@ |", #object , [NSString stringWithUTF8String:(object_getClassName(object))], object)
        #define DLogClass(object) \
            NSLog(@"DLog %s: Class:%@ |", #object, [NSString stringWithUTF8String:(class_getName(object))])
        #define DLogSEL(object) \
            NSLog(@"DLog %s: SEL:%@ |", #object, NSStringFromSelector(object))
        #define DLogRetain(object) \
            NSLog(@"DLog %s: RETAIN:%i | @%s:%d", #object, [object retainCount], __PRETTY_FUNCTION__, __LINE__)
        #define DLogCFRetain(object) \
            NSLog(@"DLog %s: RETAIN:%i |", #object, CFGetRetainCount(object))
        #define DLogINT(object) \
            NSLog(@"DLog %s: INT:%i |", #object, object)
        #define DLogFLOAT(object) \
            NSLog(@"DLog %s: FLOAT:%f |", #object, object)
        #define DLogBOOL(object) \
            NSLog(@"DLog %s: BOOL:%s |", #object, (object ? "TRUE" : "FALSE"))
        #define DLogUIView(object) \
            UILogViewHierarchy(object)
        #if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
            #define DLogCGRect(object) \
                NSLog(@"DLog %s: %@ |", #object, NSStringFromCGRect(object))
        #elif TARGET_OS_MAC 
            #define DLogCGRect(object) \
                NSLog(@"DLog %s: %@ |", #object, NSStringFromRect(NSRectFromCGRect(object)))
        #endif
        #define DLogFunc() \
            NSLog(@"DLog func: %s:%d;", __PRETTY_FUNCTION__, __LINE__)
        /*#define DLogFunc(format, ..) \
            NSLog(@"DLog func: %s:%d;", __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__)*/
            //NSLog(@"DL %@:%d", [[[NSString stringWithUTF8String:(__PRETTY_FUNCTION__)] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-+("]] objectAtIndex:1], __LINE__)
    #else
        #define DLog(format, ...) 
        #define DLogObject(object)
        #define DLogClass(object) 
        #define DLogSEL(object) 
        #define DLogRetain(object) 
        #define DLogCFRetain(object)
        #define DLogINT(object)
        #define DLogBOOL(object)
        #define DLogUIView(object)
        #define DLogCGRect(object)
        #define DLogFunc()
    #endif
#endif