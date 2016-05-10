//
//  categoryModelTool.h
//  qqList
//
//  Created by MAX-TECH on 16/4/2.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^Successed)(id obj);
@interface categoryModelTool : NSObject

+ (void)getQQGroupListWithSuccessBlock:(Successed)successed;

@end
