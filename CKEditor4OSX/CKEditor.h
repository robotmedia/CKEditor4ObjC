//
//  RMCKEditor.h
//  CKEditor4Cocoa
//
//  Created by Hermes Pique on 9/20/12.
//  Copyright (c) 2012 Robot Media. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface CKEditor : WebView

@property (nonatomic, strong) NSString *data;

- (void) setConfig:(NSString*)config;

// WebScripting for osxbuttons plugin

- (void) openColorPanel;

- (void) openFontPanel;

@end
