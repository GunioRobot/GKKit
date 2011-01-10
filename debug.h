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
    
        #define DLog(format, ...)       NSLog(@"DLOG_PREFIX:%@;", , [NSString stringWithFormat:[@" " stringByAppendingString:format], ## __VA_ARGS__ ])
        #define DLogObject(Object)      NSLog(@"DLOG_PREFIX:%s:%@;", #Object , Object)
        #define DLogNSObject(NSObject)  NSLog(@"DLOG_PREFIX:%s:%@;", #NSObject , NSObject)
        #define DLogClass(Class)        NSLog(@"DLOG_PREFIX:%s:%@;", #Class, [NSString stringWithUTF8String:(class_getName(Class))])
        #define DLogSEL(SEL)            NSLog(@"DLOG_PREFIX:%s:%@;", #SEL, NSStringFromSelector(SEL))
        #define DLogRetain(Object)      NSLog(@"DLOG_PREFIX:%s:RET:%i;%s:%d", #Object, [Object retainCount], __PRETTY_FUNCTION__, __LINE__)
        #define DLogCFRetain(CFObject)  NSLog(@"DLOG_PREFIX:%s:RET:%i;", #CFObject, CFGetRetainCount(CFObject))
        #define DLogINT(int)            NSLog(@"DLOG_PREFIX:%s:%i;", #int, int)
        #define DLogFLOAT(float)        NSLog(@"DLOG_PREFIX:%s:%f;", #float, float)
        #define DLogBOOL(BOOL)          NSLog(@"DLOG_PREFIX:%s:%s;", #BOOL, (BOOL ? "TRUE" : "FALSE"))
        #define DLogUIView(Object)      UILogViewHierarchy(Object)
        #if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
            #define DLogCGRect(CGRect)  NSLog(@"DLOG_PREFIX:%s:%@;",  #CGRect, NSStringFromCGRect(CGRect))
        #elif TARGET_OS_MAC 
            #define DLogCGRect(CGRect)  NSLog(@"DLOG_PREFIX:%s:%@;", #CGRect, NSStringFromRect(NSRectFromCGRect(CGRect)))
        #endif
        #define DLogFunc()              NSLog(@"DLOG_PREFIX:%s:%d;", __PRETTY_FUNCTION__, __LINE__)
        
#pragma mark -
#pragma mark Class Method Logging
        
        #define DLogvoid()
        #define DLogid(Object)      NSLog(@"DLOG_PREFIX:%s:%@;", #Object , Object)
        #define DLogdouble(double)  NSLog(@"DLOG_PREFIX:%s:%f;", #double, double)
        #define DLogint(int)        NSLog(@"DLOG_PREFIX:%s:%i;", #int, int)
        
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