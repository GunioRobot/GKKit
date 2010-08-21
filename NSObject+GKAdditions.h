//
//  NSObject+GKAdditions.h
//  GKKit
//
//  Created by Gaurav Khanna on 7/7/10.
//

#import <Foundation/Foundation.h>

@interface NSObject (GKAdditions)

+ (void)scheduleRunAfterDelay:(NSTimeInterval)delay forBlock:(void (^)(void))block;
+ (void)scheduleRunAfterDelay:(NSTimeInterval)delay forBlock:(void (^)(void))block completion:(void (^)(BOOL finished))completion;

@end
