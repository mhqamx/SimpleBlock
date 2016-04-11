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


#import "MXMainViewController.h"
#import "MXSecViewController.h"
#import <Masonry.h>
@interface MXMainViewController ()<sendMessageDelegate, UIScrollViewDelegate>
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

#pragma mark - Life Cycle
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self configScrollView];
}

#pragma mark - Private Methods
- (void)touchAction1 {
    NSLog(@"%s", __func__);
}


- (void)touchAction2 {
    NSLog(@"%s", __func__);
}


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

- (void)configScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(WIDTH * 3, HEIGHT);
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate = self;
    scrollView.tag = 10001;
    scrollView.pagingEnabled = YES;
    [self.contentView addSubview:scrollView];
    
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

    [self.window addSubview:self.contentView];
    [self.contentView addSubview:scrollView];
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

- (void)sendMessagewithString:(NSString *)newString {
    self.title = newString;
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
    
    CGFloat alpha = 2 - scrollView.contentOffset.x / scrollView.frame.size.width;
    scrollView.alpha = alpha;
//    self.pageControl.alpha = alpha;
    self.view.alpha = 1 - alpha;
    NSLog(@"alpha ----- %f", alpha);
    if (scrollView.contentOffset.x > WIDTH * 1.99) {
        [self.contentView removeFromSuperview];
        self.window = nil;
    }
    else {
        NSLog(@"%s", __func__);
    }

}

@end
