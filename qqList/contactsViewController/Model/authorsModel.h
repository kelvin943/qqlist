//
//  authorsModel.h
//  qqList
//
//  Created by MAX-TECH on 16/4/2.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "qqObjectBase.h"

@interface authorsModel : qqObjectBase

enum {
    netTypeWifi  = 0,
    netTypePhone = 1,
    netTypePC    = 2,
    netType2G    = 3,
    netType3G    = 4,
    netType4G    = 5

};
typedef int NetType;

@property (nonatomic, strong) NSString *id;    // 昵称
@property (nonatomic, strong) NSString *nickname;    // 昵称
@property (nonatomic, strong) NSString *intro;       // 签名
@property (nonatomic, strong) NSString *avatar;      // 头像
@property (nonatomic, strong) NSString *subscriptionNum;      
@property (nonatomic, assign) BOOL followStatus;   // 是否在线
@property (nonatomic, assign) NetType   netType;   // 是否类型

@property (nonatomic, assign) NSInteger   newsCount;   // 新消息个数

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)authorsWithDict:(NSDictionary *)dict;

//-(id)initwithCoder:(NSCoder *) aDecoder;
//-(void) encodeWithCoder:(NSCoder *) aCoder;
@end
