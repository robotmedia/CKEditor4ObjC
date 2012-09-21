//
//  plugin.js
//  CKEditor4Cocoa
//
//  Created by Hermes Pique on 9/20/12.
//  Copyright (c) 2012 Robot Media. All rights reserved.
//

function osx_isUnstylable(ele) {
    return (ele.getAttribute('contentEditable') == 'false' ) || ele.getAttribute('data-nostyle');
}

function osx_setTextColor(editor, htmlColor) {
    var colorStyle = {
		element: 'span',
		styles: {'color' : '#(color)' },
		overrides: [{element: 'font', attributes: {'color' : null}}],
        childRule: function(element)
        {
            // Fore color style must be applied inside links instead of around it. (#4772,#6908)
            return !(element.is('a') || element.getElementsByTag('a').count() ) || osx_isUnstylable(element);
        }
	};
    new CKEDITOR.style(colorStyle, {color: htmlColor}).apply(editor.document);
}

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