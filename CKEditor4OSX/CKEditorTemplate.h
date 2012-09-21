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
            "extraPlugins: 'uicolor',"
            "removePlugins: 'elementspath, resize',"
            "toolbar : [[ 'Bold', 'Italic', 'Underline','NumberedList','BulletedList']],"
            "on : {"
                "'instanceReady': function(evt) {"
                    "evt.editor.execCommand('maximize');"
                "}"
            "}"
        "});"
    "</script>"
"</body>"
"</html>";
