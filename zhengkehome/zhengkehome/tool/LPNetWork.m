//
//  LPNetWork.m
//  ivicariosapp
//
//  Created by wslp0314 on 2016/12/21.
//  Copyright © 2016年 libingting. All rights reserved.
//

#import "LPNetWork.h"
#import "GCCommons.h"
#import "GCBaseModel.h"

@implementation LPHTTPManager

+ (instancetype)shareHttpManager{
    
    static LPHTTPManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LPHTTPManager manager];
        instance.requestSerializer.timeoutInterval = 10.0;
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//        [instance.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"application/json", @"application/x-www-form-urlencoded", nil]];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        // 是否允许,NO-- 不允许无效的证书
        [securityPolicy setAllowInvalidCertificates:NO];
        [securityPolicy setValidatesDomainName:NO];
        instance.securityPolicy = securityPolicy;
        
    });
    
    return  instance;
    
}


+ (void)managerNetworkWithBaseUrl:(NSString *)baseurl andAppendURL:(NSString*)url
                       RequestWay:(NSString*)way
                       Parameters:(id)parameters
                         finished:(void (^)(id data))finished
                          failure:(void (^)(NSError* error))failure
{
    LPHTTPManager *instance;
    instance = [LPHTTPManager manager];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 是否允许,NO-- 不允许无效的证书
    [securityPolicy setAllowInvalidCertificates:NO];
    [securityPolicy setValidatesDomainName:NO];
    instance.securityPolicy = securityPolicy;
    instance.requestSerializer = [AFJSONRequestSerializer serializer];
    instance.responseSerializer = [AFJSONResponseSerializer serializer];
    
    instance.requestSerializer.timeoutInterval = 10.0;
    instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    //刘璞
//    NSString *cookiesdata =[[NSUserDefaults standardUserDefaults]objectForKey:Token]?[[NSUserDefaults standardUserDefaults]objectForKey:Token]:@"";
//    NSString *cookiesuuid = [[NSUserDefaults standardUserDefaults]objectForKey:UUID]?[[NSUserDefaults standardUserDefaults]objectForKey:UUID]:@"";
//    if (![cookiesdata isEqualToString:@""]&&![url isEqualToString:@"/api/v1/login"]) {
//        //        NSString *str = [@"Basic " stringByAppendingString:[NSString stringWithFormat:@"%@:%@",cookiesuuid,cookiesdata]];
//        //        str = [NSString base64StringFromData:[str dataUsingEncoding:NSUTF8StringEncoding] length:str.length];
//        //        [instance.requestSerializer setValue:str forHTTPHeaderField:@"Authentization"];
//        [instance.requestSerializer setAuthorizationHeaderFieldWithUsername:cookiesuuid password:cookiesdata];
//    }
    NSString *urlPath = [baseurl stringByAppendingString:url];
    if ([way isEqualToString:@"POST"]) {
        
        [instance POST:urlPath parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"%lld", uploadProgress.totalUnitCount);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            finished(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failure(error);
        }];
        
    }else if ([way isEqualToString:@"GET"]) {
        [instance GET:urlPath parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"%lld", downloadProgress.totalUnitCount);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            finished(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failure(error);
        }];
        
    }
}



@end

@implementation LPHTTPSManager
+ (instancetype)shareHTTPSManager{
    
    static LPHTTPSManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        // 是否允许,NO-- 不允许无效的证书
        [securityPolicy setAllowInvalidCertificates:YES];
        [securityPolicy setValidatesDomainName:NO];
        instance = [LPHTTPSManager manager];
        //        instance.requestSerializer setValue:<#(nullable NSString *)#> forHTTPHeaderField:<#(nonnull NSString *)#>
        instance.requestSerializer.timeoutInterval = 10.0;
        instance.responseSerializer = [AFHTTPResponseSerializer serializer];
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        instance.securityPolicy = securityPolicy;
    });
    
    return instance;
    
}


+ (void)managerNetworkWithBaseUrl:(NSString *)baseurl andAppendURL:(NSString*)url
                       RequestWay:(NSString*)way
                       Parameters:(id)parameters
                         finished:(void (^)(id data))finished
                          failure:(void (^)(NSError* error))failure
{
    LPHTTPSManager *instance;
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    // 是否允许,NO-- 不允许无效的证书
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setValidatesDomainName:NO];
    instance = [LPHTTPSManager manager];
    instance.requestSerializer.timeoutInterval = 10.0;
    instance.responseSerializer = [AFHTTPResponseSerializer serializer];
    instance.requestSerializer = [AFJSONRequestSerializer serializer];
    if (kLPServerBackground) {
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];

    } else {
//        if ([url rangeOfString:@"login"].location == NSNotFound) {
//            [instance.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:kLPToken]forHTTPHeaderField:@"Cookie"];
//        }
//        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json;charset=utf-8", nil];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        [instance.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }
    instance.securityPolicy = securityPolicy;
    //刘璞
//    NSString *cookiesdata =[[NSUserDefaults standardUserDefaults]objectForKey:Token]?[[NSUserDefaults standardUserDefaults]objectForKey:Token]:@"";
//    NSString *cookiesuuid = [[NSUserDefaults standardUserDefaults]objectForKey:UUID]?[[NSUserDefaults standardUserDefaults]objectForKey:UUID]:@"";
//    if (![cookiesdata isEqualToString:@""]&&![url isEqualToString:@"/api/v1/login"]) {
//        //        NSString *str = [@"Basic " stringByAppendingString:[NSString stringWithFormat:@"%@:%@",cookiesuuid,cookiesdata]];
//        //        str = [NSString base64StringFromData:[str dataUsingEncoding:NSUTF8StringEncoding] length:str.length];
//        //        [instance.requestSerializer setValue:str forHTTPHeaderField:@"Authentization"];
//        [instance.requestSerializer setAuthorizationHeaderFieldWithUsername:cookiesuuid password:cookiesdata];
//    }
    NSString *urlPath;
    if (url.length) {
        urlPath = [baseurl stringByAppendingString:url];
    }else {
        urlPath = baseurl;
    }
    NSLog(@"请求url:%@",urlPath);
    if ([way isEqualToString:@"POST"]) {
        
        [instance POST:urlPath parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"%lld", uploadProgress.totalUnitCount);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            finished(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failure(error);
        }];
        
    } else if ([way isEqualToString:@"GET"]) {
        [instance GET:urlPath parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"%lld", downloadProgress.totalUnitCount);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            finished(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failure(error);
        }];
        
    } else if ([way isEqualToString:@"DELELT"]) {
        [instance DELETE:urlPath parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finished(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    } else if ([way isEqualToString:@"PUT"]) {
        [instance PUT:urlPath parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finished(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }
}


/**
 上传图片请求

 @param baseurl
 @param url
 @param way POST
 @param multipartFiller
 @param finished
 @param failure
 */
+ (void)uploadImageWithBaseUrl:(NSString *)baseurl andAppendURL:(NSString*)url
                    RequestWay:(NSString*)way
               multipartFiller:(BOOL (^)(void (^)(NSData * __nonnull data, NSString * __nonnull name, NSString * __nullable fileName)))multipartFiller
                      finished:(void (^)(id data))finished
                       failure:(void (^)(NSError* error))failure
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *urlPath;
    if (url.length) {
        urlPath = [baseurl stringByAppendingString:url];
    }else {
        urlPath = baseurl;
    }
    NSError *error;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        multipartFiller(^(NSData *data, NSString *name, NSString *fileName) {
            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"multipart/form-data"];
        });
    } error:&error];
    
    if (request) {
        NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            if (error) {
                failure(error);
            } else {
                finished(responseObject);
            }
        }];
        [uploadTask resume];
    } else {
        failure(error);
    }
}

/**
 @param url 需要上传的地址
 @param parameters 请求体(需要上传的参数)
 @param fileData 需要上传的数据
 @param name 服务器上的name(在本程序就是"software")
 @param fileName 文件的名字
 @param mimeType (本程序就是"application/octet-stream")
 @param progress
 @param success
 @param failure
 */
+ (void)upLoadToUrlString:(NSString* )url parameters:(NSDictionary *)parameters fileData:(NSData *)fileData name:(NSString* )name fileName:(NSString* )fileName mimeType:(NSString* )mimeType response:style progress:(void (^)(NSProgress* ))progress success:(void (^)(NSURLSessionDataTask* , id))success failure:(void (^)(NSURLSessionDataTask* , NSError* ))failure {
    
    //1.获取单例的网络管理对象
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.根据style 的类型 去选择返回值得类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //3.设置相应数据支持的类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"application/json", @"application/x-www-form-urlencoded", nil]];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(task, error);
        }
    }];
}


+ (NSURLSessionDownloadTask *)downloadFileWithUrl:(NSString *)url andSwVer:(NSString *)swVer DownloadProgress:(DownloadProgress)progress DownloadCompletion:(CompletionState)completion{
    // 1、 设置请求
    NSURL * URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *jsonstr = [NSString stringWithFormat:@"{\"sw_ver\":\"%@\"}",swVer];
    
    NSData *JSONData = [jsonstr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:JSONData];
    
    // 2、初始化
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    // 3、开始下载
    NSURLSessionDownloadTask * task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount,1.0 * downloadProgress.totalUnitCount,1.0 * downloadProgress.completedUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //这里要返回一个NSURL，其实就是文件的位置路径
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        //使用建议的路径
        path = [path stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"%@",path);
        return [NSURL fileURLWithPath:path];//转化为文件路径
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //如果下载的是压缩包的话，可以在这里进行解压
        NSLog(@"----%@---%d---%@",error.domain,error.code,error);
        //下载成功
        if (error == nil) {
            completion(YES,@"下载完成",[filePath path]);
        }else{//下载失败的时候，只列举判断了两种错误状态码
            NSString * message = nil;
            if (error.code == - 1005) {
                message = @"网络异常";
            }else if (error.code == -1001){
                message = @"请求超时";
            }else{
                message = @"未知错误";
            }
            completion(NO,message,nil);
        }
    }];
    return task;
}
+ (void)pause:(NSURLSessionDownloadTask *)task{
    [task suspend];
}
+ (void)start:(NSURLSessionDownloadTask *)task{
    [task resume];
}
#pragma mark --- 监控当前网络状态(WiFi状态可以下载) 实践证明这个网络监控有延缓，
+ (void)MonitorNetState{
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    /**
     *  AFNetworkReachabilityStatusUnknown   未知状态  -1
     *  AFNetworkReachabilityStatusNotReachable 没有网络 0
     *  AFNetworkReachabilityStatusReachableViaWWAN  3G  1
     *  AFNetworkReachabilityStatusReachableViaWiFi WiFi    2
     *
     */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"no");
            [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"NetState"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            NSLog(@"yes");
            [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"NetState"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
    
    
}


@end
