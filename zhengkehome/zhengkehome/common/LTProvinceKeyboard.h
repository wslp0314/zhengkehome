//
//  LTProvinceKeyboard.h
//  GasChat
//
//  Created by Martin Yin on 1/22/2016.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTProvinceKeyboard;
@protocol LTProvinceKeyboardDelegate <NSObject>

- (void)nextTextfieldRespon;

@end
@interface LTProvinceKeyboard : UIView <UIInputViewAudioFeedback>

@property (strong, nonatomic) NSArray *characterKeys;
@property (strong, nonatomic) UIButton *returnButton;
@property (strong, nonatomic) id<UITextInput> textView;
@property (weak, nonatomic) id<LTProvinceKeyboardDelegate>delegate;

+ (NSArray *)defaultProvince;

- (id)initWithProvinces:(NSArray *)provinces;

- (void)returnPressed:(id)sender;
- (void)characterPressed:(id)sender;

@end
