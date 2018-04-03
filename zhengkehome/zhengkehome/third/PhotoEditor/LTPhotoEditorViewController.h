//
//  LTPhotoEditorViewController.h
//  GasChat
//
//  Created by Martin Yin on 3/15/2016.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import "LTBaseViewController.h"

@class LTPhotoEditorViewController;
typedef void(^LTPhotoEditorFinishHandler)(LTPhotoEditorViewController * __nonnull editorViewController, UIImage * __nonnull image, NSString * __nullable imageName);

@interface LTPhotoEditorViewController : LTBaseViewController

@property (nonnull,  copy,   nonatomic) LTPhotoEditorFinishHandler finishHandler;
@property (nullable, strong, nonatomic) NSString  *imageName;
@property (nonnull,  strong, nonatomic) UIImage   *originImage;
@property (          assign, nonatomic) BOOL      isCircleCrop;
@property (          assign, nonatomic) CGSize    cropSize;

@end
