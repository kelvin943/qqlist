//
//  FunctionButton.m
//  qqList
//
//  Created by MAX-TECH on 16/4/1.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "FunctionButton.h"

@implementation FunctionButton



#pragma mark - overwrite
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}



/**
 * 自定义按钮图片与文字的位置  图片在上  文字在下
 */
-(void)layoutSubviews{
    
    [super layoutSubviews];
//    CGFloat imageY = 5;
//    CGFloat imageW = self.bounds.size.height * 0.7;
//    CGFloat imageX = (self.bounds.size.width-imageW)*0.5;
//    CGFloat imageH = self.bounds.size.height * 0.7;
//    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
//    
//    CGFloat labelY = imageH + imageY;
//    CGFloat labelH = self.bounds.size.height - labelY -imageY;
//    self.titleLabel.frame = CGRectMake(0, labelY, self.bounds.size.width, labelH);
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
        CGFloat imageY = 5;
        CGFloat imageW = self.bounds.size.width * 0.4;
        CGFloat imageH = self.bounds.size.height * 0.45;
        CGFloat imageX = (self.bounds.size.width-imageW)*0.5;
    
        self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
        CGFloat labelY = imageH + imageY;
        CGFloat labelH = self.bounds.size.height - labelY;
        self.titleLabel.frame = CGRectMake(0, labelY, self.bounds.size.width, labelH);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

}

@end
