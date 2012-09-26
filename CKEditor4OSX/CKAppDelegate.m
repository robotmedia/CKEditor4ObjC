//
//  CKAppDelegate.m
//  CKEditor4OSX
//
//  Created by Hermes Pique on 9/21/12.
//
//

#import "CKAppDelegate.h"
#import "CKEditor.h"

@implementation CKAppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)notification {
    [self.editor replaceEditor];
}

- (IBAction)onSetDataButtonClick:(id)sender {
    self.editor.data = self.textView.string;
}

- (IBAction)onGetDataButtonClick:(id)sender {
    NSString *data = self.editor.data;
    self.textView.string = data;
}

#pragma mark - CKEditorDelegate

- (void) instanceReadyInEditor:(CKEditor *)editor {
    editor.data = @"<b>Hello</b> World!";
}

@end
