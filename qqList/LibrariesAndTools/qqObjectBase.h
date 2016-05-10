//
//  qqObjectBase.h
//  qqList
//
//  Created by MAX-TECH on 16/4/3.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface qqObjectBase : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger tag;

+ (id)create;
- (BOOL)saveToFile:(NSString *)path;
+ (id)loadFromFile:(NSString *)path;

-(id)initWithCoder:(NSCoder *)aDecoder;
@end
