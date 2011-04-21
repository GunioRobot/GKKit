//
//  NSObject+GKEditingProtocol.m
//  GHome
//
//  Created by Gaurav Khanna on 4/16/11.
//  Copyright 2011 GK Apps. All rights reserved.
//

#import "GKEditorProtocol.h"

// Extend NSObject to include helper methods for an object to adopt the protocol,
// - method1 to help the object adopt the notification methods in init/awakeFromNib
//   which tells the notificatio to call method2 on the object
// - method2 to be called on from the notification to extract data from notification
//   and call the protocol method on the object
// - startEditing will send the Start notification
// - endEditing will send the End notification

NSString * const GKEditorStartEditingNotification = @"GKEditorStartEditingNotification";
NSString * const GKEditorEndEditingNotification = @"GKEditorEndEditingNotification";

@implementation NSObject (GKEditor)

- (void)adoptEditorProtocol {
    // start receiving notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editingNotification:) name:GKEditorStartEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editingNotification:) name:GKEditorEndEditingNotification object:nil];
}

- (void)editingNotification:(NSNotification *)notification {
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
