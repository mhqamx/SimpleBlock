//
//  MXServerConfig.h
//  SimpleBlock
//
//  Created by YISHANG on 16/5/9.
//  Copyright © 2016年 YISHANG. All rights reserved.
//

#ifndef MXServerConfig_h
#define MXServerConfig_h

#if !defined MX_BUILD_FOR_DEVELOP && !defined MX_BUILD_FOR_TEST && !defined MX_BUILD_FOR_RELEASE && !defined MX_BUILD_FOR_PRPDUCT

#define MX_BUILD_FOR_DEVELOP
#define MX_BUILD_FOR_TEST
#define MX_BUILD_FOR_RELEASE
#define MX_BUILD_FOR_PRODUCT
#endif


#if (defined(DEBUG) || defined(ADHOC) || !defined YA_BUILD_FOR_RELEASE)
#define MXLog(format, ...)  NSLog((@"FUNC:%s\n" "LINE:%d\n" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define MXLog(format, ...)
#endif

typedef NS_ENUM(NSUInteger, MXServiceType) {
    MXServiceA, // 服务器A
    MXServiceB // 服务器B
};


typedef NS_ENUM(NSUInteger, MXAPIManagerRequestType) {
    MXAPIManagerRequestTypeGet,             // get请求
    MXAPIManagerRequestTypePost,            // post请求
    MXAPIManagerRequestTypePostUpload,      // post上传
    MXAPIManagerRequestTypeGetDownload      // 下载文件
};

typedef NS_ENUM(NSUInteger, DataEngineAlertType) {
    DataEngineAlertType_None,
    DataEngineAlertType_Toast,
    DataEngineAlertType_Alert,
    DataEngineAlertType_ErrorView
};


typedef void(^ProgressBlock)(NSProgress *taskProgress);
typedef void(^CompletionDataBlock)(id data, NSError *error);
typedef void(^ErrorAlertSelectIndexBlock)(NSUInteger buttonIndex);

#endif

