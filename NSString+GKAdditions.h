//
//  NSString+GKAdditions.h
//  GKKit
//
//  Created by Gaurav Khanna on 7/7/10.
//

#import <Foundation/Foundation.h>

@interface NSString (GKAdditions)

- (unichar)lastCharacter;
- (NSString*)substringToLastCharacter;
- (NSString*)trim;
//- (NSString*)decodeAllPercentEscapes;
- (NSString*)decodeAllAmpersandEscapes;
- (BOOL)isEmpty;
- (NSNumber*)numberValue;

@end
