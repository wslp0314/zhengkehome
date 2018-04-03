//
//  LTPhotoEditorViewController.m
//  GasChat
//
//  Created by Martin Yin on 3/15/2016.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import "LTPhotoEditorViewController.h"
#import "LTMaskClipView.h"
#import "LTMaskImageView.h"
#import "UIView+EasyUseGeometry.h"

@interface LTPhotoEditorViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet  LTMaskClipView  *clipView;
@property (strong, nonatomic)           UIScrollView    *scrollView;
@property (strong, nonatomic)           UIImageView     *imageView;
@property (strong, nonatomic) IBOutlet  UIView          *actionView;
@property (strong, nonatomic) IBOutlet  UIButton        *cancelButton;
@property (strong, nonatomic) IBOutlet  UIButton        *pickButton;

@property (assign, nonatomic) BOOL needShowStatusBarWhenDismiss;

@end

@implementation LTPhotoEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect maskRect = CGRectMake((self.view.width-self.cropSize.width)/2, (self.view.height-self.cropSize.height)/2, self.cropSize.width, self.cropSize.height);
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:maskRect];
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.clipsToBounds = FALSE;
    self.scrollView.delegate = self;
    self.scrollView.alwaysBounceHorizontal = FALSE;
    self.scrollView.alwaysBounceVertical = FALSE;
    self.scrollView.decelerationRate = 0;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    self.scrollView.showsVerticalScrollIndicator = FALSE;
    
    [self.clipView addSubview:self.scrollView];
    
    self.imageView = [[UIImageView alloc] initWithImage:self.originImage];
    [self.scrollView addSubview:self.imageView];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    UIGraphicsBeginImageContextWithOptions(screenSize, FALSE, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor colorWithWhite:0 alpha:0.5] CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, screenSize.width, screenSize.height));
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
    if(self.isCircleCrop) {
        CGContextFillEllipseInRect(context, maskRect);
    } else {
        CGContextFillRect(context, maskRect);
    }
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    if(self.isCircleCrop) {
        CGContextStrokeEllipseInRect(context, maskRect);
    } else {
        CGContextStrokeRect(context, maskRect);
    }
    
    UIImage *maskImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    LTMaskImageView *maskImageView = [[LTMaskImageView alloc] initWithImage:maskImage backgroundView:self.scrollView];
    [self.view insertSubview:maskImageView belowSubview:self.actionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.needShowStatusBarWhenDismiss = [[UIApplication sharedApplication] isStatusBarHidden] == FALSE;
//    if(self.needShowStatusBarWhenDismiss) {
//        [[UIApplication sharedApplication] setStatusBarHidden:TRUE withAnimation:UIStatusBarAnimationFade];
//    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGFloat ratio = MAX(self.scrollView.width/self.originImage.size.width, self.scrollView.height/self.originImage.size.height);
    
    self.scrollView.contentSize = self.originImage.size;
    self.scrollView.maximumZoomScale = MAX(1.0, ceilf(MAX(self.cropSize.width/self.originImage.size.width, self.cropSize.height/self.originImage.size.height)));
    self.scrollView.minimumZoomScale = ratio;
    self.scrollView.zoomScale = ratio;
    self.scrollView.contentOffset = CGPointMake(0, (self.scrollView.contentSize.height-self.scrollView.height)*0.5);
    
    [self.view bringSubviewToFront:self.actionView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.clipView.height = self.view.height;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if(self.needShowStatusBarWhenDismiss) {
        [[UIApplication sharedApplication] setStatusBarHidden:FALSE withAnimation:UIStatusBarAnimationFade];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)invokeOnCancel:(id)sender {
    if(self.presentingViewController) {
        [self dismissViewControllerAnimated:TRUE completion:nil];
    } else if(self.navigationController) {
        [self.navigationController popViewControllerAnimated:TRUE];
    }
}

- (IBAction)invokeOnPickImage:(id)sender {
    if(self.scrollView.zooming || self.scrollView.zoomBouncing) {
        return;
    }

    self.pickButton.enabled = FALSE;
    
    UIImage *scaledImage = [UIImage imageWithCGImage:self.originImage.CGImage scale:1.0/self.scrollView.zoomScale orientation:self.originImage.imageOrientation];
    
    UIGraphicsBeginImageContextWithOptions(self.cropSize, FALSE, self.originImage.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if(self.isCircleCrop) {
        CGRect clipRect = CGRectMake(0, 0, self.cropSize.width, self.cropSize.height);
        CGContextAddEllipseInRect(context, clipRect);
        CGContextClip(context);
        CGContextClearRect(context, clipRect);
    }
    
    [scaledImage drawInRect:CGRectMake(-self.scrollView.contentOffset.x, -self.scrollView.contentOffset.y, scaledImage.size.width, scaledImage.size.height)];
    UIImage *croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.finishHandler(self, croppedImage, self.imageName);
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    for (UIView *subview in self.scrollView.subviews) {
        CGFloat offsetX = 0;
        if(scrollView.bounds.size.width > scrollView.contentSize.width) {
            offsetX = scrollView.bounds.size.width - scrollView.contentSize.width;
        }
        CGFloat offsetY = 0;
        if(scrollView.bounds.size.height > scrollView.contentSize.height) {
            offsetY = scrollView.bounds.size.height - scrollView.contentSize.height;
        }
        
        if([subview isKindOfClass:[UILabel class]]) {
            offsetY = subview.center.y - scrollView.contentSize.height * 0.5;
        }
        
        subview.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.pickButton.enabled = FALSE;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if(!decelerate && !scrollView.zooming && !scrollView.zoomBouncing) {
        self.pickButton.enabled = TRUE;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(!scrollView.zooming && !scrollView.zoomBouncing) {
        self.pickButton.enabled = TRUE;
    }
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    self.pickButton.enabled = FALSE;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if(!scrollView.dragging && !scrollView.decelerating) {
        self.pickButton.enabled = TRUE;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
