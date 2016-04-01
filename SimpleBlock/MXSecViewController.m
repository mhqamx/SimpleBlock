//
//  MXSecViewController.m
//  SimpleBlock
//
//  Created by YISHANG on 16/4/1.
//  Copyright © 2016年 YISHANG. All rights reserved.
//
#define kColorWithRGB(r, g, b) [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:1.f]  

#import "MXSecViewController.h"
#import <Masonry.h>

@interface MXSecViewController ()
@property (nonatomic, strong) UITextField  *textField;

@end

@implementation MXSecViewController

#pragma mark  - Lazy Initialization
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"Please input message here";
        _textField.layer.borderColor = [UIColor blackColor].CGColor;
        _textField.layer.borderWidth = 0.5;
        _textField.borderStyle = UITextBorderStyleLine;
    }
    return _textField;
}

#pragma mark - Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark - Private Methods
- (void)configUI {
    [self.view addSubview:self.textField];
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"Pop" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(PopAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.center.mas_equalTo(self.view.mas_centerY).offset(-200);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@30);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.center.mas_equalTo(self.view.mas_centerY).offset(-100);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@30);
    }];
    
}

- (void)PopAction {
//    self.text_block(self.textField.text);
    int radomNo = arc4random()%255;
//    self.color_block(kColorWithRGB(radomNo, radomNo, radomNo));
//    self.image_block([UIImage imageNamed:@"57"]);
    
    self.trans_block(self.textField.text, kColorWithRGB(radomNo, radomNo, radomNo), [UIImage imageNamed:@"57"]);
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
