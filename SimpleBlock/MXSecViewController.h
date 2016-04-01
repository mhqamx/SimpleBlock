//
//  MXSecViewController.h
//  SimpleBlock
//
//  Created by YISHANG on 16/4/1.
//  Copyright © 2016年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextBlock)(NSString *newStr);
typedef void(^ColorBlock)(UIColor *newColor);
typedef void(^ImageBlock)(UIImage *newImage);

typedef void(^TransBlock)(NSString *newStr, UIColor *newColor, UIImage *newImage);

@interface MXSecViewController : UIViewController
@property (nonatomic, copy) TextBlock  text_block;
@property (nonatomic, copy) ColorBlock color_block;
@property (nonatomic, copy) ImageBlock image_block;

@property (nonatomic, copy) TransBlock trans_block;
@end
