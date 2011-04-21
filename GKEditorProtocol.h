//
//  GKEditingProtocol.h
//  GHome
//
//  Created by Gaurav Khanna on 4/16/11.
//  Copyright 2011 GK Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

// Setup
//
// 1. In Object's init, call 
//   [self adoptEditingProtocol];
// 2. Create method 
//   "- (void)setEditing:(BOOL)editing animated:(BOOL)animated"
//   in class
// 3. Call [object startEditing] from any object to start editing

extern NSString * const GKEditorStartEditingNotification;
extern NSString * const GKEditorEndEditingNotification;

@protocol GKEditorProtocol <NSObject>
@required
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@end

@interface NSObject (GKEditor)
- (void)adoptEditorProtocol;
- (void)editingNotification:(NSNotification *)notification;
- (void)startEditingAnimated:(BOOL)animated;
- (void)endEditingAnimated:(BOOL)animated;

@end