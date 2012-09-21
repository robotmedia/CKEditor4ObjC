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

@implementation CKEditor

- (id) initWithFrame:(NSRect)frame frameName:(NSString *)frameName groupName:(NSString *)groupName {
    if (self = [super initWithFrame:frame frameName:frameName groupName:groupName]) {
        self.mainFrame.frameView.allowsScrolling = NO;
        NSURL *baseURL = [[NSBundle bundleForClass:self.class] URLForResource:@"ckeditor" withExtension:nil];
        [self.mainFrame loadHTMLString:kCKEditorTemplate baseURL:baseURL];
    }
    return self;
}

- (void) setData:(NSString *)data {
    data = CKEscapeJavaScriptString(data);
    NSString *js = [NSString stringWithFormat:@"CKEDITOR.instances.editor.setData('%@')", data];
    [self stringByEvaluatingJavaScriptFromString:js];
}

- (NSString*) data {
    return [self stringByEvaluatingJavaScriptFromString:@"CKEDITOR.instances.editor.getData()"];
}

@end
