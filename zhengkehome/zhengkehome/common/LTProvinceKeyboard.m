//
//  LTProvinceKeyboard.m
//  GasChat
//
//  Created by Martin Yin on 1/22/2016.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import "LTProvinceKeyboard.h"
#import "UIView+EasyUseGeometry.h"
#import <QuartzCore/QuartzCore.h>

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

enum {
    LTKeyboardPadViewImageLeft = 0,
    LTKeyboardPadViewImageInner,
    LTKeyboardPadViewImageRight,
    LTKeyboardPadViewImageMax
};

@interface LTProvinceKeyboard ()

@property (unsafe_unretained, nonatomic) NSInteger lineMaxButton;
@property (unsafe_unretained, nonatomic) CGSize  keyboardButtonSize;
@property (unsafe_unretained, nonatomic) CGPoint keyboardButtonOrigin;
@property (unsafe_unretained, nonatomic) CGSize  keyboardButtonMargin;

@property (unsafe_unretained, nonatomic) CGSize  keyboardButtonUpperSize;

@end

@implementation LTProvinceKeyboard

+ (NSArray *)defaultProvince {
    return @[@"京", @"沪", @"浙", @"苏", @"粤", @"鲁", @"晋", @"冀", @"豫", @"川", @"渝", @"辽", @"吉", @"黑", @"皖", @"鄂", @"湘", @"赣", @"闽", @"陕", @"甘", @"宁", @"蒙", @"津", @"贵", @"云", @"桂", @"琼", @"青", @"新", @"藏", @"台"];
}

- (id)initWithProvinces:(NSArray *)provinces {
    CGRect frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, IS_IPHONE_6P?226:216);
    
    self = [super initWithFrame:frame];
    
    self.userInteractionEnabled = YES;
    
    self.returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.returnButton setBackgroundImage:[[UIImage imageNamed:@"keyboardReturnButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 7, 7) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.returnButton setTag:100];
    [self.returnButton setTitle:@"下一项" forState:UIControlStateNormal];
    [self.returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.returnButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [self.returnButton setHidden:YES];
    [self.returnButton addTarget:self action:@selector(returnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.returnButton];
    
    self.lineMaxButton = 10;
    if(IS_IPHONE_6P) {
        self.keyboardButtonSize   = CGSizeMake(35, 46);
        self.keyboardButtonOrigin = CGPointMake(4, 8);
        self.keyboardButtonMargin = CGSizeMake(6, 10);
        self.keyboardButtonUpperSize = CGSizeMake(61, 37);
    } else if(IS_IPHONE_6) {
        self.keyboardButtonSize   = CGSizeMake(31.5, 43);
        self.keyboardButtonOrigin = CGPointMake(3, 9);
        self.keyboardButtonMargin = CGSizeMake(6, 10);
        self.keyboardButtonUpperSize = CGSizeMake(57.5, 40);
    } else {
        self.keyboardButtonSize   = CGSizeMake(26, 39);
        self.keyboardButtonOrigin = CGPointMake(3, 12);
        self.keyboardButtonMargin = CGSizeMake(6, 15);
        self.keyboardButtonUpperSize = CGSizeMake(52, 44);
    }
    [self loadCharactersWithArray:provinces];
    
    return self;
}

- (void)setTextView:(id<UITextInput>)textView {
    [(UITextField *)textView setInputView:self];
    
    _textView = textView;
}

- (UIButton *)charButtonWithTitle:(NSString *)title {
    NSInteger index = [self.characterKeys indexOfObject:title];
    UIButton *button = (UIButton *)[self viewWithTag:index+1];
    if(!button) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[[UIImage imageNamed:@"keyboardButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 7, 7) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        [button setTag:index+1];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:22]];
        [button setUserInteractionEnabled:NO];
        button.size = self.keyboardButtonSize;
        
        [self addSubview:button];
    }
    
    return button;
}

- (void)loadCharactersWithArray:(NSArray *)array {
    self.characterKeys = array;
    
    NSInteger x = 0, y = 0;
    for(NSInteger i = 0; i < array.count; i++) {
        NSString *title = array[i];
        UIButton *button = [self charButtonWithTitle:title];
        
        button.left = self.keyboardButtonOrigin.x + (self.keyboardButtonSize.width +self.keyboardButtonMargin.width )*x;
        button.top  = self.keyboardButtonOrigin.y + (self.keyboardButtonSize.height+self.keyboardButtonMargin.height)*y;
        
        x ++;
        if(x >= self.lineMaxButton) {
            x = 0;
            y ++;
        }
    }
    
    [self.returnButton setFrame:CGRectMake(self.keyboardButtonOrigin.x + (self.keyboardButtonSize.width +self.keyboardButtonMargin.width )*7,
                                           self.keyboardButtonOrigin.y + (self.keyboardButtonSize.height+self.keyboardButtonMargin.height)*3,
                                           self.keyboardButtonSize.width * 3 +self.keyboardButtonMargin.width * 2,
                                           self.keyboardButtonSize.height)];
    [self.returnButton setHidden:NO];
}

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}

- (IBAction)returnPressed:(id)sender {
    [[UIDevice currentDevice] playInputClick];
    
//    if ([[(UITextField *)self.textView delegate] respondsToSelector:@selector(textFieldShouldReturn:)]) {
//        [[(UITextField *)self.textView delegate] textFieldShouldReturn:(UITextField *)self.textView];
//    }
    if ([self.delegate respondsToSelector:@selector(nextTextfieldRespon)]) {
        [self.delegate nextTextfieldRespon];
    }
}
- (IBAction)characterPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSString *character = [NSString stringWithString:button.titleLabel.text];
    
    [(UITextField *)self.textView setText:character];
    [(UITextField *)[self textView] sendActionsForControlEvents:UIControlEventEditingChanged];
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
}

#define __PADDING_X     (15)
#define __PADDING_Y     (10)

#define __UPPER_WIDTH   (self.keyboardButtonUpperSize.width)
#define __LOWER_WIDTH   (self.keyboardButtonSize.width)

#define __PAN_UPPER_RADIUS  (10.0)
#define __PAN_LOWER_RADIUS  (5.0)

#define __PAN_UPPER_WIDTH   (__UPPER_WIDTH-__PAN_UPPER_RADIUS*2)
#define __PAN_UPPER_HEIGHT  (52.0)

#define __PAN_LOWER_WIDTH   (__LOWER_WIDTH-__PAN_LOWER_RADIUS*2)
#define __PAN_LOWER_HEIGHT  (self.keyboardButtonSize.height)

#define __PAN_UL_WIDTH      ((__UPPER_WIDTH-__LOWER_WIDTH)/2)

#define __PAN_MIDDLE_HEIGHT (2.0)

#define __PAN_CURVE_SIZE    (8.0)

#define __WIDTH   (__UPPER_WIDTH + __PADDING_X*2)
#define __HEIGHT  (__PAN_UPPER_HEIGHT + __PAN_MIDDLE_HEIGHT + __PAN_LOWER_HEIGHT + __PADDING_Y*2)

- (void)addPopupToButton:(UIButton *)b {
    UIImageView *keyPop = nil;
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(__PADDING_X+__PAN_UPPER_RADIUS, __PADDING_Y,
                                                              self.keyboardButtonUpperSize.width-__PAN_UPPER_RADIUS-__PAN_UPPER_RADIUS,
                                                              self.keyboardButtonUpperSize.height+__PAN_UPPER_RADIUS+__PAN_CURVE_SIZE)];
    
    int kind = 0;
    CGPoint origin = CGPointMake(-__PADDING_X, -self.keyboardButtonSize.height-self.keyboardButtonUpperSize.height+__PADDING_Y);
    if(b.tag == 1 || b.tag == 11 || b.tag == 21 || b.tag == 31) {
        kind = LTKeyboardPadViewImageRight;
        //        origin.x -= self.keyboardButtonUpperSize.width-self.keyboardButtonSize.width;
    } else if(b.tag == 10 || b.tag == 20 || b.tag == 30) {
        kind = LTKeyboardPadViewImageLeft;
        origin.x -= self.keyboardButtonUpperSize.width-self.keyboardButtonSize.width;
    } else {
        kind = LTKeyboardPadViewImageInner;
        origin.x -= (self.keyboardButtonUpperSize.width-self.keyboardButtonSize.width)/2;
    }
    
    keyPop = [[UIImageView alloc] initWithImage:[self createiOS7KeytopImageWithKind:kind]];
    keyPop.frame = CGRectMake(origin.x, origin.y, keyPop.frame.size.width, keyPop.frame.size.height);
    
    [text setFont:[UIFont systemFontOfSize:44]];
    [text setTextAlignment:NSTextAlignmentCenter];
    [text setBackgroundColor:[UIColor clearColor]];
    [text setAdjustsFontSizeToFitWidth:YES];
    [text setText:b.titleLabel.text];
    
    keyPop.layer.shadowColor = [UIColor colorWithWhite:0.1 alpha:1.0].CGColor;
    keyPop.layer.shadowOffset = CGSizeMake(0, 2.0);
    keyPop.layer.shadowOpacity = 0.30;
    keyPop.layer.shadowRadius = 3.0;
    keyPop.clipsToBounds = NO;
    
    [keyPop addSubview:text];
    [b addSubview:keyPop];
    [self bringSubviewToFront:b];
}

- (void)touchesBegan: (NSSet *)touches withEvent: (UIEvent *)event {
    CGPoint location = [[touches anyObject] locationInView:self];
    
    for(UIView *v in self.subviews) {
        if(v.tag > 0 && [v isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)v;
            if([[[button subviews] lastObject] isKindOfClass:[UIImageView class]]) {
                [[[button subviews] lastObject] removeFromSuperview];
            }
            if(CGRectContainsPoint(button.frame, location)) {
                [self addPopupToButton:button];
                [[UIDevice currentDevice] playInputClick];
            }
        }
    }
}

- (void)touchesMoved: (NSSet *)touches withEvent: (UIEvent *)event {
    CGPoint location = [[touches anyObject] locationInView:self];
    
    for(UIView *v in self.subviews) {
        if(v.tag > 0 && [v isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)v;
            if([[[button subviews] lastObject] isKindOfClass:[UIImageView class]]) {
                [[[button subviews] lastObject] removeFromSuperview];
            }
            if(CGRectContainsPoint(button.frame, location)) {
                [self addPopupToButton:button];
            }
        }
    }
}


- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event{
    CGPoint location = [[touches anyObject] locationInView:self];
    
    for(UIView *v in self.subviews) {
        if(v.tag > 0 && [v isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)v;
            if([[[button subviews] lastObject] isKindOfClass:[UIImageView class]]) {
                [[[button subviews] lastObject] removeFromSuperview];
            }
            if(CGRectContainsPoint(button.frame, location)) {
                [self characterPressed:button];
            }
        }
    }
}

/* UI Utilities */

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)createiOS7KeytopImageWithKind:(int)kind {
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint p = CGPointMake(__PADDING_X, __PADDING_Y);
    CGPoint p1 = CGPointZero;
    CGPoint p2 = CGPointZero;
    
    p.x += __PAN_UPPER_RADIUS;
    CGPathMoveToPoint(path, NULL, p.x, p.y);
    
    p.x += __PAN_UPPER_WIDTH;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.y += __PAN_UPPER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 __PAN_UPPER_RADIUS,
                 3.0*M_PI/2.0,
                 4.0*M_PI/2.0,
                 false);
    
    p.x += __PAN_UPPER_RADIUS;
    p.y += __PAN_UPPER_HEIGHT - __PAN_UPPER_RADIUS/* - __PAN_CURVE_SIZE*/;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p1 = CGPointMake(p.x, p.y + __PAN_CURVE_SIZE);
    switch (kind) {
        case LTKeyboardPadViewImageLeft:
            p.x -= __PAN_UL_WIDTH*2;
            break;
            
        case LTKeyboardPadViewImageInner:
            p.x -= __PAN_UL_WIDTH;
            break;
            
        case LTKeyboardPadViewImageRight:
            break;
    }
    
    p.y += __PAN_MIDDLE_HEIGHT + __PAN_CURVE_SIZE*2;
    p2 = CGPointMake(p.x, p.y - __PAN_CURVE_SIZE);
    CGPathAddCurveToPoint(path, NULL,
                          p1.x, p1.y,
                          p2.x, p2.y,
                          p.x, p.y);
    
    p.y += __PAN_LOWER_HEIGHT - __PAN_CURVE_SIZE - __PAN_LOWER_RADIUS;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.x -= __PAN_LOWER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 __PAN_LOWER_RADIUS,
                 4.0*M_PI/2.0,
                 1.0*M_PI/2.0,
                 false);
    
    p.x -= __PAN_LOWER_WIDTH;
    p.y += __PAN_LOWER_RADIUS;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.y -= __PAN_LOWER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 __PAN_LOWER_RADIUS,
                 1.0*M_PI/2.0,
                 2.0*M_PI/2.0,
                 false);
    
    p.x -= __PAN_LOWER_RADIUS;
    p.y -= __PAN_LOWER_HEIGHT - __PAN_LOWER_RADIUS - __PAN_CURVE_SIZE;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p1 = CGPointMake(p.x, p.y - __PAN_CURVE_SIZE);
    
    switch (kind) {
        case LTKeyboardPadViewImageLeft:
            break;
            
        case LTKeyboardPadViewImageInner:
            p.x -= __PAN_UL_WIDTH;
            break;
            
        case LTKeyboardPadViewImageRight:
            p.x -= __PAN_UL_WIDTH*2;
            break;
    }
    
    p.y -= __PAN_MIDDLE_HEIGHT + __PAN_CURVE_SIZE*2;
    p2 = CGPointMake(p.x, p.y + __PAN_CURVE_SIZE);
    CGPathAddCurveToPoint(path, NULL,
                          p1.x, p1.y,
                          p2.x, p2.y,
                          p.x, p.y);
    
    p.y -= __PAN_UPPER_HEIGHT - __PAN_UPPER_RADIUS/* - __PAN_CURVE_SIZE*/;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.x += __PAN_UPPER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 __PAN_UPPER_RADIUS,
                 2.0*M_PI/2.0,
                 3.0*M_PI/2.0,
                 false);
    //----
    CGContextRef context;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(__WIDTH, __HEIGHT), NO, scale);
    context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, __HEIGHT);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    //----
    
    CGRect frame = CGPathGetBoundingBox(path);
    //    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:0.973 green:0.976 blue:0.976 alpha:1.000] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, frame);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    UIImage * image = [UIImage imageWithCGImage:imageRef scale:scale orientation:UIImageOrientationDown];
    CGImageRelease(imageRef);
    
    UIGraphicsEndImageContext();
    
    
    CFRelease(path);
    
    return image;
}

@end
