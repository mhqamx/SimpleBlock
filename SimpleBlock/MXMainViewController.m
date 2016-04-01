//
//  MXMainViewController.m
//  SimpleBlock
//
//  Created by YISHANG on 16/4/1.
//  Copyright © 2016年 YISHANG. All rights reserved.
//

#import "MXMainViewController.h"
#import "MXSecViewController.h"
#import <Masonry.h>
@interface MXMainViewController ()<sendMessageDelegate>
/**
 *  接收颜色的label
 */
@property (nonatomic, strong) UILabel  *color_label;

/**
 *  接收传来的图片
 */
@property (nonatomic, strong) UIImageView  *imageView;

/**
 *  接收文字
 */
@property (nonatomic, strong) UILabel  *text_label;


@end

@implementation MXMainViewController
#pragma mark  - Lazy Initialization
- (UILabel *)color_label {
    if (!_color_label) {
        _color_label = [[UILabel alloc] init];
        _color_label.text = @"传递颜色";
    }
    return _color_label;
}

- (UILabel *)text_label {
    if (!_text_label) {
        _text_label = [[UILabel alloc] init];
        _text_label.backgroundColor = [UIColor redColor];
    }
    return _text_label;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor cyanColor];
    }
    return _imageView;
}

#pragma mark - Life Cycle
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark - Private Methods
- (void)configUI {
    [self.view addSubview:self.text_label];
    [self.view addSubview:self.color_label];
    [self.view addSubview:self.imageView];
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"Push" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(PushAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    [_text_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.center.mas_equalTo(self.view.mas_centerY).offset(-200);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@30);
    }];
    
    [_color_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.center.mas_equalTo(self.view.mas_centerY).offset(100);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@30);
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.center.mas_equalTo(self.view.mas_centerY).offset(0);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@100);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.center.mas_equalTo(self.view.mas_centerY).offset(150);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@30);
    }];
}

- (void)PushAction {
    MXSecViewController *secVC = [[MXSecViewController alloc] init];
    
    secVC.kdelegate = self;
    
    /*
    [secVC setText_block:^(NSString *newStr){
        self.text_label.text = newStr;
    }];
    
    [secVC setColor_block:^(UIColor *newColor){
        self.color_label.backgroundColor = newColor;
    }];
    
    [secVC setImage_block:^(UIImage *newImage) {
        self.imageView.image = newImage;
    }];
    */
    [secVC setTrans_block:^(NSString *newStr, UIColor *newColor, UIImage *newImage){
        self.text_label.text = newStr;
        self.color_label.backgroundColor = newColor;
        self.imageView.image = newImage;
    }];
    
    [self.navigationController pushViewController:secVC animated:YES];
}

- (void)sendMessagewithString:(NSString *)newString {
    self.title = newString;
}
@end
