//
//  UIColor+HexColor.h
//  LngtopFramework
//
//  Created by Martin Yin on 3/16/2015.
//  Copyright (c) 2015 Lngtop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIColor *)colorWithInt:(int)intColor;
+ (UIColor *)colorWithInt:(int)intColor alpha:(CGFloat)alpha;
+ (UIColor *)colorWithIntRed:(int)red green:(int)green blue:(int)blue;
+ (UIColor *)colorWithIntRed:(int)red green:(int)green blue:(int)blue alpha:(CGFloat)alpha;

+ (UIColor *)colorWithIntString:(NSString *)intColorString;

@end
