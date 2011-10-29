//
//  GKRoundedPageView.m
//  GHome
//
//  Created by Gaurav Khanna on 4/15/11.
//  Copyright 2011 GK Apps. All rights reserved.
//

#if IPHONE_ONLY

#import "GKRoundedPageView.h"

@implementation GKRoundedPageView

/*
+ (UIView *)hitTest:(UIView *)view point:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *subview in view.subviews) {
        if ([subview pointInside:[view convertPoint:point toView:subview] withEvent:event]) {
            DLogObject(subview);
            UIView *view1 =  [subview hitTest:point withEvent:event];
            DLogObject(view1);
            return view1;
        }
    }
    return nil;
}
*/

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code

        self.clipsToBounds = NO;
        self.layer.cornerRadius = 10.0;
        self.layer.masksToBounds = YES;

        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.7;
        self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;

        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height)];
        _contentView.clipsToBounds = YES;
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = self.layer.cornerRadius;
        //_contentView.userInteractionEnabled = NO;
        //self.userInteractionEnabled = NO;
        //_contentView.backgroundColor = [UIColor whiteColor];


        [self addSubview:_contentView];
        [self bringSubviewToFront:_contentView];

        [self layoutIfNeeded];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // Needs to send nil back if point wasn't on a button/switch (any object userInteractionEnabled)
    // Otherwise nil to send the event to the scroll view so the pages are scrollable
    // To do this: It will recurse through all subviews in itself, find any that the point is on and have userInteractionEnabled
    //DLogObject(NSStringFromCGPoint(point));
    UIView *targetView = nil;

    for (UIView *subview in _contentView.subviews) {
        if ([subview pointInside:[self convertPoint:point toView:subview] withEvent:event]) {
            // "subview" here is going to be something like the PageHeaderView Object
            targetView = subview;
            for (UIView *sview in subview.subviews) {
                if ([sview pointInside:[self convertPoint:point toView:sview] withEvent:event]) {
                    targetView = sview;
                }
            }
        }
    }
    if (targetView.userInteractionEnabled)
        return targetView;
    return nil;
}

- (id)subviews {
    return _contentView.subviews;
}

- (void)addSubview:(UIView *)view {
    if (view == _contentView)
        [super addSubview:view];
    else
        [_contentView addSubview:view];
}

- (void)layoutSubviews {
    _contentView.frame = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
    [_contentView setNeedsLayout];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#if !OBJC_ARC
- (void)dealloc {
    [_contentView release];
    [super dealloc];
}
#endif
@end

#endif