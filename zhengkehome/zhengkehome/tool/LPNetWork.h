//
//  LPNetWork.h
//  ivicariosapp
//
//  Created by wslp0314 on 2016/12/21.
//  Copyright © 2016年 libingting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^DownloadProgress) (CGFloat progress,CGFloat total,CGFloat current);
typedef void(^CompletionState) (BOOL state,NSString * message,NSString * filePath);

@interface LPHTTPManager : AFHTTPSessionManager


+ (instancetype)shareHttpManager;
+ (void)managerNetworkWithBaseUrl:(NSString *)baseurl andAppendURL:(NSString*)url
                       RequestWay:(NSString*)way
                       Parameters:(id)parameters
                         finished:(void (^)(id data))finished
                          failure:(void (^)(NSError* error))failure;
@end


@interface LPHTTPSManager : AFHTTPSessionManager

+ (instancetype)shareHTTPSManager;
//https正常请求
+ (void)managerNetworkWithBaseUrl:(NSString *)baseurl andAppendURL:(NSString*)url
                       RequestWay:(NSString*)way
                       Parameters:(id)parameters
                         finished:(void (^)(id data))finished
                          failure:(void (^)(NSError* error))failure;
//上传
+ (void)upLoadToUrlString:(NSString* )url
               parameters:(NSDictionary *)parameters
                 fileData:(NSData *)fileData
                     name:(NSString* )name
                 fileName:(NSString* )fileName
                 mimeType:(NSString* )mimeType
                 response:style
                 progress:(void (^)(NSProgress* ))progress
                  success:(void (^)(NSURLSessionDataTask* , id))success
                  failure:(void (^)(NSURLSessionDataTask* , NSError* ))failure;
//下载
+ (NSURLSessionDownloadTask *)downloadFileWithUrl:(NSString *)url
                                         andSwVer:(NSString *)swVer
                                 DownloadProgress:(DownloadProgress)progress
                               DownloadCompletion:(CompletionState)completion;


+ (void)pause:(NSURLSessionDownloadTask *)task;
+ (void)start:(NSURLSessionDownloadTask *)task;
@end
