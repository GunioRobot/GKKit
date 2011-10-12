//
//  View+GKAdditions.h
//  GKKit
//
//  Created by Gaurav Khanna on 7/14/10.
//

#import <Foundation/Foundation.h>
#import "common.h"

#if MAC_ONLY

@interface NSView (GKAdditions)

+ (void)dumpView:(NSView *)view prefix:(NSString *)prefix indent:(NSString *)indent;
- (void)dump;
- (NSString *)hierarchalDescription;

@end

#elif IPHONE_ONLY

@interface UIView (GKAdditions)

+ (void)dumpView:(UIView *)view prefix:(NSString *)prefix indent:(NSString *)indent;
- (void)dump;
- (NSString *)hierarchalDescription;

@end

@interface UIImageView (GKAdditions)

- (id)initWithView:(UIView *)view origin:(CGPoint)origin;

@end

#endif

