//
//  UIColor+HexColor.m
//  LngtopFramework
//
//  Created by Martin Yin on 3/16/2015.
//  Copyright (c) 2015 Lngtop. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

+ (UIColor *)colorWithInt:(int)intColor {
    return [self colorWithInt:intColor alpha:1.0f];
}

+ (UIColor *)colorWithInt:(int)intColor alpha:(CGFloat)alpha {
    int red = (intColor & 0xFF0000) >> 16;
    int green = (intColor & 0x00FF00) >> 8;
    int blue = (intColor & 0x0000FF);
    
    return [self colorWithIntRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithIntRed:(int)red green:(int)green blue:(int)blue {
    return [self colorWithIntRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)colorWithIntRed:(int)red green:(int)green blue:(int)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(float)red/255.0f green:(float)green/255.0f blue:(float)blue/255.0f alpha:alpha];
}

+ (UIColor *)colorWithIntString:(NSString *)intColorString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:intColorString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithIntRed:((rgbValue & 0xFF0000) >> 16) green:((rgbValue & 0xFF00) >> 8) blue:(rgbValue & 0xFF)];
}

@end
