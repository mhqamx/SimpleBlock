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
    
//    [self justaTestMethod];
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

- (void)justaTestMethod {
    NSLog(@"-----%s", __func__);
}

- (void)PopAction {
    int radomNo = arc4random()%255;
//    self.text_block(self.textField.text);
//    self.color_block(kColorWithRGB(radomNo, radomNo, radomNo));
//    self.image_block([UIImage imageNamed:@"57"]);
    
    [self.kdelegate sendMessagewithString:self.textField.text];
    [self.kdelegate test];
    if ([self.kdelegate respondsToSelector:@selector(sendMessagewithString:)]) {
        NSLog(@"-------- 实现了协议方法");
    }
    
    NSAssert(self.view != nil, @"系统断言");
    
    // respondsToSelector:@selector()
    // 判断对象是否响应了@SEL方法 返回值类型BOOL
    if ([self.kdelegate respondsToSelector:@selector(test)]) {
        // performSelector:@selector(performMethod) withObject:nil afterDelay:0.0
        // perform 执行方法
        [self performSelector:@selector(performMethod) withObject:nil afterDelay:0.0];
    }

    
    self.trans_block(self.textField.text, kColorWithRGB(radomNo, radomNo, radomNo), [UIImage imageNamed:@"57"]);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)performMethod {
    NSLog(@"1111111------%s", __func__);
}

@end
