//
//  contractModel.m
//  qqList
//
//  Created by MAX-TECH on 16/4/3.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "contractModel.h"
#import "categoryModel.h"

@implementation contractModel

- (instancetype)initWithArray:(NSArray *)categoryArray{
    if (self = [super init]) {
        self.groupList = categoryArray;
    }
    return self;
}
+ (instancetype)GroupWithArray:(NSArray *)darr
{
    return [[self alloc] initWithArray:darr];
}

@end
