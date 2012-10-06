//
//  plugin.js
//  CKEditor4Cocoa
//
//  Created by Hermes Pique on 9/20/12.
//  Copyright (c) 2012 Robot Media. All rights reserved.
//

CKEDITOR.plugins.add('osxbuttons', {
    init: function(editor) {
        editor.addCommand('openColorPanel', {
            exec: function(editor) {
                Cocoa.openColorPanel();
            }
        });
        editor.ui.addButton('OSXTextColor', {
            label: 'Text Color',
            command: 'openColorPanel',
            className: 'cke_button_osxTextColor'
        });
        editor.addCommand('openFontPanel', {
            exec: function(editor) {
                Cocoa.openFontPanel();
            }
        });
        editor.ui.addButton('OSXFont', {
            label: 'Font',
            command: 'openFontPanel',
            className: 'cke_button_osxFont'
        });
    }
});