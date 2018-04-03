//
//  LTMaskImageView.m
//  GasChat
//
//  Created by Martin Yin on 3/15/2016.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import "LTMaskImageView.h"

@interface LTMaskImageView ()

@property (strong, nonatomic) UIView *backgroundView;

@end

@implementation LTMaskImageView

- (instancetype)initWithImage:(UIImage *)image backgroundView:(UIView *)backgroundView {
    self = [super initWithImage:image];
    
    self.userInteractionEnabled = TRUE;
    self.multipleTouchEnabled = TRUE;
    
    self.backgroundView = backgroundView;
    
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return self.backgroundView;
}

@end
