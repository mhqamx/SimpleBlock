//
//  MXKit.h
//  SimpleBlock
//
//  Created by YISHANG on 16/4/13.
//  Copyright © 2016年 YISHANG. All rights reserved.
//

// MXKit 跨向架构师的第一步
// 分层管理框架, 各个功能层之间不能有太多依赖
// 网络层
// 数据层 (FMDB) SQL
// Cache层
// UI层

// 一些设置 Until Config全局设置等
// 待完善 架构设计需要对api接口设计, 函数方法的抽取, 连式编程思路
// 低耦合 , 高内聚
// 网络层API接口设计尽量避免使用block block内的作用域会将所有对象引用计数+1, 会延长对象的生命周期, 导致retain cycle, 使用__weak self 来避免
// 使用代理模式来切换API接口, 通过不同的样式来对应不同的业务需求
// 使用APIManager来管理API接口, 实现各种环境之间的切换