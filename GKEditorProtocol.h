//
//  GKEditingProtocol.h
//  GHome
//
//  Created by Gaurav Khanna on 4/16/11.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

/*
## Template MyClass
@implementation MyClass

## In Object's init method
- (void)init {
    if ((self = [super init])) {
        [self adoptEditingProtocol]; // Call this
    }
    return self;
}

## Declare this method to receive editing messages
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    if (editing) {

    } else {

    }
}

## Send this message or endEditingAnimated: to send editing messages
- (void)buttonPress:(id)sender {
    [sender startEditingAnimated:YES];
}

@end
*/

@protocol GKEditorProtocol <NSObject>
@required
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@end

@interface NSObject (GKEditor)

- (void)adoptEditorProtocol;
- (void)startEditingAnimated:(BOOL)animated;
- (void)endEditingAnimated:(BOOL)animated;

@end