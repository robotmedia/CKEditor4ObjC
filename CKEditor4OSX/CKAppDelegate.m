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

- (IBAction)onSetDataButtonClick:(id)sender {
    self.editor.data = self.textView.string;
}

- (IBAction)onGetDataButtonClick:(id)sender {
    NSString *data = self.editor.data;
    self.textView.string = data;
}

@end
