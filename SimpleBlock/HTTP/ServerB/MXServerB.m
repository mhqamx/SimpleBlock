//
//  MXServerB.m
//  SimpleBlock
//
//  Created by YISHANG on 16/5/9.
//  Copyright © 2016年 YISHANG. All rights reserved.
//

#import "MXServerB.h"

@implementation MXServerB
@synthesize developApiBaseUrl = _developApiBaseUrl, testApiBaseUrl = _testApiBaseUrl, prereleaseApiBaseUrl = _prereleaseApiBaseUrl, releaseApiBaseUrl = _releaseApiBaseUrl, hotfixApiBaseUrl = _hotfixApiBaseUrl;

-(NSString *)developApiBaseUrl {
    if (!_developApiBaseUrl) {
        _developApiBaseUrl = @"http://www.baidu.com";
    }
    return _developApiBaseUrl;
}

- (NSString *)testApiBaseUrl {
    if (!_testApiBaseUrl) {
        _testApiBaseUrl = @"http://www.google.com";
    }
    return _testApiBaseUrl;
}

- (NSString *)prereleaseApiBaseUrl {
    if (!_prereleaseApiBaseUrl) {
        _prereleaseApiBaseUrl = @"http://www.163.com";
    }
    return _prereleaseApiBaseUrl;
}

- (NSString *)hotfixApiBaseUrl {
    if (!_hotfixApiBaseUrl) {
        _hotfixApiBaseUrl = @"http://www.tencent.com";
    }
    return _hotfixApiBaseUrl;
}

- (NSString *)releaseApiBaseUrl {
    if (!_releaseApiBaseUrl) {
        _releaseApiBaseUrl = @"http://www.github.com";
    }
    return _releaseApiBaseUrl;
}
@end
