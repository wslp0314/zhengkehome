//
//  LTMaskClipView.m
//  GasChat
//
//  Created by Martin Yin on 3/15/2016.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import "LTMaskClipView.h"

@implementation LTMaskClipView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    self.backgroundColor = [UIColor blackColor];
    self.clipsToBounds = FALSE;
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor blackColor];
    self.clipsToBounds = FALSE;

    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *child = [super hitTest:point withEvent:event];
    
    if(child == self && self.subviews.count > 0) {
        return self.subviews.firstObject;
    }
    
    return child;
}

@end
