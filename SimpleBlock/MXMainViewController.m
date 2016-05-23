//
//  MXMainViewController.m
//  SimpleBlock
//
//  Created by YISHANG on 16/4/1.
//  Copyright © 2016年 YISHANG. All rights reserved.
//

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds

/**
 *  通过修改ADCount来修改初始页数
 */
#define ADCount 4

#import "MXMainViewController.h"
#import "MXSecViewController.h"
#import <Masonry.h>
#import "MXADViewController.h"
#import "MXRootExampleVC.h"
#import "MXWebVC.h"
@interface MXMainViewController ()<sendMessageDelegate, UIScrollViewDelegate, UIActionSheetDelegate>
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

/**
 *  承载ScrollView的View
 */
@property (nonatomic, strong) UIView  *contentView;

/**
 *  显示全屏使用Window
 */
@property (nonatomic, strong) UIWindow  *window;

/**
 *  显示广告页的Window
 */
@property (nonatomic, strong) UIWindow  *ADwindow;

/**
 *  切换网络环境的button
 */
@property (nonatomic, strong) UIButton  *environmentBtn;

/**
 *  主域
 */
@property (nonatomic, copy) NSString  *mainString;


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

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:SCREEN_SIZE];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:SCREEN_SIZE];
        _window.windowLevel = UIWindowLevelStatusBar + 1000;
        [_window makeKeyAndVisible];
    }
    return _window;
}

- (UIWindow *)ADwindow {
    if (!_ADwindow) {
        _ADwindow = [[UIWindow alloc] initWithFrame:SCREEN_SIZE];
        [_ADwindow makeKeyAndVisible];
    }
    return _ADwindow;
}

#pragma mark - Life Cycle
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.mainString = @"";
    self.title = self.mainString;
    /**
     *  添加观察者
     *
     *  @param disMissWindow 将window制空的方法
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disMissWindow) name:@"WindowDismiss" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disMissWindow) name:UIWindowDidBecomeHiddenNotification object:_ADwindow];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showButton) name:@"showChangeenvironmentButton" object:nil];;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self configScrollView];
    MXADViewController *adVC = [[MXADViewController alloc] init];
    [self.ADwindow setRootViewController:adVC];
}

#pragma mark - Private Methods
/**
 *  要将window的rootController和window本身一起制空 不然rootController成为野指针 继续留在界面上
 */
- (void)disMissWindow {
    self.ADwindow.rootViewController = nil;
    self.ADwindow = nil;
}

/*
- (void)touchAction1 {
    NSLog(@"%s", __func__);
}


- (void)touchAction2 {
    NSLog(@"%s", __func__);
}
*/

- (void)configUI {
    [self.view addSubview:self.text_label];
    [self.view addSubview:self.color_label];
    [self.view addSubview:self.imageView];
    
    _environmentBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_environmentBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    _environmentBtn.backgroundColor = [UIColor greenColor];
    [_environmentBtn setTitle:@"切换环境" forState:(UIControlStateNormal)];
    _environmentBtn.hidden = YES;
    [_environmentBtn addTarget:self action:@selector(changeEnvironmentAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.environmentBtn];

    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"Push" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(PushAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.backgroundColor = [UIColor yellowColor];
    [button setTitle:@"工厂模式" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(pushFactoryModelVC) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
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
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.center.mas_equalTo(self.view.mas_centerY).offset(200);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@30);
    }];
    
    [_environmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.center.mas_equalTo(self.view.mas_centerY).offset(250);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@30);
    }];

    
}

- (void)configScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(WIDTH * (ADCount + 1), HEIGHT);
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate = self;
    scrollView.tag = 10001;
    scrollView.pagingEnabled = YES;
    [self.contentView addSubview:scrollView];
    
    /*
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAction1)];
    
    UIImageView *view1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    view1.userInteractionEnabled = YES;
    [view1 addGestureRecognizer:tap1];
    view1.backgroundColor = [UIColor cyanColor];
    [scrollView addSubview:view1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAction2)];
    
    UIImageView *view2 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT)];
    view2.userInteractionEnabled = YES;
    [view2 addGestureRecognizer:tap2];
    view2.backgroundColor = [UIColor yellowColor];
    [scrollView addSubview:view2];
     */
    
    /**
     *  根据需求 后台返回不定量的图片 不能写死
     */
    
    for (int i = 0; i < ADCount; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * WIDTH, 0, WIDTH, HEIGHT)];
        view.backgroundColor = [UIColor colorWithRed:random()%255 / 255.0 green:random()%255 / 255.0 blue:random()%255 / 255.0 alpha:1];
        [scrollView addSubview:view];
        
        UIControl *control = [[UIControl alloc] initWithFrame:view.bounds];
        control.backgroundColor = [UIColor clearColor];
        control.tag = 10000 + i;
        [control addTarget:self action:@selector(taponClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:control];
    }
    [self.window addSubview:self.contentView];
    [self.contentView addSubview:scrollView];
}

- (void)taponClick:(UIControl *)control {
    for (int i = 0; i < ADCount; i++) {
        if (control.tag == 10000 + i) {
            NSLog(@"index  ==== %d", i);
        }
    }
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
    
    if (![self conformsToProtocol:@protocol(sendMessageDelegate)]) {
        NSLog(@"conformsToProtocol");
        NSAssert(![self conformsToProtocol:@protocol(sendMessageDelegate)], @"没有实现协议方法");
    }
    
    [self.navigationController pushViewController:secVC animated:YES];
}

/**
 *  跳转工厂模式
 */
- (void)pushFactoryModelVC {
    MXRootExampleVC *rootVC = [[MXRootExampleVC alloc] init];
    [self.navigationController pushViewController:rootVC animated:YES];
}

/**
 *  切换Domain的实现方法
 */
- (void)changeEnvironmentAction {
    NSLog(@"--- %s", __func__);
    UIActionSheet *alter = [[UIActionSheet alloc] initWithTitle:@"切换Domain地址" delegate:self cancelButtonTitle:@"cancle" destructiveButtonTitle:nil otherButtonTitles:@"正式环境", @"测试环境", nil];
    [alter showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    MXWebVC *webVC = [[MXWebVC alloc] init];
    if (buttonIndex == 0) {
        self.mainString = @"http://www.baidu.com";
        NSLog(@"======= %@", self.mainString);
        webVC.request = self.mainString;
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"postUrl" object:self.mainString];
        [self.navigationController pushViewController:webVC animated:YES];
    } else if (buttonIndex == 1) {
        self.mainString = @"http://www.163.com";
        NSLog(@"======= %@", self.mainString);
        webVC.request = self.mainString;
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"postUrl" object:self.mainString];
        [self.navigationController pushViewController:webVC animated:YES];
    }
    
}

/**
 *  切换环境按钮懒加载
 */
- (void)showButton {
    _environmentBtn.hidden = NO;
}

- (void)sendMessagewithString:(NSString *)newString {
//    self.title = newString;
}

- (void)test {
    NSLog(@"%s", __func__);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag != 10001) {
        return;
    }
    
//    double page = scrollView.contentOffset.x / scrollView.frame.size.width;
//    self.pageControl.currentPage = (int)(page + 0.5);
    
    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
    
    CGFloat alpha = ADCount - scrollView.contentOffset.x / scrollView.frame.size.width;
    scrollView.alpha = alpha;
    self.view.alpha = 1 - alpha;
    NSLog(@"alpha ----- %f", alpha);
    if (scrollView.contentOffset.x > WIDTH * (ADCount - 0.01)) {
        [self.contentView removeFromSuperview];
        self.window = nil;
    }
    else {
        NSLog(@"%s", __func__);
    }

}

// 实现代理协议方法
- (void)callBackMethod {
    
}

@end
