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

		UIColor *colorOne	= [UIColor colorWithHue:0.500 saturation:0.004 brightness:0.969 alpha:1.000];
		UIColor *colorTwo	= [UIColor colorWithHue:0.560 saturation:0.018 brightness:0.761 alpha:1.000];

		NSArray *colors =  [NSArray arrayWithObjects: colorOne.CGColor, colorTwo.CGColor, nil];		

		self.colors = colors;

		self.startPoint = CGPointMake(0.5, 0.0);
		self.endPoint = CGPointMake(0.5, 1.0);

	}
	return self;
}

@end

#endif