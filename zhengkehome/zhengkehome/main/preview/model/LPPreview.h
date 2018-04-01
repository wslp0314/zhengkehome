//
//  LPPreview.h
//  zhengkehome
//
//  Created by wslp0314 on 2018/3/31.
//  Copyright © 2018年 zhenghome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPPreview : NSObject
@property (strong, nonatomic) NSString *title;//短租标题
@property (strong, nonatomic) NSString *content;//房屋简介
@property (strong, nonatomic) NSString *price;//月租金额
@property (strong, nonatomic) NSString *landlord;//联系人
@property (strong, nonatomic) NSString *hosetype;//房屋户型
@property (strong, nonatomic) NSString *housefuction;//押金形式
@property (strong, nonatomic) NSString *phonenum;//联系方式
@property (strong, nonatomic) NSString *releasetime;//发布时间
@property (strong, nonatomic) NSString *title_type;//租赁方式
@property (strong, nonatomic) NSString *address_content;//?
@property (strong, nonatomic) NSArray  *houseImageList;//房屋照片
@property (strong, nonatomic) NSString *address;//房屋地址
@property (strong, nonatomic) NSString *houseOrientation;//房屋朝向
@property (strong, nonatomic) NSString *houseFloor;//房屋楼层
@property (strong, nonatomic) NSString *houseArea;//房屋面积
@property (strong, nonatomic) NSString *lordIcon;//头像
@property (strong, nonatomic) NSString *hope;//期望用户
@end
