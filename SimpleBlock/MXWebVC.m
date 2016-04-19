//
//  MXWebVC.m
//  SimpleBlock
//
//  Created by YISHANG on 16/4/19.
//  Copyright © 2016年 YISHANG. All rights reserved.
//

#import "MXWebVC.h"

@interface MXWebVC ()
@property (nonatomic, strong) UIWebView  *webView;

@end

@implementation MXWebVC

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    }
    return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    NSString *str = @"";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadUrl:) name:@"postUrl" object:str];
    
    [NSNotificationCenter defaultCenter] ;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.request]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
    // Do any additional setup after loading the view.
}

- (void)loadUrl:(NSNotification *)center {
    self.request = center.object;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.request]];
    [self.webView loadRequest:request];
}

- (void)configUI {
    [self.view addSubview:self.webView];
}


@end
