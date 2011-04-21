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
- (id)gk_super;
@end

@implementation NSObject (GKEditor)

// Add self as observer to notifications, usually during init
- (void)adoptEditorProtocol {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gk_editingNotification:) name:GKEditorStartEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gk_editingNotification:) name:GKEditorEndEditingNotification object:nil];
}

// Process received notification
- (void)gk_editingNotification:(NSNotification *)notification {
    if ([self conformsToProtocol:@protocol(GKEditorProtocol)] && [notification.name isEqualToString:GKEditorStartEditingNotification])
        [(id<GKEditorProtocol>)self setEditing:YES animated:[notification.object boolValue]];
    else if ([notification.name isEqualToString:GKEditorEndEditingNotification])
        [(id<GKEditorProtocol>)self setEditing:NO animated:[notification.object boolValue]];
}

// If object isn't empty implementation, get super, send message if needed
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    id s = [self gk_super];
    if (s && [s respondsToSelector:@selector(setEditing:animated:)])
            [s setEditing:editing animated:animated];
}

- (id)gk_super {
    if (![self isMemberOfClass:[NSObject class]]) {
        struct objc_super s_struct = { self, [self superclass] };
        return objc_msgSendSuper( &s_struct, @selector(self));
    }
    return nil;
}

- (void)startEditingAnimated:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] postNotificationName:GKEditorStartEditingNotification object:[NSNumber numberWithBool:animated]];
}

- (void)endEditingAnimated:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] postNotificationName:GKEditorEndEditingNotification object:[NSNumber numberWithBool:animated]];
}

@end
