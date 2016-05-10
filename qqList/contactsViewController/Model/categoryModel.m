//
//  categoryModel.m
//  qqList
//
//  Created by MAX-TECH on 16/4/2.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "categoryModel.h"
#import "authorsModel.h"

@implementation categoryModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        //初始化好友列表
        NSMutableArray *tempArray = [NSMutableArray array];
        NSInteger onlineCout = 0;
        for (NSDictionary *dict in self.authors) {
            authorsModel  *author = [authorsModel authorsWithDict:dict];
            [tempArray addObject:author];
            if (author.followStatus) {
                onlineCout ++;
            }
        }
        self.authors = tempArray;
        //初始化在线人数
        self.onLine =onlineCout;
        //se
        self.isOpen = YES;
    }
    return self;
}
+ (instancetype)CategoryWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

//-(id)initwithCoder:(NSCoder *) aDecoder
//{
//    if (self==[super init]) {
//        self.category = [aDecoder decodeObjectForKey:@"category"];
//        self.onLine =   [aDecoder decodeIntegerForKey:@"onLine"] ;
//        self.authors =  [aDecoder decodeObjectForKey:@"authors"];
//        self.friendModel = [aDecoder decodeObjectForKey:@"friendModel"];
//        self.isOpen =   [aDecoder decodeBoolForKey:@"isOpen"];
//    }
//    return  self;
//}
//
//-(void) encodeWithCoder:(NSCoder *) aCoder
//{
//    [aCoder encodeObject:self.category forKey:@"category"];
//    [aCoder encodeInteger:self.onLine forKey:@"onLine"];
//    [aCoder encodeObject:self.authors forKey:@"authors"];
//    [aCoder encodeObject:self.friendModel forKey:@"friendModel"];
//    [aCoder encodeBool: self.isOpen forKey:@"isOpen"];
//
//}

@end
