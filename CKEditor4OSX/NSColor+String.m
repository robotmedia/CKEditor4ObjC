//
//  NSColor+String.m
//  LittleRobotStoryBuilder
//
//  Created by Miquel Soler on 1/13/12.
//  Copyright (c) 2012 Robot Media. All rights reserved.
//

// Taken from http://developer.apple.com/library/mac/#qa/qa1576/_index.html

#import "NSColor+String.h"

@implementation NSColor (String)

- (NSString *)hexFromColor {
    CGFloat redFloatValue, greenFloatValue, blueFloatValue, alphaFloatValue;
    int redIntValue, greenIntValue, blueIntValue, alphaIntValue = 0;
    NSString *redHexValue, *greenHexValue, *blueHexValue, *alphaHexValue;

    //Convert the NSColor to the RGB color space before we can access its components
    NSColor *convertedColor=[self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];

    if (convertedColor) {
        // Get the red, green, and blue components of the color
        [convertedColor getRed:&redFloatValue green:&greenFloatValue blue:&blueFloatValue alpha:&alphaFloatValue];

        // Convert the components to numbers (unsigned decimal integer) between 0 and 255
        redIntValue = (int)(redFloatValue * 255.99999f);
        greenIntValue = (int)(greenFloatValue * 255.99999f);
        blueIntValue = (int)(blueFloatValue * 255.99999f);
        if (alphaFloatValue < 1.0f) alphaIntValue = (int)(alphaFloatValue * 255.99999f);

        // Convert the numbers to hex strings
        redHexValue = [NSString stringWithFormat:@"%02x", redIntValue]; 
        greenHexValue = [NSString stringWithFormat:@"%02x", greenIntValue];
        blueHexValue = [NSString stringWithFormat:@"%02x", blueIntValue];
        if (alphaFloatValue < 1.0f) alphaHexValue = [NSString stringWithFormat:@"%02x", alphaIntValue];

        // Concatenate the red, green, blue and alpha components' hex strings together with a "#"
        if (alphaFloatValue < 1.0f) {
            return [NSString stringWithFormat:@"#%@%@%@%@", redHexValue, greenHexValue, blueHexValue, alphaHexValue];
        } else {
            return [NSString stringWithFormat:@"#%@%@%@", redHexValue, greenHexValue, blueHexValue];
        }
    }
    return nil;
}

@end
