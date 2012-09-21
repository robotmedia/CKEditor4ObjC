//
//  CKAppDelegate.h
//  CKEditor4OSX
//
//  Created by Hermes Pique on 9/21/12.
//
//

#import <Cocoa/Cocoa.h>
@class CKEditor;

@interface CKAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet CKEditor *editor;
@property (weak) IBOutlet NSButton *setDataButton;
@property (weak) IBOutlet NSButton *getDataButton;
@property (unsafe_unretained) IBOutlet NSTextView *textView;

- (IBAction)onSetDataButtonClick:(id)sender;

- (IBAction)onGetDataButtonClick:(id)sender;

@end
