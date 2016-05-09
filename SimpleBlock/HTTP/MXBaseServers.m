//
//  MXBaseServers.m
//  SimpleBlock
//
//  Created by YISHANG on 16/5/9.
//  Copyright © 2016年 YISHANG. All rights reserved.
//

#import "MXBaseServers.h"
#import "MXServerConfig.h"

@interface MXBaseServers ()
@property (nonatomic, weak) id<MXBaseServiceProtocol> child;
@property (nonatomic, strong) NSString *customApiBaseUrl;
@end

@implementation MXBaseServers
@synthesize privateKey = _privateKey, apiBaseUrl = _apiBaseUrl;


- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(MXBaseServiceProtocol)]) {
            self.child = (id<MXBaseServiceProtocol>)self;
#ifdef MX_BUILD_FOR_RELEASE
            // 优先宏定义正式环境
            self.environmentType = EnvironmentTypeRelease;
#else
            // 手动切换环境后会把设置保存
            NSNumber *type = [[NSUserDefaults standardUserDefaults] objectForKey:@"environmentType"];
            if (type) {
                self.environmentType = (EnvironmentType)[type integerValue];
            } else {
#ifdef MX_BUILD_FOR_DEVELOP
                self.environmentType = EnvironmentTypeDevelop;
#elif defined MX_BUILD_FOR_TEST
                self.environmentType = EnvironmentTypeTest;
#elif defined MX_BUILD_FOR_PRODUCT
                self.environmentType = EnvironmentTypePreRelease;
#elif defined MX_BUILD_FOR_HOTFIX
                self.environmentType = EnvironmentTypeHotFix;
#endif
            }
#endif
        } else {
            NSAssert(NO, @"之类没有实现协议");
        }
    }
    return self;
}

#pragma msrk - getter and setter
- (void)setEnvironmentType:(EnvironmentType)environmentType {
    if (environmentType == EnvironmentTypeCustom) {
        if (![[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass([self class])]) {
            [[NSUserDefaults standardUserDefaults] setObject:self.apiBaseUrl forKey:NSStringFromClass([self class])];
        }
    }
        else {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSStringFromClass([self class])];
        }
    
    _environmentType = environmentType;
    _apiBaseUrl = nil;
}

- (NSString *)privateKey {
    if (!_privateKey) {
        _privateKey = @"mxmxmx";
    }
    return _privateKey;
}

- (NSString *)apiBaseUrl {
    if (_apiBaseUrl == nil) {
        switch (self.environmentType) {
            case EnvironmentTypeDevelop:
                _apiBaseUrl = self.child.developApiBaseUrl;
                break;
                case EnvironmentTypeTest:
                _apiBaseUrl = self.child.testApiBaseUrl;
                break;
                case EnvironmentTypePreRelease:
                _apiBaseUrl = self.child.prereleaseApiBaseUrl;
                break;
                case EnvironmentTypeRelease:
                _apiBaseUrl = self.child.releaseApiBaseUrl;
                break;
                case EnvironmentTypeCustom:
                _apiBaseUrl = self.customApiBaseUrl;
                break;
            default:
                break;
        }
    }
    return _apiBaseUrl;
}

- (NSString *)customApiBaseUrl {
    if (_customApiBaseUrl) {
        _customApiBaseUrl = [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass([self class])];
    }
    return _customApiBaseUrl;
}

@end
