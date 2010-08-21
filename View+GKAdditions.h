//
//  View+GKAdditions.h
//  GKKit
//
//  Created by Gaurav Khanna on 7/14/10.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    #import <QuartzCore/QuartzCore.h>
    #define GKView UIView
#elif TARGET_OS_MAC 
    #define GKView NSView
#endif

@interface GKView (GKAdditions)

+ (void)dumpView:(GKView *)view prefix:(NSString *)prefix indent:(NSString *)indent;
- (void)dump;
- (NSString *)hierarchalDescription;

@end

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
@interface UIImageView (GKAdditions)

- (id)initWithView:(UIView *)view origin:(CGPoint)origin;

@end
#endif

