//
//  NSObject+GKEditingProtocol.m
//  GHome
//
//  Created by Gaurav Khanna on 4/16/11.
//

#import "GKEditorProtocol.h"

NSString * const GKEditorStartEditingNotification = @"GKEditorStartEditingNotification";
NSString * const GKEditorEndEditingNotification = @"GKEditorEndEditingNotification";

@interface NSObject (GKEditorPrivate) 
- (void)gk_editingNotification:(NSNotification *)notification;
@end

@implementation NSObject (GKEditor)

- (void)adoptEditorProtocol {
    // add self as observer to notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gk_editingNotification:) name:GKEditorStartEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editingNotification:) name:GKEditorEndEditingNotification object:nil];
}

- (void)gk_editingNotification:(NSNotification *)notification {
    if ([self conformsToProtocol:@protocol(GKEditorProtocol)] && [notification.name isEqualToString:GKEditorStartEditingNotification])
        [(id<GKEditorProtocol>)self setEditing:YES animated:[notification.object boolValue]];
    else
        [(id<GKEditorProtocol>)self setEditing:NO animated:[notification.object boolValue]];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    if (![self isMemberOfClass:[NSObject class]]) {
        struct objc_super s_struct = { self, [self superclass] };
        id s = objc_msgSendSuper( &s_struct, @selector(self));
        if (s && [s respondsToSelector:@selector(setEditing:animated:)])
            [s setEditing:editing animated:animated];
    }
}

- (void)startEditingAnimated:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] postNotificationName:GKEditorStartEditingNotification object:[NSNumber numberWithBool:animated]];
}

- (void)endEditingAnimated:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] postNotificationName:GKEditorEndEditingNotification object:[NSNumber numberWithBool:animated]];
}

@end
