//
//  CKUtils.h
//  CKEditor4ObjC
//
//  Created by Hermes Pique on 9/21/12.
//
//

#import <Foundation/Foundation.h>

static NSString* CKEscapeJavaScriptString(NSString* value) {
    if (!value) return nil;
    const char *chars = [value UTF8String];
    NSMutableString *escapedString = [NSMutableString string];
    while (*chars) {
        if (*chars == '\\') {
            [escapedString appendString:@"\\\\"];
        } else if (*chars == '\'') {
            [escapedString appendString:@"\\'"];
        } else if (*chars == 0xa) {
            [escapedString appendString:@"\\n"];
        } else {
            [escapedString appendFormat:@"%c", *chars];
        }
        ++chars;
    }
    return escapedString;
}

@interface CKUtils : NSObject

@end
