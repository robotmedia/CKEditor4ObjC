//
//  RMCKEditor.m
//  CKEditor4Cocoa
//
//  Created by Hermes Pique on 9/20/12.
//  Copyright (c) 2012 Robot Media. All rights reserved.
//

#import "CKEditor.h"
#import "CKUtils.h"
#import "NSColor+String.h"

NSString *kCKEditorTemplate = @"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><script type=\"text/javascript\" src=\"ckeditor.js\"></script></head><body><textarea id=\"editor\" name=\"editor\">&nbsp;</textarea><script type=\"text/javascript\"> CKEDITOR.replace('editor', { on : { 'instanceReady': function(evt) { evt.editor.execCommand('maximize'); Cocoa.instanceReady(); }}}); </script></body></html>";

@implementation CKEditor

- (id) initWithFrame:(NSRect)frame frameName:(NSString *)frameName groupName:(NSString *)groupName {
    if (self = [super initWithFrame:frame frameName:frameName groupName:groupName]) {
        self.frameLoadDelegate = self;
        self.mainFrame.frameView.allowsScrolling = NO;
        [self setDrawsBackground:NO]; // For osx skin
        NSURL *baseURL = [[NSBundle bundleForClass:self.class] URLForResource:@"ckeditor" withExtension:nil];
        [self.mainFrame loadHTMLString:kCKEditorTemplate baseURL:baseURL];
    }
    return self;
}

#pragma mark - WebFrameLoadDelegate

- (void)webView:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowScriptObject forFrame:(WebFrame *)frame
{
    [windowScriptObject setValue:self forKey:@"Cocoa"];
}

#pragma mark - WebScripting 

+ (NSString*)webScriptNameForSelector:(SEL)sel
{
    if (sel == @selector(instanceReady)) return @"instanceReady";
    if (sel == @selector(openColorPanel)) return @"openColorPanel";
    if (sel == @selector(openFontPanel)) return @"openFontPanel";
    return nil;
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)sel
{
    if (sel == @selector(instanceReady)) return NO;
    if(sel == @selector(openColorPanel)) return NO;
    if(sel == @selector(openFontPanel)) return NO;
    return YES;
}

#pragma mark - Instance

- (NSString*) data {
    return [self stringByEvaluatingJavaScriptFromString:@"CKEDITOR.instances.editor.getData()"];
}

- (void) instanceReady {
    if ([self.editorDelegate respondsToSelector:@selector(instanceReadyInEditor:)]) {
        [self.editorDelegate instanceReadyInEditor:self];
    }
}

- (void) openColorPanel {
    [[NSColorPanel sharedColorPanel] orderFront:self];
    // No need to do anything else. Selected text color is changed auto-magically. See: http://stackoverflow.com/questions/12543320/ckeditor-and-nscolorpanel-a-mystery
}

- (void) openFontPanel {
    [[NSFontPanel sharedFontPanel] orderFront:self];
    // No need to do anything else. Selected font is changed auto-magically. See: http://stackoverflow.com/questions/12543320/ckeditor-and-nscolorpanel-a-mystery
}

- (void) setData:(NSString *)data {
    data = CKEscapeJavaScriptString(data);
    NSString *js = [NSString stringWithFormat:@"CKEDITOR.instances.editor.setData('%@')", data];
    [self stringByEvaluatingJavaScriptFromString:js];
}

- (void) setConfig:(NSString*)config {
    NSString *js = [NSString stringWithFormat:@"CKEDITOR.instances.editor.destroy();CKEDITOR.replace('editor', %@);", config];
    [self stringByEvaluatingJavaScriptFromString:js];
}

@end
