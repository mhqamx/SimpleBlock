//
//  AppDelegate.m
//  SimpleBlock
//
//  Created by YISHANG on 16/4/1.
//  Copyright © 2016年 YISHANG. All rights reserved.
//

#import "AppDelegate.h"
#import "MXMainViewController.h"
@interface AppDelegate ()

@end
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    // 创建导航控制器
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[MXMainViewController new]];
    
    // window设置根视图
    [self.window setRootViewController:navi];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
