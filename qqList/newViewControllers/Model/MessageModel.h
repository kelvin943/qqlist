//
//  MessageModel.h
//  qqList
//
//  Created by MAX-TECH on 16/4/3.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "qqObjectBase.h"


typedef enum {
    kMessageModelTypeOther,
    kMessageModelTypeMe
} MessageModelType;

@interface MessageModel : qqObjectBase

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) MessageModelType type;
@property (nonatomic, assign) BOOL showTime;

+ (id)messageModelWithDict:(NSDictionary *)dict;

@end
