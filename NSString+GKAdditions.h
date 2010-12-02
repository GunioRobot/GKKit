//
//  NSString+GKAdditions.h
//  GKKit
//
//  Created by Gaurav Khanna on 7/7/10.
//

#import <Foundation/Foundation.h>


@interface NSString (GKAdditions)

- (unichar)lastCharacter;
- (id)substringToLastCharacter;
- (id)trim;
- (id)decodeAllPercentEscapes;
- (id)decodeAllAmpersandEscapes;
- (BOOL)isEmpty;

@end
