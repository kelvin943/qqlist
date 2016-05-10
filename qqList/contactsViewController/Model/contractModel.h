//
//  contractModel.h
//  qqList
//
//  Created by MAX-TECH on 16/4/3.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "qqObjectBase.h"
@class categoryModel;

@interface contractModel : qqObjectBase

@property (nonatomic,strong)  NSArray *  groupList;           //分组列表
//@property (nonatomic, strong) categoryModel *categoryInfo;

- (instancetype)initWithArray:(NSArray *)categoryArray;
+ (instancetype)GroupWithArray:(NSArray *)darr;

@end
