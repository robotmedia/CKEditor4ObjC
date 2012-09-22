/*
 Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config )
{
    config.skin = 'osx';
    config.extraPlugins = 'osxbuttons';
    config.toolbarCanCollapse = false;
    config.removePlugins = 'contextmenu, liststyle, tabletools, elementspath, resize'; // liststyle and tabletools are required to disable context menu. See: http://stackoverflow.com/a/12216307/143378
    
    config.toolbar = 'TextEdit';
    
    config.toolbar_TextEdit = [
        { name: 'styles', items : [ 'OSXFont','FontSize' ] },
        { name: 'font', items : [ 'OSXTextColor' ] },
        { name: 'basicstyles', items : [ 'Bold', 'Italic', 'Underline' ] },
        { name: 'paragraph', items : [ 'JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
    ];
};
