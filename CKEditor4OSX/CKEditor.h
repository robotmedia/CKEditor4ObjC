//
//  RMCKEditor.h
//  CKEditor4Cocoa
//
//  Created by Hermes Pique on 9/20/12.
//  Copyright (c) 2012 Robot Media. All rights reserved.
//

#import <WebKit/WebKit.h>

@protocol CKEditorDelegate;

@interface CKEditor : WebView

// Wait until instanceReady to set.
@property (nonatomic, strong) NSString *data;

@property (nonatomic, weak) IBOutlet id<CKEditorDelegate> editorDelegate;

- (void) setConfig:(NSString*)config;

#pragma mark - WebScripting

- (void) instanceReady;

- (void) openColorPanel; // for osxbuttons plugin

- (void) openFontPanel; // for osxbuttons plugin

@end

@protocol CKEditorDelegate <NSObject>
@optional

- (void) instanceReadyInEditor:(CKEditor*)editor;

@end
