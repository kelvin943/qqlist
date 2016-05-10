//
//  categoryModel.h
//  qqList
//
//  Created by MAX-TECH on 16/4/2.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "qqObjectBase.h"

@class authorsModel;
@interface categoryModel : qqObjectBase
@property (nonatomic,strong)  NSDictionary *category;       //分组名
@property (nonatomic,assign)  NSInteger  onLine;            //在线人数
@property (nonatomic,strong)  NSArray *  authors;           //分组列表
@property (nonatomic, strong) authorsModel *friendModel;
@property (nonatomic, assign) BOOL isOpen;

@property (nonatomic,strong) NSMutableArray *indexPaths;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)CategoryWithDict:(NSDictionary *)dict;

@end
