//
//  plugin.js
//  CKEditor4Cocoa
//
//  Created by Hermes Pique on 9/20/12.
//  Copyright (c) 2012 Robot Media. All rights reserved.
//

CKEDITOR.plugins.add('osxcolor', {
    init: function(editor) {
        editor.addCommand('selectTextColor', {
            exec: function(editor) {
                Cocoa.selectTextColor();
            }
        });
        editor.ui.addButton('TextColorOSX', {
            label: 'Text Color',
            command: 'selectTextColor',
            icon: this.path + 'images/timestamp.png'
        });
    }
});