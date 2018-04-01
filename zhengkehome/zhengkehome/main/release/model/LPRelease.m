//
//  LPRelease.m
//  zhengkehome
//
//  Created by wslp0314 on 2018/3/31.
//  Copyright © 2018年 zhenghome. All rights reserved.
//

#import "LPRelease.h"
#import "GCCommons.h"
#import "LPNetWork.h"

@implementation LPRelease
+ (instancetype)carInfo {
    static dispatch_once_t once;
    static LPRelease *release = nil;
    dispatch_once(&once, ^{
        release = [[LPRelease alloc] init];
    });
    return release;
}


/**
 返回数据
 {
 "state":"201",
 "id":100
 }
 注:id=100，为房屋信息id
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"state"     :     @"state",
             @"releaseID" :     @"id"
             };
}

//1.发布房源信息
- (void)releaseHouseInfoWithHouseTitle:(NSString *)houseTitle
                       andHouseContent:(NSString *)houseContent
                         andHousePrice:(NSString *)housePrice
                          andHouseLord:(NSString *)houseLord
                          andHouseType:(NSString *)houseType
                       andhouseFuction:(NSString *)houseFunction
                       andLordPhoneNum:(NSString *)LordPhoneNum
                        andReleaseTime:(NSString *)releaseTime
                           andRentType:(NSString *)rentType
                     andHouseImageList:(NSArray  *)houseImageList
                            andAddress:(NSString *)address
                   andHouseOrientation:(NSString *)houseOrientation
                         andHouseFloor:(NSString *)houseFloor
                          andHouseArea:(NSString *)houseArea
                           andLordIcon:(NSString *)lordIcon
                               andHope:(NSString *)hope
                            completion:(void (^)(LPRelease *release,
                                                 NSDictionary *json,
                                                 NSError *error)
                                        )completion {
    NSDictionary *infoDic = @{
                             @"car_serial"     :houseTitle,
                             @"car_serial"     :houseContent,
                             @"car_serial"     :housePrice,
                             @"car_serial"     :houseLord,
                             @"car_serial"     :houseType,
                             @"car_serial"     :houseFunction,
                             @"car_serial"     :LordPhoneNum,
                             @"car_serial"     :releaseTime,
                             @"car_serial"     :rentType,
                             @"car_serial"     :houseImageList,
                             @"car_serial"     :address,
                             @"car_serial"     :houseOrientation,
                             @"car_serial"     :houseFloor,
                             @"car_serial"     :houseArea,
                             @"car_serial"     :lordIcon,
                             @"car_serial"     :hope
                             };
    [self userPostInfoWithUri:@"/api/v1/wechat/house" andParamters:infoDic andRequestWay:@"POST" completion:^(LPRelease *carInfo, NSDictionary *json, NSError *error) {
        completion(carInfo,json,error);
    }];
}

//2.修改房源信息
- (void)modifyHouseInfoWithHouseTitle:(NSString *)houseTitle
                       andHouseContent:(NSString *)houseContent
                         andHousePrice:(NSString *)housePrice
                          andHouseLord:(NSString *)houseLord
                          andHouseType:(NSString *)houseType
                       andhouseFuction:(NSString *)houseFunction
                       andLordPhoneNum:(NSString *)LordPhoneNum
                        andReleaseTime:(NSString *)releaseTime
                           andRentType:(NSString *)rentType
                     andHouseImageList:(NSArray  *)houseImageList
                            andAddress:(NSString *)address
                   andHouseOrientation:(NSString *)houseOrientation
                         andHouseFloor:(NSString *)houseFloor
                          andHouseArea:(NSString *)houseArea
                           andLordIcon:(NSString *)lordIcon
                               andHope:(NSString *)hope
                            completion:(void (^)(LPRelease *release,
                                                 NSDictionary *json,
                                                 NSError *error)
                                        )completion {
    NSDictionary *infoDic = @{
                              @"car_serial"     :houseTitle,
                              @"car_serial"     :houseContent,
                              @"car_serial"     :housePrice,
                              @"car_serial"     :houseLord,
                              @"car_serial"     :houseType,
                              @"car_serial"     :houseFunction,
                              @"car_serial"     :LordPhoneNum,
                              @"car_serial"     :releaseTime,
                              @"car_serial"     :rentType,
                              @"car_serial"     :houseImageList,
                              @"car_serial"     :address,
                              @"car_serial"     :houseOrientation,
                              @"car_serial"     :houseFloor,
                              @"car_serial"     :houseArea,
                              @"car_serial"     :lordIcon,
                              @"car_serial"     :hope
                              };
    [self userPostInfoWithUri:@"/api/v1/wechat/house" andParamters:infoDic andRequestWay:@"PUT" completion:^(LPRelease *carInfo, NSDictionary *json, NSError *error) {
        completion(carInfo,json,error);
    }];
}

//3.获取房屋信息
- (void)getHouseInfoWithHouseTitle:(NSString *)houseTitle
                       andHouseContent:(NSString *)houseContent
                         andHousePrice:(NSString *)housePrice
                          andHouseLord:(NSString *)houseLord
                          andHouseType:(NSString *)houseType
                       andhouseFuction:(NSString *)houseFunction
                       andLordPhoneNum:(NSString *)LordPhoneNum
                        andReleaseTime:(NSString *)releaseTime
                           andRentType:(NSString *)rentType
                     andHouseImageList:(NSArray  *)houseImageList
                            andAddress:(NSString *)address
                   andHouseOrientation:(NSString *)houseOrientation
                         andHouseFloor:(NSString *)houseFloor
                          andHouseArea:(NSString *)houseArea
                           andLordIcon:(NSString *)lordIcon
                               andHope:(NSString *)hope
                            completion:(void (^)(LPRelease *release,
                                                 NSDictionary *json,
                                                 NSError *error)
                                        )completion {
    NSDictionary *infoDic = @{
                              @"car_serial"     :houseTitle,
                              @"car_serial"     :houseContent,
                              @"car_serial"     :housePrice,
                              @"car_serial"     :houseLord,
                              @"car_serial"     :houseType,
                              @"car_serial"     :houseFunction,
                              @"car_serial"     :LordPhoneNum,
                              @"car_serial"     :releaseTime,
                              @"car_serial"     :rentType,
                              @"car_serial"     :houseImageList,
                              @"car_serial"     :address,
                              @"car_serial"     :houseOrientation,
                              @"car_serial"     :houseFloor,
                              @"car_serial"     :houseArea,
                              @"car_serial"     :lordIcon,
                              @"car_serial"     :hope
                              };
    [self userPostInfoWithUri:@"/api/v1/wechat/house" andParamters:infoDic andRequestWay:@"GET" completion:^(LPRelease *carInfo, NSDictionary *json, NSError *error) {
        completion(carInfo,json,error);
    }];
}




//4.删除房源信息
- (void)deleteHouseInfoWithHouseTitle:(NSString *)houseTitle
                      andHouseContent:(NSString *)houseContent
                        andHousePrice:(NSString *)housePrice
                         andHouseLord:(NSString *)houseLord
                         andHouseType:(NSString *)houseType
                      andhouseFuction:(NSString *)houseFunction
                      andLordPhoneNum:(NSString *)LordPhoneNum
                       andReleaseTime:(NSString *)releaseTime
                          andRentType:(NSString *)rentType
                    andHouseImageList:(NSArray  *)houseImageList
                           andAddress:(NSString *)address
                  andHouseOrientation:(NSString *)houseOrientation
                        andHouseFloor:(NSString *)houseFloor
                         andHouseArea:(NSString *)houseArea
                          andLordIcon:(NSString *)lordIcon
                              andHope:(NSString *)hope
                           completion:(void (^)(LPRelease *release,
                                                NSDictionary *json,
                                                NSError *error)
                                       )completion {
    NSDictionary *infoDic = @{
                              @"car_serial"     :houseTitle,
                              @"car_serial"     :houseContent,
                              @"car_serial"     :housePrice,
                              @"car_serial"     :houseLord,
                              @"car_serial"     :houseType,
                              @"car_serial"     :houseFunction,
                              @"car_serial"     :LordPhoneNum,
                              @"car_serial"     :releaseTime,
                              @"car_serial"     :rentType,
                              @"car_serial"     :houseImageList,
                              @"car_serial"     :address,
                              @"car_serial"     :houseOrientation,
                              @"car_serial"     :houseFloor,
                              @"car_serial"     :houseArea,
                              @"car_serial"     :lordIcon,
                              @"car_serial"     :hope
                              };
    [self userPostInfoWithUri:@"/api/v1/wechat/house" andParamters:infoDic andRequestWay:@"DELETE" completion:^(LPRelease *carInfo, NSDictionary *json, NSError *error) {
        completion(carInfo,json,error);
    }];
}

//5.上传房源照片(在界面上实现  参考:https://www.jianshu.com/p/850475044b40)





//公用请求方法
- (void)userPostInfoWithUri:(NSString *)uri andParamters:(NSDictionary *)parameters andRequestWay:(NSString *)way completion:(void (^)(LPRelease *release, NSDictionary *json, NSError *error))completion {
    [LPHTTPSManager managerNetworkWithBaseUrl:kLPTestURL andAppendURL:uri RequestWay:way Parameters:parameters finished:^(id data) {
        NSDictionary * dic2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic2);
        [self fillWithDictionary:dic2];
        completion(self,dic2,nil);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        completion(nil,nil,error);
    }];
}



@end
