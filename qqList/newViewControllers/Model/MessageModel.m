//
//  MessageModel.m
//  qqList
//
//  Created by MAX-TECH on 16/4/3.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

+ (id)messageModelWithDict:(NSDictionary *)dict
{
    MessageModel *message = [[self alloc] init];
    message.text = dict[@"text"];
    message.time = dict[@"time"];
    message.type = [dict[@"type"] intValue];
    
    return message;
}

@end
