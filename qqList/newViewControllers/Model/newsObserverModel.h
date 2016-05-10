//
//  newsObserverModel.h
//  qqList
//
//  Created by MAX-TECH on 16/4/4.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "qqObjectBase.h"

@interface newsObserverModel : qqObjectBase

@property (nonatomic,strong)  NSString *  name;
@property (nonatomic,strong)  NSMutableArray *  newsArray;           //分组列表
@end
