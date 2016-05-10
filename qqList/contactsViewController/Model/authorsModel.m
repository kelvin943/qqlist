//
//  authorsModel.m
//  qqList
//
//  Created by MAX-TECH on 16/4/2.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "authorsModel.h"
@implementation authorsModel


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        //在线类型随机
        self.netType = arc4random()%6;
        self.newsCount = 0;
        
    }
    return self;
}
+ (instancetype)authorsWithDict:(NSDictionary *)dict
{
     return [[self alloc] initWithDict:dict];
}

//-(id)initwithCoder:(NSCoder *) aDecoder
//{
//    if (self==[super init]) {
//        self.id = [aDecoder decodeObjectForKey:@"id"];
//        self.nickname =   [aDecoder decodeObjectForKey:@"nickname"] ;
//        self.intro =  [aDecoder decodeObjectForKey:@"intro"];
//        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
//        self.subscriptionNum = [aDecoder decodeObjectForKey:@"subscriptionNum"];
//        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
//        self.followStatus =   [aDecoder decodeBoolForKey:@"followStatus"];
//        self.netType =  [aDecoder decodeIntForKey:@"netType"] ;
//        
//    }
//    return  self;
//}
//
//-(void) encodeWithCoder:(NSCoder *) aCoder
//{
//    [aCoder encodeObject:self.id forKey:@"id"];
//    [aCoder encodeObject:self.nickname forKey:@"nickname"];
//    [aCoder encodeObject:self.intro forKey:@"intro"];
//    [aCoder encodeObject:self.avatar forKey:@"avatar"];
//    [aCoder encodeObject:self.subscriptionNum forKey:@"subscriptionNum"];
//    [aCoder encodeObject:self.avatar forKey:@"avatar"];
//    [aCoder encodeBool:self.followStatus forKey:@"followStatus"];
//    [aCoder encodeInt: self.netType forKey:@"netType"];
//    
//}

@end
