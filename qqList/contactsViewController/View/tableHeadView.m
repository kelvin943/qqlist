//
//  tableHeadView.m
//  qqList
//
//  Created by MAX-TECH on 16/4/1.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "tableHeadView.h"

@implementation tableHeadView

+ (instancetype)makeItem{
    return [[[NSBundle mainBundle]loadNibNamed:@"tableHeadView" owner:self options:nil]firstObject];
}


@end
