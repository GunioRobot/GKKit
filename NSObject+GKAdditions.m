//
//  NSObject+GKAdditions.m
//  GKKit
//
//  Created by Gaurav Khanna on 7/7/10.
//

#import "NSObject+GKAdditions.h"

@implementation NSObject (GKAdditions)

+ (void)scheduleRunAfterDelay:(NSTimeInterval)delay forBlock:(void (^)(void))block {
    [[block copy] performSelector:@selector(performSelf) withObject:nil afterDelay:delay];
}

+ (void)scheduleRunAfterDelay:(NSTimeInterval)delay forBlock:(void (^)(void))block completion:(void (^)(BOOL finished))completion {
    [[block copy] performSelector:@selector(performSelfWithCallback:) withObject:[completion copy] afterDelay:delay];
}

- (void)performSelf {
    void (^block)(void) = (id)self;
    block();
}

- (void)performSelfWithCallback:(id)callback {
    // Add proper completion testing

    void (^block)(void) = (id)self;
    block();
    void (^completion)(BOOL finished) = (id)callback;
    completion(TRUE);
}

@end
