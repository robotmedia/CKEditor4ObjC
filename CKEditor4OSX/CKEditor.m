//
//  RMCKEditor.m
//  CKEditor4Cocoa
//
//  Created by Hermes Pique on 9/20/12.
//  Copyright (c) 2012 Robot Media. All rights reserved.
//

#import "CKEditor.h"
#import "CKEditorTemplate.h"
#import "CKUtils.h"
#import "NSColor+String.h"

@implementation CKEditor

- (id) initWithFrame:(NSRect)frame frameName:(NSString *)frameName groupName:(NSString *)groupName {
    if (self = [super initWithFrame:frame frameName:frameName groupName:groupName]) {
        self.frameLoadDelegate = self;
        self.mainFrame.frameView.allowsScrolling = NO;
        NSURL *baseURL = [[NSBundle bundleForClass:self.class] URLForResource:@"ckeditor" withExtension:nil];
        [self.mainFrame loadHTMLString:kCKEditorTemplate baseURL:baseURL];
    }
    return self;
}

- (void) dealloc {
    // TODO: Is this necessary?
    [[NSColorPanel sharedColorPanel] setTarget:nil];
}

#pragma mark - WebFrameLoadDelegate

- (void)webView:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowScriptObject forFrame:(WebFrame *)frame
{
    [windowScriptObject setValue:self forKey:@"Cocoa"];
}

#pragma mark - WebScripting 

+ (NSString*)webScriptNameForSelector:(SEL)sel
{
    if (sel == @selector(selectTextColor)) return @"selecTextColor";
    return nil;
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)sel
{
    if(sel == @selector(selectTextColor)) return NO;
    return YES;
}

#pragma mark - Instance

- (NSString*) data {
    return [self stringByEvaluatingJavaScriptFromString:@"CKEDITOR.instances.editor.getData()"];
}

- (void) setData:(NSString *)data {
    data = CKEscapeJavaScriptString(data);
    NSString *js = [NSString stringWithFormat:@"CKEDITOR.instances.editor.setData('%@')", data];
    [self stringByEvaluatingJavaScriptFromString:js];
}

- (void) selectTextColor {
    NSColorPanel *panel = [NSColorPanel sharedColorPanel];
    [panel orderFront:self];
    // No need to do anything else. Selected text color is changed auto-magically.
    // TODO: Find out why.
}

- (void) setConfig:(NSString*)config {
    NSString *js = [NSString stringWithFormat:@"CKEDITOR.instances.editor.destroy();CKEDITOR.replace('editor', %@);", config];
    [self stringByEvaluatingJavaScriptFromString:js];
}

#pragma mark - Private

@end
