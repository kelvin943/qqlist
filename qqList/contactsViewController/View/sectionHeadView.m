//
//  sectionHeadView.m
//  qqList
//
//  Created by MAX-TECH on 16/4/2.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "sectionHeadView.h"
#import "categoryModel.h"

@implementation sectionHeadView
-(id)initWithFrame:(CGRect)frame title:(NSString*)title section:(NSInteger)sectionNumber OnLineString: (NSString*)onlineStr opened:(BOOL)isOpened delegate:(id)aDelegate{
    if (self = [super initWithFrame:frame]) {
        
        UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc] initWithTarget: self
                action:@selector(toggleAction:)] ;
        [self addGestureRecognizer:tapGesture];
        self.userInteractionEnabled = YES;
        self.section = sectionNumber;
        self.delegate = aDelegate;
        self.opened = isOpened;

        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = title;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
        
        //展开图标
        self.flagBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [self.flagBtn setImage:[UIImage imageNamed:@"carat.png"] forState:UIControlStateNormal];
        [self.flagBtn setImage:[UIImage imageNamed:@"carat-open.png"] forState:UIControlStateSelected];
        self.flagBtn.userInteractionEnabled = NO;
        self.flagBtn.selected = isOpened;
        [self addSubview:self.flagBtn];
        
        //在线人数
        self.onlineMumLabel = [[UILabel alloc] init];
        self.onlineMumLabel.textAlignment = NSTextAlignmentRight;
        self.onlineMumLabel.textColor = [UIColor lightGrayColor];
        self.onlineMumLabel.font = [UIFont systemFontOfSize:13.0];
        self.onlineMumLabel.text = onlineStr;
        [self addSubview:self.onlineMumLabel];
        
        
        self.BottomLine = [[UIView alloc] init];
        self.BottomLine.backgroundColor=[UIColor lightGrayColor];
        if (!isOpened) {
             self.BottomLine.alpha= 0.2;
        }
        else{
             self.BottomLine.alpha= 0;
        }
       
        [self addSubview:self.BottomLine];
    
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//布局
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //组名
    CGRect titleLabelFrame = self.bounds;
    titleLabelFrame.origin.x += 35.0;
    titleLabelFrame.size.width -= 35.0;
    CGRectInset(titleLabelFrame, 0.0, 5.0);
    self.titleLabel.frame =titleLabelFrame;
    
    self.flagBtn.frame = CGRectMake(0.0, 0.0, 35.0, 35.0);
    self.onlineMumLabel.frame = CGRectMake(self.frame.size.width - 70, 0, 60, self.frame.size.height);
    self.BottomLine.frame =CGRectMake(0,self.frame.size.height -1,self.frame.size.width,1);

}



-(IBAction)toggleAction:(id)sender {
    
    self.flagBtn.selected = !self.flagBtn.selected;
    
    if (self.flagBtn.selected) {
        if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
            [self.delegate sectionHeaderView:self sectionOpened:self.section];
            self.BottomLine.alpha= 0;
        }
    }
    else {
        if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
            [self.delegate sectionHeaderView:self sectionClosed:self.section];
            self.BottomLine.alpha= 0.2;
        }
    }
    
}
@end
