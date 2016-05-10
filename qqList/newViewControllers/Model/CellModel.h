//
//  CellModel.h
//  qqList
//
//  Created by MAX-TECH on 16/4/3.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "qqObjectBase.h"


@class MessageModel;

#define textPadding 15

@interface CellModel : qqObjectBase


@property (nonatomic, strong) MessageModel *message;

@property (nonatomic, assign, readonly) CGRect timeFrame;
@property (nonatomic, assign, readonly) CGRect iconFrame;
@property (nonatomic, assign, readonly) CGRect textFrame;
@property (nonatomic, assign, readonly) CGFloat cellHeght;

@end