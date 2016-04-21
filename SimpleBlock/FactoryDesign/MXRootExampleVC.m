//
//  MXRootExampleVC.m
//  SimpleBlock
//
//  Created by YISHANG on 16/4/19.
//  Copyright © 2016年 YISHANG. All rights reserved.
//

#import "MXRootExampleVC.h"

@interface MXRootExampleVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView  *mainTableView;
@property (nonatomic, strong) NSMutableArray  *titleArray;
@property (nonatomic, strong) NSMutableArray  *classesArray;

@end

@implementation MXRootExampleVC

#pragma mark - Lazy initlization

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
    }
    return _mainTableView;
}

/*
- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)classesArray {
    if (!_classesArray) {
        _classesArray = [NSMutableArray array];
    }
    return _classesArray;
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainTableView];
    
    /**
     *  数组创建另一种方式 懒加载之外的
     */
    self.titleArray = @[].mutableCopy;
    self.classesArray = @[].mutableCopy;
    
    
    [self addTitle:@"Model" Class:@"MXModelExample"];
    [self addTitle:@"Text" Class:@"MXTextExample"];
    [self addTitle:@"Image" Class:@"MXImageExample"];
    
    [self.mainTableView reloadData];
}

- (void)addTitle:(NSString *)newTitle Class:(NSString *)newClass {
    [self.titleArray addObject:newTitle];
    [self.classesArray addObject:newClass];
}

#pragma mark ---------- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tag = @"MX";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tag];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:tag];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *classStr = self.classesArray[indexPath.row];
    Class class = NSClassFromString(classStr);
    if (class) {
        UIViewController *VC = class.new;
        VC.title = self.titleArray[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
    }
    [self.mainTableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
