//
//  NSString+GKAdditions.m
//  GKKit
//
//  Created by Gaurav Khanna on 7/7/10.
//

#import "NSString+GKAdditions.h"

@implementation NSString (GKAdditions)

- (unichar)lastCharacter {
    return [self characterAtIndex:([self length] - 1)];
}

- (id)substringToLastCharacter {
    return [self substringToIndex:([self length] - 1)];
}

- (id)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (id)decodeAllPercentEscapes {
    NSString* cfWay = (NSString*)[(NSString*)CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, CFSTR("")) autorelease];
    /*NSString* cocoaWay = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if(![cfWay isEqualToString:cocoaWay]) {
        NSLog(@"[%@ %s]: CF and Cocoa different for %@", [self class], sel_getName(_cmd), self);
    }*/
    return cfWay;
}

- (id)decodeAllAmpersandEscapes {
    return [self stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
}

@end
