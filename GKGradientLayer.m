//
//  GKGradientLayer.m
//  GHome
//
//  Created by Gaurav Khanna on 4/8/11.
//  Copyright 2011 GK Apps. All rights reserved.
//

#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR

#import "GKGradientLayer.h"


@implementation GKGradientLayer

- (id)init{
	if ((self = [super init])) {

		CGColorRef color1	= [UIColor colorWithHue:0.500 saturation:0.004 brightness:0.969 alpha:1.000].CGColor;
		CGColorRef color2	= [UIColor colorWithHue:0.560 saturation:0.018 brightness:0.761 alpha:1.000].CGColor;

		NSArray *colors =  [NSArray arrayWithObjects: (__bridge_transfer id)color1, (__bridge_transfer id)color2, nil];

		self.colors = colors;

		self.startPoint = CGPointMake(0.5, 0.0);
		self.endPoint = CGPointMake(0.5, 1.0);

	}
	return self;
}

@end

#endif