//
//  CKEditorTemplate.h
//  CKEditor4ObjC
//
//  Created by Hermes Pique on 9/21/12.
//
//

#import <Foundation/Foundation.h>

NSString *kCKEditorTemplate = @"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">"
"<html xmlns=\"http://www.w3.org/1999/xhtml\">"
"<head>"
    "<script type=\"text/javascript\" src=\"ckeditor.js\"></script>"
"</head>"
"<body>"
    "<textarea id=\"editor\" name=\"editor\">&nbsp;</textarea>"
    "<script type=\"text/javascript\">"
        "CKEDITOR.replace('editor', {"
            "extraPlugins : 'osxcolor',"
            "toolbarCanCollapse: false,"
            "removePlugins: 'contextmenu, liststyle, tabletools, elementspath, resize',"
// liststyle and tabletools are required to disable context menu (see: http://stackoverflow.com/a/12216307/143378 )
            "toolbar : ["
                "{ name: 'styles', items : [ 'Font', 'FontSize' ] },"
                "{ name: 'colors', items : [ 'TextColor', 'TextColorOSX' ] },"
                "{ name: 'basicstyles', items : [ 'Bold','Italic' ] },"
                "{ name: 'paragraph', items : [ 'JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },"
            "],"
            "on : {"
                "'instanceReady': function(evt) {"
                    "evt.editor.execCommand('maximize');"
                "}"
            "}"
        "});"
    "</script>"
"</body>"
"</html>";
