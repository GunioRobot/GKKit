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
        #ifndef DLOG_PREFIX
            #define DLOG_PREFIX DL
        #endif
        
        #define Q_(x) #x
        #define Q(x) Q_(x)
    
        #define DLog(format, ...)       NSLog(@"%s:%s:%@;", Q(DLOG_PREFIX), [NSString stringWithFormat:[@" " stringByAppendingString:format], ## __VA_ARGS__ ])
        #define DLogObject(Object)      NSLog(@"%s:%s:%@;", Q(DLOG_PREFIX), #Object , Object)
        #define DLogNSObject(NSObject)  NSLog(@"%s:%s:%@;", Q(DLOG_PREFIX), #NSObject , NSObject)
        #define DLogClass(Class)        NSLog(@"%s:%s:%@;", Q(DLOG_PREFIX), #Class, [NSString stringWithUTF8String:(class_getName(Class))])
        #define DLogSEL(SEL)            NSLog(@"%s:%s:%@;", Q(DLOG_PREFIX), #SEL, NSStringFromSelector(SEL))
        #define DLogRetain(Object)      NSLog(@"%s:%s:RET:%i;%s:%d", Q(DLOG_PREFIX), #Object, [Object retainCount], __PRETTY_FUNCTION__, __LINE__)
        #define DLogCFRetain(CFObject)  NSLog(@"%s:%s:RET:%i;", Q(DLOG_PREFIX), #CFObject, CFGetRetainCount(CFObject))
        #define DLogINT(int)            NSLog(@"%s:%s:%i;", Q(DLOG_PREFIX), #int, int)
        #define DLogFLOAT(float)        NSLog(@"%s:%s:%f;", Q(DLOG_PREFIX), #float, float)
        #define DLogBOOL(BOOL)          NSLog(@"%s:%s:%s;", Q(DLOG_PREFIX), #BOOL, (BOOL ? "TRUE" : "FALSE"))
        #define DLogUIView(Object)      UILogViewHierarchy(Object)
        #if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
            #define DLogCGRect(CGRect)  NSLog(@"%s:%s:%@;", Q(DLOG_PREFIX), #CGRect, NSStringFromCGRect(CGRect))
        #elif TARGET_OS_MAC 
            #define DLogCGRect(CGRect)  NSLog(@"%s:%s:%@;", Q(DLOG_PREFIX), #CGRect, NSStringFromRect(NSRectFromCGRect(CGRect)))
        #endif
        #define DLogFunc()              NSLog(@"%s:%s:%d;", Q(DLOG_PREFIX), __PRETTY_FUNCTION__, __LINE__)
        
#pragma mark -
#pragma mark Class Method Logging
        
        #define DLogvoid()
        #define DLogid(Object)      NSLog(@"%s:%s:%@;", Q(DLOG_PREFIX), #Object , Object)
        #define DLogdouble(double)  NSLog(@"%s:%s:%f;", Q(DLOG_PREFIX), #double, double)
        #define DLogint(int)        NSLog(@"%s:%s:%i;", Q(DLOG_PREFIX), #int, int)
        
        #define DLogMethodv0(selName) \
            - (void)selName { \
                DLogFunc(); \
                [super selName]; \
            }
        #define DLogMethod0(rettype, selName) \
            - (rettype)selName { \
                DLogFunc(); \
                rettype retVar = [super selName]; \
                DLog ## rettype(retVar); \
                return retVar; \
            }
        #define DLogMethodv1(selName, selArgType) \
            - (void)selName:(selArgType)fp8 { \
                DLogFunc(); \
                DLog ## selArgType(fp8); \
                [super selName:fp8]; \
            }
        #define DLogMethod1(rettype, selName1, selArgType1) \
            - (rettype)selName1:(selArgType1)fp8 { \
                DLogFunc(); \
                DLog ## selArgType1(fp8); \
                rettype retVar = [super selName1:fp8]; \
                DLog ## rettype(retVar); \
                return retVar; \
            }
        #define DLogMethodv2(selName1, selArgType1, selName2, selArgType2) \
            - (void)selName1:(selArgType1)fp8 selName2:(selArgType2)fp16 { \
                DLogFunc(); \
                DLog ## selArgType1(fp8); \
                DLog ## selArgType2(fp16); \
                [super selName1:fp8 selName2:fp16]; \
            }
        #define DLogMethod2(rettype, selName1, selArgType1, selName2, selArgType2) \
            - (rettype)selName1:(selArgType1)fp8 selName2:(selArgType2)fp16 { \
                DLogFunc(); \
                DLog ## selArgType1(fp8); \
                DLog ## selArgType2(fp16); \
                rettype retVar = [super selName1:fp8 selName2:fp16]; \
                DLog ## rettype(retVar); \
                return retVar; \
            }
        #define DLogMethodv3(selName1, selArgType1, selName2, selArgType2, selName3, selArgType3) \
            - (void)selName1:(selArgType1)fp8 selName2:(selArgType2)fp16 selName3:(selArgType3)fp32 { \
                DLogFunc(); \
                DLog ## selArgType1(fp8); \
                DLog ## selArgType2(fp16); \
                DLog ## selArgType3(fp32); \
                [super selName1:fp8 selName2:fp16 selName3:fp32]; \
            }
        #define DLogMethod3(rettype, selName1, selArgType1, selName2, selArgType2, selName3, selArgType3) \
            - (rettype)selName1:(selArgType1)fp8 selName2:(selArgType2)fp16 selName3:(selArgType3)fp32 { \
                DLogFunc(); \
                DLog ## selArgType1(fp8); \
                DLog ## selArgType2(fp16); \
                DLog ## selArgType3(fp32); \
                rettype retVar = [super selName1:fp8 selName2:fp16 selName3:fp32]; \
                DLog ## rettype(retVar); \
                return retVar; \
            }
        #define DLogMethodv4(selName1, selArgType1, selName2, selArgType2, selName3, selArgType3, selName4, selArgType4) \
            - (void)selName1:(selArgType1)fp8 selName2:(selArgType2)fp16 selName3:(selArgType3)fp32 selName4:(selArgType4)fp64 { \
                DLogFunc(); \
                DLog ## selArgType1(fp8); \
                DLog ## selArgType1(fp8); \
                DLog ## selArgType2(fp16); \
                DLog ## selArgType3(fp32); \
                DLog ## selArgType4(fp64); \
                [super selName1:fp8 selName2:fp16 selName3:fp32 selName4:fp64]; \
            }
        #define DLogMethod4(rettype, selName1, selArgType1, selName2, selArgType2, selName3, selArgType3, selName4, selArgType4) \
            - (rettype)selName1:(selArgType1)fp8 selName2:(selArgType2)fp16 selName3:(selArgType3)fp32 selName4:(selArgType4)fp64 { \
                DLogFunc(); \
                DLog ## selArgType1(fp8); \
                DLog ## selArgType1(fp8); \
                DLog ## selArgType2(fp16); \
                DLog ## selArgType3(fp32); \
                DLog ## selArgType4(fp64); \
                rettype retVar = [super selName1:fp8 selName2:fp16 selName3:fp32 selName4:fp64]; \
                DLog ## rettype(retVar); \
                return retVar; \
            }
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
        #define DLogMethod0(object, object)
        #define DLogMethod1(object, object)
        #define DLogMethod2(object, object, object)
        #define DLogMethod3(object, object, object, object)
        #define DLogvoid()
        #define DLogid()
    #endif
#endif