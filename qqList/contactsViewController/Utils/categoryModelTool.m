//
//  categoryModelTool.m
//  qqList
//
//  Created by MAX-TECH on 16/4/2.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "categoryModelTool.h"
#import "HttpTool.h"
#import "categoryModel.h"
#import "contractModel.h"

@implementation categoryModelTool

+ (void)getQQGroupListWithSuccessBlock:(Successed)successed
{
    [HttpTool get:@"http://f.wallstcn.com/news.json" params:nil success:^(id json) {
        NSArray *groupList = (NSArray *) json;
        //将数据转换为模型
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in groupList) {
            categoryModel * categoryInfo = [categoryModel CategoryWithDict:dict];
            [tempArray addObject:categoryInfo];
        }
        groupList = [tempArray copy];
        contractModel *contract = [contractModel GroupWithArray:groupList];

        
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* documentDirectory = paths[0];
        NSString* fullPath =  [documentDirectory stringByAppendingString:@"/contract"];
        contractModel * localContract= [contractModel loadFromFile:fullPath];
        //本地读取数据和服务器不一样更新本地数据
        if (![localContract isEqual:contract]) {
            NSFileManager* fileManager = [NSFileManager defaultManager];

            [fileManager removeItemAtPath:fullPath error:nil];
            [fileManager createFileAtPath:fullPath contents:nil attributes:nil];
            [contract saveToFile:fullPath ];
            successed(contract);
        }
        else//不需要更新数据
        {
            successed(nil);
        }
    } failure:^(NSError *error) {
         NSLog(@"Error: %@", error);
    }];
    

}


@end
