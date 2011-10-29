//
//  GKView+GKAdditions.m
//  GKKit
//
//  Created by Gaurav Khanna on 7/14/10.
//

#import "GKView+GKAdditions.h"

@implementation GKView (GKAdditions)

+ (void)dumpView:(GKView *)view prefix:(NSString *)prefix indent:(NSString *)indent {
    NSLog(@"%@%@%@",(indent?indent:@""),(prefix?prefix:@""),[view hierarchalDescription]);
    int i = 0;
    for(GKView *subview in view.subviews) {
        NSString *newIndent = [NSString stringWithFormat:@"  %@", indent];
        NSString *newPrefix = [NSString stringWithFormat:@"%@%d:", newIndent, i++];
        [GKView dumpView:subview prefix:newPrefix indent:newIndent];
    }
}

- (NSString *)hierarchalDescription {
    NSString *selfClass = NSStringFromClass([self class]);
    if([[selfClass substringToIndex:2] isEqualToString:@"UI"] || [[selfClass substringToIndex:2] isEqualToString:@"NS"]) {
        return [self description];
    } else {
        NSMutableString *desc = [NSMutableString stringWithString:selfClass];
        Class cl = [self superclass];
        while((![[NSStringFromClass(cl) substringToIndex:2] isEqualToString:@"UI"]) \
              && (![[NSStringFromClass(cl) substringToIndex:2] isEqualToString:@"NS"]) \
              && (cl = [cl superclass])) {
            [desc appendFormat:@":%@",NSStringFromClass(cl),nil];
        }
        [desc appendString:[[self description] substringFromIndex:[selfClass length]+1]];
        return [NSString stringWithFormat:@"<%@>",desc,nil];
    }
}

- (void)dump {
    [GKView dumpView:self prefix:@"" indent:@""];
}

@end

#if IPHONE_ONLY
@implementation UIImageView (GKAdditions)

- (id)initWithView:(UIView *)view origin:(CGPoint)origin {
    if((self = [super init])) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        [self setFrame:CGRectMake(origin.x, origin.y, image.size.width, image.size.height)];
        [self setImage:image];
    }
    return self;
}

@end
#endif


