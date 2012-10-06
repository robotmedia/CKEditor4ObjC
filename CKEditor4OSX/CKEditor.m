//
//  RMCKEditor.m
//  CKEditor4Cocoa
//
//  Created by Hermes Pique on 9/20/12.
//  Copyright (c) 2012 Robot Media. All rights reserved.
//

#import "CKEditor.h"

NSString *kCKEditorDefaultConfig = @"{ on : { 'instanceReady': function(evt) { evt.editor.execCommand('maximize'); Cocoa.instanceReady(); }}}";
NSString *kCKEditorTemplate = @"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><script type=\"text/javascript\" src=\"ckeditor.js\"></script></head><body><textarea id=\"editor\" name=\"editor\">&nbsp;</textarea><script type=\"text/javascript\"> CKEDITOR.on('instanceCreated', function (e) { e.editor.on('change', function (ev) { Cocoa.dataDidChange(); }); }); CKEDITOR.replace('editor', %@); </script></body></html>"; // onchange logic needs to go before CKEditor.replace

@implementation CKEditor {
    BOOL _loaded;
    NSString *_previousData;
}

- (id) initWithFrame:(NSRect)frame frameName:(NSString *)frameName groupName:(NSString *)groupName {
    if (self = [super initWithFrame:frame frameName:frameName groupName:groupName]) {
        self.frameLoadDelegate = self;
        self.mainFrame.frameView.allowsScrolling = NO;
        [self setDrawsBackground:NO]; // For osx skin
        
        // NSColorPanel and NSFontPanel changes don't fire dataDidChange so we have to do it manually
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(webViewDidChange:)
                                                     name:WebViewDidChangeNotification
                                                   object:self];
    
    }
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSColorPanelColorDidChangeNotification
                                                  object:self];
}

#pragma mark - WebFrameLoadDelegate

- (void)webView:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowScriptObject forFrame:(WebFrame *)frame
{
    [windowScriptObject setValue:self forKey:@"Cocoa"];
}

#pragma mark - WebScripting

+ (NSString*)webScriptNameForSelector:(SEL)sel
{
    if (sel == @selector(dataDidChange)) return @"dataDidChange";
    if (sel == @selector(instanceReady)) return @"instanceReady";
    if (sel == @selector(openColorPanel)) return @"openColorPanel";
    if (sel == @selector(openFontPanel)) return @"openFontPanel";
    return nil;
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)sel
{
    if (sel == @selector(dataDidChange)) return NO;
    if (sel == @selector(instanceReady)) return NO;
    if(sel == @selector(openColorPanel)) return NO;
    if(sel == @selector(openFontPanel)) return NO;
    return YES;
}

#pragma mark - NSResponder

- (void) changeFont:(id)sender {
    if (![self.data isEqualToString:_previousData]) {
        [self dataDidChange];
    }
}

#pragma mark - Class

+ (NSString*) escapeJavaScriptString:(NSString*)value {
    if (!value) return nil;
    const char *chars = [value UTF8String];
    NSMutableString *escapedString = [NSMutableString string];
    while (*chars) {
        if (*chars == '\\') {
            [escapedString appendString:@"\\\\"];
        } else if (*chars == '\'') {
            [escapedString appendString:@"\\'"];
        } else if (*chars == 0xa) {
            [escapedString appendString:@"\\n"];
        } else if (*chars == 0xd) {
            [escapedString appendString:@"\\r"];
        } else {
            [escapedString appendFormat:@"%c", *chars];
        }
        ++chars;
    }
    return escapedString;
}

#pragma mark - Instance

- (NSString*) data {
    return [self stringByEvaluatingJavaScriptFromString:@"CKEDITOR.instances.editor.getData()"];
}

- (void) dataDidChange {
    if ([self.data isEqualToString:_previousData]) return; // Prevent duplicate calls to dataDidChange (in particular keys)
    _previousData = self.data;
    if ([self.editorDelegate respondsToSelector:@selector(editor:didChangeData:)]) {
        [self.editorDelegate editor:self didChangeData:self.data];
    }
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

- (void) replaceEditor {
    [self replaceEditorWithConfig:nil];
}

- (void) replaceEditorWithConfig:(NSString*)config {
    if (!config) {
        config = kCKEditorDefaultConfig;
    }
    NSString *html = [NSString stringWithFormat:kCKEditorTemplate, config];
    NSURL *baseURL = [[NSBundle bundleForClass:self.class] URLForResource:@"ckeditor.min" withExtension:nil];
    [self.mainFrame loadHTMLString:html baseURL:baseURL];
}

- (void) setData:(NSString *)data {
    data = [CKEditor escapeJavaScriptString:data];
    NSString *js = [NSString stringWithFormat:@"CKEDITOR.instances.editor.setData('%@')", data];
    [self stringByEvaluatingJavaScriptFromString:js];
}

#pragma mark - Private

- (void)webViewDidChange:(NSNotification *)notification {
    [self dataDidChange];
}

@end
