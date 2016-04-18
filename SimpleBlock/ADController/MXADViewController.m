//
//  MXADViewController.m
//  SimpleBlock
//
//  Created by YISHANG on 16/4/18.
//  Copyright © 2016年 YISHANG. All rights reserved.
//

#import "MXADViewController.h"

@interface MXADViewController ()

@end

@implementation MXADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonOnClick) name:@"buttonClick" object:_button];
    [self configUI];
}

- (void)configUI {
    self.button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.button.frame = CGRectMake(100, 500, 200, 40);
    self.button.backgroundColor = [UIColor whiteColor];
    [self.button setTitle:@"开始" forState:(UIControlStateNormal)];
    [self.button addTarget:self action:@selector(buttonOnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.button];
}

- (void)buttonOnClick {
    NSLog(@"%s", __func__);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WindowDismiss" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
