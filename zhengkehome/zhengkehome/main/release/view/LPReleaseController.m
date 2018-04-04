//
//  LPReleaseController.m
//  zhengkehome
//
//  Created by wslp0314 on 2018/4/3.
//  Copyright © 2018年 zhenghome. All rights reserved.
//

#import "LPReleaseController.h"
#import "ZLPhotoActionSheet.h"
#import "ZLDefine.h"
#import "ImageCell.h"
#import "YYFPSLabel.h"
#import <Photos/Photos.h>
#import "ZLPhotoModel.h"
#import "ZLPhotoManager.h"
#import "ZLProgressHUD.h"
#import "ZLPhotoConfiguration.h"
#import "LTPhotoEditorViewController.h"
#import "LPConfig.h"

#define kHeight 60


@interface LPReleaseController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *houseTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *houseAreaTextField;
@property (weak, nonatomic) IBOutlet UITextField *houseOrientationTextField;
@property (weak, nonatomic) IBOutlet UITextField *houseFloorTextField;
@property (weak, nonatomic) IBOutlet UITextField *houseTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *houseFunctionTextField;
@property (weak, nonatomic) IBOutlet UITextField *HouseTitleTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *housePriceTextField;
@property (weak, nonatomic) IBOutlet UIButton *addHouseImageBtn;
@property (weak, nonatomic) IBOutlet UITextView *houseAddressTextView;
@property (weak, nonatomic) IBOutlet UITextView *houseContentTextView;
@property (weak, nonatomic) IBOutlet UITextField *houseLordTextField;
@property (weak, nonatomic) IBOutlet UITextField *lordPhoneNumTextField;
@property (weak, nonatomic) IBOutlet UIImageView *lordIcon;
@property (weak, nonatomic) IBOutlet UIButton *addIconBtn;
@property (weak, nonatomic) IBOutlet UITextView *hopeTextView;

@property (nonatomic, strong) NSMutableArray<UIImage *> *lastSelectPhotos;
@property (nonatomic, strong) NSMutableArray<PHAsset *> *lastSelectAssets;
@property (nonatomic, strong) NSMutableArray<UIImage *> *lastOneSelectPhotos;
@property (nonatomic, strong) NSMutableArray<PHAsset *> *lastOneSelectAssets;

@property (nonatomic, strong) NSArray *arrDataSources;
@property (nonatomic, assign) BOOL isOriginal;

@property (nonatomic, assign) BOOL isOneImage;


@end

@implementation LPReleaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initCollectionView];
}

- (IBAction)addHouseImage:(id)sender {
    self.isOneImage = NO;
    [self showWithPreview:NO];

}

- (IBAction)addLordIcon:(id)sender {
    self.isOneImage = YES;
    [self showWithPreview:NO];
}


- (void)showWithPreview:(BOOL)preview
{
    ZLPhotoActionSheet *a = [self getPas];
    
    if (preview) {
        [a showPreviewAnimated:YES];
    } else {
        [a showPhotoLibrary];
    }
}

- (ZLPhotoActionSheet *)getPas
{
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    
#pragma mark - 参数配置 optional，可直接使用 defaultPhotoConfiguration
    
//    //以下参数为自定义参数，均可不设置，有默认值
//    actionSheet.configuration.sortAscending = self.sortSegment.selectedSegmentIndex==0;
//    actionSheet.configuration.allowSelectImage = self.selImageSwitch.isOn;
//    actionSheet.configuration.allowSelectGif = self.selGifSwitch.isOn;
    actionSheet.configuration.allowSelectVideo = NO;
//    actionSheet.configuration.allowSelectLivePhoto = self.selLivePhotoSwitch.isOn;
//    actionSheet.configuration.allowForceTouch = self.allowForceTouchSwitch.isOn;
//    actionSheet.configuration.allowEditImage = self.allowEditSwitch.isOn;
//    actionSheet.configuration.allowEditVideo = self.allowEditVideoSwitch.isOn;
//    actionSheet.configuration.allowSlideSelect = self.allowSlideSelectSwitch.isOn;
//    actionSheet.configuration.allowMixSelect = self.mixSelectSwitch.isOn;
//    actionSheet.configuration.allowDragSelect = self.allowDragSelectSwitch.isOn;
//    //设置相册内部显示拍照按钮
//    actionSheet.configuration.allowTakePhotoInLibrary = self.takePhotoInLibrarySwitch.isOn;
//    //设置在内部拍照按钮上实时显示相机俘获画面
//    actionSheet.configuration.showCaptureImageOnTakePhotoBtn = self.showCaptureImageSwitch.isOn;
//    //设置照片最大预览数
//    actionSheet.configuration.maxPreviewCount = ;
//    //设置照片最大选择数
    actionSheet.configuration.maxSelectCount = self.isOneImage?1:9;
//    //设置允许选择的视频最大时长
//    actionSheet.configuration.maxVideoDuration = self.maxVideoDurationTextField.text.integerValue;
//    //设置照片cell弧度
//    actionSheet.configuration.cellCornerRadio = self.cornerRadioTextField.text.floatValue;
//    //单选模式是否显示选择按钮
//    //    actionSheet.configuration.showSelectBtn = YES;
//    //是否在选择图片后直接进入编辑界面
//    actionSheet.configuration.editAfterSelectThumbnailImage = self.editAfterSelectImageSwitch.isOn;
//    //是否保存编辑后的图片
//    //    actionSheet.configuration.saveNewImageAfterEdit = NO;
//    //设置编辑比例
//    //    actionSheet.configuration.clipRatios = @[GetClipRatio(7, 1)];
//    //是否在已选择照片上显示遮罩层
//    actionSheet.configuration.showSelectedMask = self.maskSwitch.isOn;
//    //颜色，状态栏样式
//    //    actionSheet.configuration.selectedMaskColor = [UIColor purpleColor];
//    //    actionSheet.configuration.navBarColor = [UIColor orangeColor];
//    //    actionSheet.configuration.navTitleColor = [UIColor blackColor];
//    //    actionSheet.configuration.bottomBtnsNormalTitleColor = kRGB(80, 160, 100);
//    //    actionSheet.configuration.bottomBtnsDisableBgColor = kRGB(190, 30, 90);
//    //    actionSheet.configuration.bottomViewBgColor = [UIColor blackColor];
//    //    actionSheet.configuration.statusBarStyle = UIStatusBarStyleDefault;
//    //是否允许框架解析图片
//    actionSheet.configuration.shouldAnialysisAsset = self.allowAnialysisAssetSwitch.isOn;
//    //框架语言
//    actionSheet.configuration.languageType = self.languageSegment.selectedSegmentIndex;
    //自定义多语言
    //    actionSheet.configuration.customLanguageKeyValue = @{@"ZLPhotoBrowserCameraText": @"没错，我就是一个相机"};
    
    //是否使用系统相机
    //    actionSheet.configuration.useSystemCamera = YES;
    //    actionSheet.configuration.sessionPreset = ZLCaptureSessionPreset1920x1080;
    //    actionSheet.configuration.exportVideoType = ZLExportVideoTypeMp4;
    //    actionSheet.configuration.allowRecordVideo = NO;
    
#pragma mark - required
    //如果调用的方法没有传sender，则该属性必须提前赋值
    actionSheet.sender = self;
    //记录上次选择的图片
    actionSheet.arrSelectedAssets = self.isOneImage?self.lastOneSelectAssets:self.lastSelectAssets;
    
    zl_weakify(self);
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        zl_strongify(weakSelf);
        if (self.isOneImage) {
            LTPhotoEditorViewController *photoEditor = [[UIStoryboard storyboardWithName:@"PhotoEditor" bundle:[NSBundle mainBundle]]instantiateInitialViewController];
            photoEditor.hidesBottomBarWhenPushed = YES;
            photoEditor.imageName = @"lordIcon";
            photoEditor.originImage = images.firstObject;
            [photoEditor setIsCircleCrop:YES];
            [photoEditor setCropSize:CGSizeMake(CGRectGetWidth([[self view] frame]), CGRectGetWidth([[self view] frame]))];
            [photoEditor setFinishHandler:^(LTPhotoEditorViewController *editorViewController, UIImage *image, NSString *imageName) {
                self.lordIcon.image = image;
                [[self navigationController] popViewControllerAnimated:YES];
                //刘璞
                strongSelf.lastOneSelectAssets = assets.mutableCopy;
                strongSelf.lastOneSelectPhotos = images.mutableCopy;
            }];
            
            [self.navigationController pushViewController:photoEditor animated:YES];
        } else {
            strongSelf.arrDataSources = images;
            strongSelf.isOriginal = isOriginal;
            strongSelf.lastSelectAssets = assets.mutableCopy;
            strongSelf.lastSelectPhotos = images.mutableCopy;
            [strongSelf.collectionView reloadData];
            NSLog(@"image:%@", images);
            [strongSelf anialysisAssets:assets original:isOriginal];
        }
        
        //解析图片
    }];
    
    actionSheet.cancleBlock = ^{
        NSLog(@"取消选择图片");
    };
    
    return actionSheet;
}

- (void)anialysisAssets:(NSArray<PHAsset *> *)assets original:(BOOL)original
{
    ZLProgressHUD *hud = [[ZLProgressHUD alloc] init];
    //该hud自动15s消失，请使用自己项目中的hud控件
    [hud show];
    
    zl_weakify(self);
    [ZLPhotoManager anialysisAssets:assets original:original completion:^(NSArray<UIImage *> *images) {
        zl_strongify(weakSelf);
        [hud hide];
        strongSelf.arrDataSources = images;
        [strongSelf.collectionView reloadData];
        NSLog(@"%@", images);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kHeight-6), (kHeight-6));
    layout.minimumInteritemSpacing = 1.5;
    layout.minimumLineSpacing = 1.5;
    layout.sectionInset = UIEdgeInsetsMake(3, 0, 3, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.collectionView registerClass:NSClassFromString(@"ImageCell") forCellWithReuseIdentifier:@"ImageCell"];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    
    //设置textView控件的颜色
    self.houseAddressTextView.layer.borderColor = [LPColor(215, 215, 215) CGColor];
    self.hopeTextView.layer.borderColor = [LPColor(215, 215, 215) CGColor];
    self.houseContentTextView.layer.borderColor = [LPColor(215, 215, 215) CGColor];
    
//    self.tableView.backgroundColor = LPColor(172, 172, 172);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrDataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    cell.imageView.image = _arrDataSources[indexPath.row];
    PHAsset *asset = self.lastSelectAssets[indexPath.row];
    cell.playImageView.hidden = !(asset.mediaType == PHAssetMediaTypeVideo);
    
    return cell;
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==6&&indexPath.row ==10) {
        return kHeight;
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

#pragma mark - text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


@end
