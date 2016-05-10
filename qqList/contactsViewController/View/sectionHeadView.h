//
//  sectionHeadView.h
//  qqList
//
//  Created by MAX-TECH on 16/4/2.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderViewDelegate;

@interface sectionHeadView : UIView {
    
}
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *flagBtn;
@property (nonatomic, retain) UILabel *onlineMumLabel;
@property (nonatomic, retain) UIView *BottomLine;


@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) BOOL opened;

@property (nonatomic, assign) id <HeaderViewDelegate> delegate;
-(id)initWithFrame:(CGRect)frame title:(NSString*)title section:(NSInteger)sectionNumber OnLineString: (NSString*)onlineStr opened:(BOOL)isOpened delegate:(id<HeaderViewDelegate>)delegate;

@end

@protocol HeaderViewDelegate <NSObject>

@optional
-(void)sectionHeaderView:(sectionHeadView*)sectionHeaderView sectionClosed:(NSInteger)section;

-(void)sectionHeaderView:(sectionHeadView*)sectionHeaderView sectionOpened:(NSInteger)section;
@end